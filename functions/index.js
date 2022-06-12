const functions = require("firebase-functions");

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

const firestore=admin.firestore();


class User{
	constructor(uid,name,email){
    this.uid=uid;
    this.name=name;
    this.email=email;
    }

    fromMap(map) {
        return new User(
            map['uid']??"",
            map['displayName']??"",
            map['email']??"",
        );
      }

    toMap(){
        return{
            "uid":this.uid,
            "name":this.name,
            "email":this.email,
            "role":"user",
        }
    }
}

exports.userAdded= functions.auth.user().onCreate(async user=>{
    console.log('Adding user');
    var newUser=new User().fromMap(user);
    await firestore.collection('user').doc(newUser.uid).set(newUser.toMap());
    return Promise.resolve();
});

exports.userDeleted= functions.auth.user().onDelete(async user=>{
    console.log('Deleting user');
    var deletedUser=new User().fromMap(user);
    console.log(deletedUser.uid);
    console.log(deletedUser.email);
    await firestore.collection('user').doc(deletedUser.uid).delete();
    return Promise.resolve()
});