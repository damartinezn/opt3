import 'dart:io';

import 'package:app_completa5/scr/modelo/Log.dart';
import 'package:app_completa5/scr/preferencias/PreferenciaUsuario.dart';
import 'package:app_completa5/scr/servicio/LogServicio.dart';
import 'package:app_completa5/scr/servicio/MensajeServicio.dart';
import 'package:app_completa5/scr/vistas/estudiante/CrearEstudiante.dart';
import 'package:app_completa5/scr/vistas/usuario/UsuarioPage.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class InicioPage extends StatelessWidget {

  //Instancio el servicio para persistir en firebase 
  final logProvider =new LogProvider();
  Log log = new Log();
  //Instancia para recuperar la preferencia de los usuarios y guardarla en firebase
  final prefs = new PreferenciaUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(context),
      body: _body(context),
    );

  }

  //Codigo appbar
  _appBar(){
    return AppBar(
      title: Text('Modulos del Sistema',
      style: TextStyle(
        color: Colors.white
      ),
      textAlign: TextAlign.center,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  //codigoDrawer
  _drawer(BuildContext context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.lightBlueAccent,
                    Colors.blue
                  ]
                )
              ),
              child: Column(
                children: <Widget>[
                  Icon(Icons.account_circle,
                  size: 110.0,
                  color: Colors.white,)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.lightBlue),
            title: Text(
              'Cerrar Sesion',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: (){
              Navigator.push(context, LoginPage.route());
              if(Platform.isAndroid){
                
                log.acceso = 'Logout';
                log.dispositivo = 'Android';
                var now = new DateTime.now();
                log.fecha = now.toString();
              }
              log.usuario = prefs.usuario;
              log.clave = prefs.clave;
              logProvider.crearLog(log);
            },
          )
        ],
      ),
    );
  }

  //Consumo del servicio con endpoint
  //Instancio el servicio
  final mensajeServicio = new MensajeServicio();
  //Método para obtener el mensaje del endpoint que deseeamos
  Future<String> obtenerMensajeServicio() async{
    String mensaje = await mensajeServicio.getData('mensajeGrupo07');
    return mensaje;
  }
  //body
  _body(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0,),
          //Msstramos el mensaje del servicio en un future builder dentro del center
          Center(
            child: FutureBuilder<String>(
              future: obtenerMensajeServicio(),
              builder: (context, AsyncSnapshot<String> snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data);
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          SizedBox(height: 50.0,),
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              color: Colors.lightBlue,
              padding: EdgeInsets.all(10.0),
              child: Text('Usuarios', style: TextStyle(
                color: Colors.white
              ),),
              onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => UsuarioPage()));
              },
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.lightBlue,
              padding: EdgeInsets.all(10.0),
              child: Text('Estudiantes', style: TextStyle(
                color: Colors.white,
              ),),
              onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => CrearEstudiantePage()));
              },
            ),
          )
        ],
      ),
    );
  }
}