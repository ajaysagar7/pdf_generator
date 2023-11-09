class PdfModel {
  final String name;
  final String address;
  final String phone;
  final String image;
  final List<PdfRowDataModel> pdfRowDataList;

  PdfModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
    required this.pdfRowDataList,
  });
}

class PdfRowDataModel {
  final String title;
  final String price;

  PdfRowDataModel({required this.title, required this.price});
}

List<PdfModel> pdfModels = [
  PdfModel(
    name: 'Ajay Sagar',
    address: 'Huppuguda',
    phone: '8686070044',
    image:
        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
    pdfRowDataList: [
      PdfRowDataModel(title: 'Food', price: '3000'),
      PdfRowDataModel(title: 'Cloth', price: '800'),
      PdfRowDataModel(title: 'Travel', price: '4500'),
      PdfRowDataModel(title: 'Rent', price: '1900'),
      PdfRowDataModel(title: 'Other', price: '1000'),
    ],
  ),
];

List<PdfModel> newPdfModelLists = List<PdfModel>.generate(20, (index) {
  return PdfModel(
    name: 'Name ${index + 1}',
    address: 'Address ${index + 1}',
    phone: 'Phone ${index + 1}',
    image: 'https://example.com/path/to/image${index + 1}.jpg',
    pdfRowDataList: [
      PdfRowDataModel(title: 'Food ${index + 1}', price: '${3000 + index}'),
      PdfRowDataModel(title: 'Cloth ${index + 1}', price: '${800 + index}'),
      PdfRowDataModel(title: 'Travel ${index + 1}', price: '${4500 + index}'),
      PdfRowDataModel(title: 'Rent ${index + 1}', price: '${1900 + index}'),
      PdfRowDataModel(title: 'Other ${index + 1}', price: '${1000 + index}'),
    ],
  );
});
