class Not {
  int notID;
  int kategoriID;
  String kategoriBaslik;
  String notBaslik;
  String notIcerik;
  String notTarih;
  int notOncelik;


Not(this.kategoriBaslik,this.notBaslik,this.notIcerik,this.kategoriID,this.notOncelik,this.notTarih);
Not.witfhID(this.notID, this.kategoriBaslik,this.notBaslik,this.notIcerik,this.kategoriID,this.notOncelik,this.notTarih);


Map<String,dynamic> toMap(){

var map=Map<String,dynamic>();
map['kategoriBaslik']=kategoriBaslik;
map['notBaslik']=notBaslik;
map['notIcerik']=notIcerik;
map['notTarih']=notTarih;
map['notOncelik']=notOncelik;
map['kategoriID']=kategoriID;
map['notID']=notID; 
return map;
}

Not.fromMap(Map<String,dynamic> map){
this.kategoriBaslik=map['kategoriBaslik'];
this.notBaslik=map['notBaslik'];
this.notIcerik=map['notIcerik'];
this.notTarih=map['notTarih'];
this.notOncelik=map['notOncelik'];
this.kategoriID=map['kategoriID'];
this.notID=map['notID'];



}

 @override
  String toString() {
    return 'Not{notID: $notID, kategoriID: $kategoriID, notBaslik: $notBaslik, notIcerik: $notIcerik, notTarih: $notTarih, notOncelik: $notOncelik}';
  }


}
