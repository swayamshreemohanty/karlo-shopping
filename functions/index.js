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

// class Product{
// 	constructor(productId,productImageUrl,productName,productPrice,productDescription){
//     this.productId=productId;
//     this.productImageUrl=productImageUrl;
//     this.productName=productName;
//     this.productPrice=productPrice;
//     this.productDescription=productDescription;
//     }

//     fromMap(map) {
//         return new Product(
//             map['productId']??"",
//             map['productImageUrl']??"",
//             map['productName']??"",
//             map['productPrice']??"",
//             map['productDescription']??"",
//         );
//       }

//     toMap(){
//         return{
//             "productId":this.productId,
//             "productImageUrl":this.productImageUrl,
//             "productName":this.productName,
//             "productPrice":this.productPrice,
//             "productDescription":this.productDescription,
//         }
//     }
// }

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


// exports.addItem = functions.https.onRequest(async(request,response)=>{
//     try {
//         switch (request.method) {
           
//             case 'POST':
//                 const body= request.body;
//                 let product=new Product.fromMap(body)
//                 console.log(product)
//                 let collectionDoc=firestore.collection('AllItems');
//                 product.productId=collectionDoc.id;
//                 await collectionDoc.doc(product.productId).set()
//                 response.statusCode(200).send('message:"${product.productName} added to cart"');
//                 break;
          
//             default:
//                 response.statusCode(400).send('No method found');
//                 break;
//         }
//     } catch (error) {
//         console.log(error)
//         response.status(400).send('Error occured');          
//     }
// })