import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<dynamic> allData = [];
  Map<String, List<dynamic>> groupedData = {}; // Group data by date
  TextEditingController _filterController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  DateTime? selectedDate;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  int currentPage = 0;
  final int rowsPerPage = 100;
  bool isLoading = false; // Flag to show loader
  String totalView = "0";

  @override
  void initState() {
    super.initState();
    fetchData();
    // Listen for changes in search input
    _searchController.addListener(() {
      filterDataBySearch(_searchController.text);
    });
  }

  Future<void> fetchData() async {
    await http.get(Uri.parse("https://lottery.khagrachariplus.com/api/addView"));
    setState(() {
      isLoading = true; // Show loader when fetching data
    });

    String url = 'https://lottery.khagrachariplus.com/api/lottery-list';

    // If a date is selected, add it to the URL
    if (selectedDate != null) {
      String formattedDate = dateFormatter.format(selectedDate!);
      url = '$url?date=$formattedDate';
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          allData = json.decode(response.body)['data'];
          groupedData = _groupDataByDate(allData);
          filterDataBySearch(_searchController.text); // Apply search filter after fetching
          isLoading = false; // Hide loader after data is fetched
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Hide loader on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            content: Text('আপনি যে তারিখ দিয়েছেন সে তারিখে কিছু পাওয়া যায়নি')),
      );
    }
  }

  // Group data by date
  Map<String, List<dynamic>> _groupDataByDate(List<dynamic> data) {
    Map<String, List<dynamic>> grouped = {};

    // Group data by date
    for (var item in data) {
      String date = item['date'];
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(item);
    }

    return grouped;
  }

  void filterDataBySearch(String query) {
    setState(() {
      groupedData.forEach((date, items) {
        groupedData[date] = items.where((item) {
          return item['sl'].toString().contains(query) ||
              item['code'].toString().contains(query) ||
              item['mobile'].toString().contains(query) ||
              item['color'].toString().contains(query) ||
              item['siriz'].toString().contains(query) ||
              item['prize_name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              item['date'].toString().contains(query);
        }).toList();
      });
    });
  }

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    groupedData.forEach((date, items) {
      for (var item in items) {
        rows.add(DataRow(cells: [
          DataCell(Text(item['sl'].toString(), style: TextStyle(color: Colors.deepPurple))),
          DataCell(Text(item['code'], style: TextStyle(color: Colors.deepPurple))),
          DataCell(Text(item['mobile'], style: TextStyle(color: Colors.blue))),
          DataCell(Text(item['color'], style: TextStyle(color: Colors.pink))),
          DataCell(Text(item['siriz'], style: TextStyle(color: Colors.teal))),
          DataCell(Text(item['prize_name'], style: TextStyle(color: Colors.orange))),
          DataCell(Text(item['date'], style: TextStyle(color: Colors.orange))),
        ]));
      }
    });

    // Paginate the rows (use `currentPage` and `rowsPerPage`)
    return rows.skip(currentPage * rowsPerPage).take(rowsPerPage).toList();
  }

  void _changePage(int offset) {
    setState(() {
      currentPage += offset;
      if (currentPage < 0) currentPage = 0;
      if (currentPage > (groupedData.values.expand((x) => x).length / rowsPerPage).ceil() - 1) {
        currentPage = (groupedData.values.expand((x) => x).length / rowsPerPage).ceil() - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('সম্প্রীতি বিজয় মেলা ২০২৪\n প্রতিদিনের লটারি ফলাফল', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
          onRefresh: () async => fetchData(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("  তারিখ দিয়ে সার্চ করুন", style: TextStyle(color: Colors.teal)),
                          TextField(
                            controller: _filterController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.teal)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.teal)),
                              hintText: "তারিখ সিলেক্ট করুন",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: const Icon(Icons.calendar_today, color: Colors.teal),
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("সার্চ করুন", style: TextStyle(color: Colors.teal)),
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "4545565",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.teal)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.teal)),
                              prefixIcon: const Icon(Icons.search, color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DataTable(
                      columns: const [
                        DataColumn(label: Text('ক্রঃ নং', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('টিকেট নাম্বার', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('মোবাইল নং', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('কালার', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('সিরিজ', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('পুরস্কারের নাম', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('তারিখ', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: _buildRows(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.teal),
                    onPressed: () => _changePage(-1),
                  ),
                  Text('Page ${currentPage + 1}', style: TextStyle(color: Colors.teal, fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.teal),
                    onPressed: () => _changePage(1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _filterController.text = dateFormatter.format(selectedDate!);
      });

      // Fetch the data again with the selected date filter
      fetchData();
    }
  }
}
