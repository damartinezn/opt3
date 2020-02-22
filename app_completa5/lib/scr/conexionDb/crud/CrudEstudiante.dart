
import 'package:app_completa5/scr/conexionDb/ConexionDb.dart';
import 'package:app_completa5/scr/modelo/Estudiante.dart';

class CrudEstudiante{

  ConexionDb conn = new ConexionDb();

  //Insertar un registro en la tabla
  Future<Estudiante> crearEstudiante(Estudiante est) async{
    var dbConn = await conn.db;
    est.id = await dbConn.insert('estudiante', est.toJson());
    print('Estudiante Creado');
    return est;
  }

  //Recuperar lista de estudiante 
  Future<List<Estudiante>> obtenerTodos() async{
    var dbConn = await conn.db;
    List<Map> json = await dbConn.query('estudiante', columns: ['id', 'nombre', 'apellido', 'correo', 'celular', 'genero', 'fechaNacimiento', 'becado']);
    List<Estudiante> estudiantes = [];
    if(json.length > 0){
      print('Existen estudiantes');
      for(int i = 0; i < json.length; i++){
        estudiantes.add(Estudiante.fromJson(json[i]));
      }
    }
    print('Se obtuvieron los estudiantes');
    return estudiantes;
  }

  //Eliminar un estudiante
  Future<int> eliminarEstudiante(int id) async{
    var dbConn = await conn.db;
    print('Se elimino el estudiante');
    return await dbConn.delete('estudiante', where: 'id=? and becado=?', whereArgs: [id, 0]);
  }

  //Actualizar un estudiante
  Future<int> actualizarEstudiante(Estudiante est) async{
    var dbConn = await conn.db;
    print('Se actualizo el estudiante');
    return await dbConn.update('estudiante', est.toJson(), where: 'id=?', whereArgs: [est.id]);
  }

  //Cerrar la conexion
  Future close() async{
    var dbConn = await conn.db;
    dbConn.close();
  }
}