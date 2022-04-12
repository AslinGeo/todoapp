class Todo{
  int? id ;
  String? name;
  String? status;

  todoMap(){
    var mapping = Map<String, dynamic>();
    mapping['id']=id ;
     mapping['name']=name;
     mapping['status']=status;
  return mapping;
  }
}