import 'package:flutter/material.dart';
import '/utilities/breed.dart';
import '/services/http_request.dart';
import 'table_shimmer.dart';


class TableData extends StatefulWidget {

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  late Future<List<Breed>> _dataSourceFuture;
  int currentPage = 0;
  int rowsPerPage=10;
  HttpRequest httpRequest=HttpRequest();

  @override
  void initState() {
    super.initState();
    _dataSourceFuture = httpRequest.fetchBreeds(currentPage,rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Breed>>(
      future: _dataSourceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TableShimmerUi();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          List<Breed> breeds = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    dataRowMaxHeight:double.infinity,
                    columns: [
                      DataColumn(label: Expanded(child: Text('Bread Name',style:TextStyle(fontWeight:FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Bred For',style:TextStyle(fontWeight:FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Bread Group',style:TextStyle(fontWeight:FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Life Span',style:TextStyle(fontWeight:FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Temperament',style:TextStyle(fontWeight:FontWeight.bold)))),
                    ],
                    rows: breeds.map((breed) {
                      return DataRow(cells: [
                        DataCell(Expanded(child: Text(breed.name))),
                        DataCell(Expanded(child: Text(breed.bredFor))),
                        DataCell(Expanded(child: Text(breed.breedGroup))),
                        DataCell(Expanded(child: Text(breed.lifeSpan))),
                        DataCell(Expanded(child: Text(breed.temperament))),
                      ]);
                    }).toList(),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children:[
                      Text('${currentPage*10} - ${(currentPage+1)*rowsPerPage}',style:TextStyle(fontWeight:FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 15),
                        onPressed: () {
                          setState(() {
                            if(currentPage>0){
                              currentPage>0?currentPage--:null;
                              _dataSourceFuture = httpRequest.fetchBreeds(currentPage,rowsPerPage);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15),
                        onPressed: () {
                          setState(() {
                            currentPage++;
                            _dataSourceFuture = httpRequest.fetchBreeds(currentPage,rowsPerPage);
                          });
                        },
                      )
                    ]
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}



