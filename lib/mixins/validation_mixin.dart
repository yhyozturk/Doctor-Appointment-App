class ValidationMixin {
  String validateTCNo(String value) {
    if (value.length != 11) {
      return "T.C. Kimlik Numarası 11 hane olmalıdır";
    }
    
    return null;
  }

  String validateFirstName(String value) {
    if (value.length < 2) {
      return "İsim en az iki karakter olmalıdır";
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 2) {
      return "Soyadı en az iki karakter olmalıdır";
    }
    return null;
  }

  String validateAdmin(String value) {
    if (value != "admin") {
      return "Hatalı yada eksik bilgi girdiniz";
    }
    return null;
  }
  String validatePassword(String value){
    if(value.length<4){
      return "En az 4 haneli olmalı";
    }
    return null;
  }
}
