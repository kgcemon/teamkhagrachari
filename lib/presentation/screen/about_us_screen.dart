import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'Assets/images/hasanul.jpg',
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'MD Hasanul Karim',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Text(
                      'Founder & Proprietor',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Khagrachari Plus',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your all-in-one solution for various services and activities within the Khagrachari district.',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
              const SizedBox(height: 20),
              buildSectionTitle('Our Mission'),
              buildSectionContent(
                'At Khagrachari Plus, our mission is simple: to empower the community by providing a convenient platform where individuals of all ages can access essential services and resources with ease. We aim to bridge the gap between service providers and users, fostering a stronger sense of connectivity and support within our district.',
              ),
              const SizedBox(height: 20),
              buildSectionTitle('Our Vision'),
              buildSectionContent(
                'We envision a future where every resident of Khagrachari can fulfill their needs and aspirations through the convenience of our app. By leveraging technology, we strive to enhance accessibility, efficiency, and inclusivity in the delivery of services, ultimately contributing to the overall development and well-being of our community.',
              ),
              const SizedBox(height: 20),
              buildSectionTitle("Founder's Inspiration"),
              buildSectionContent(
                "Khagrachari Plus is the brainchild of Hasanul Karim, a visionary entrepreneur with a deep love for his district. Inspired by the beauty and resilience of Khagrachari and fueled by a desire to make a tangible difference, Hasanul embarked on a journey to create a platform that would redefine convenience and connectivity for the community. With a solid educational foundation, Hasanul Karim completed his Bachelor of Business Administration (BBA) and Master of Business Administration (MBA) in the management department at Rangamati Science & Technology University. His educational background complements his entrepreneurial spirit, enabling him to lead with knowledge and innovation in his quest to make a positive impact on his beloved Khagrachari district.",
              ),
              const SizedBox(height: 20),
              buildSectionTitle("Founder's Commitment"),
              buildSectionContent(
                "Driven by a passion for service and a relentless pursuit of excellence, Hasanul Karim brings years of entrepreneurial experience and a profound understanding of Khagrachari's unique needs to the forefront of Khagrachari Plus. His unwavering dedication to the district's development serves as the guiding force behind every aspect of the app's design and functionality.",
              ),
              const SizedBox(height: 20),
              buildSectionTitle('What We Offer'),
              buildSectionContent(
                'Khagrachari Plus offers a comprehensive suite of services designed to meet the diverse needs of our users:',
              ),
              buildBulletPoint(
                  'Blood Donation Network: Urgently need blood? Our app connects you with willing donors within Khagrachari, ensuring prompt access to life-saving transfusions.'),
              buildBulletPoint(
                  'Marketplace: Discover and trade goods and services within Khagrachari effortlessly. Whether you\'re seeking a specific item or looking to sell, our marketplace provides a seamless platform for transactions.'),
              buildBulletPoint(
                  'Matrimonial Services: Searching for your perfect match? Our app facilitates meaningful connections, helping individuals find compatible partners for marriage within our vibrant community.'),
              buildBulletPoint(
                  'Service Directory: From healthcare providers to household services, our extensive directory offers a convenient way to explore and engage with various service providers in Khagrachari.'),
              buildSectionContent(
                'But that\'s not all! We offer many other services too! If there\'s something you need help with in Khagrachari, chances are we can help you find it here.',
              ),
              const SizedBox(height: 20),
              buildSectionTitle('Join Us'),
              buildSectionContent(
                'Come be a part of the Khagrachari Plus community! Download our app today and see how we can make your life easier.',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),textAlign: TextAlign.justify,
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.justify,
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.justify,),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
