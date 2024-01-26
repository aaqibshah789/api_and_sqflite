
class ModelStudent{
  int? id;
  String? name ;

  ModelStudent({required this.id,required this.name,});
  Map<String, dynamic> toMap()=>{
    "id":id,
    "name":name,};
  factory ModelStudent.ModelOjjectFromMap(Map<String,dynamic>map_value)=>
      ModelStudent(
        id:map_value["id"],
        name:map_value["name"],
      );
}
