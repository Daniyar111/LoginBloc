import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class Bloc extends Object /*simple class where is no any method*/ with Validators{

  // Stream is the pipe where events can be customized
  // Observable -> Stream
  // Subject -> StreamController
  // BehaviorSubject -> broadcast Stream controller that captures the latest item and emits that as first item to any new listener
  // StreamTransformer where we can manage each data in the sink


  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //Observable is the wrapper class which combines all the streams and stream transformers
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit(){
    final validEmail = _email.value;
    final validPassword = _password.value;
    
    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  void dispose(){
    _email.close();
    _password.close();
  }

}