abstract class BanglaConvertor{
  static String convertPrice(String price){
    List<String> bnNumber = ["১","২","৩","৪","৫","৬","৭","৮","৯","০"];
    List<String> enNumber = ["1","2","3","4","5","6","7","8","9","0"];
    for(int a=0; a<bnNumber.length; a++){
      price = price.replaceAll(enNumber[a], bnNumber[a]);
    }
    return price;
  }
}