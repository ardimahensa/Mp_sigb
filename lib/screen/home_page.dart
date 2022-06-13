// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigb/page/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, String? name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: Auth user dari firebase
  final user = FirebaseAuth.instance.currentUser!;
  //TODO: text controller
  final TextEditingController _produkController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  //TODO: Memanggil collection database firestore
  final CollectionReference _gabah =
      FirebaseFirestore.instance.collection('gabah');

  //TODO: Fungsi untuk floating action button
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _produkController.text = documentSnapshot['produk'];
      _stokController.text = documentSnapshot['stok'].toString();
      _beratController.text = documentSnapshot['berat'];
      _hargaController.text = documentSnapshot['harga'].toString();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              //TODO: Form input
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _produkController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                ),
              ),
              TextField(
                controller: _stokController,
                decoration: const InputDecoration(
                  labelText: 'Banyak Stok',
                ),
              ),
              TextField(
                controller: _beratController,
                decoration: const InputDecoration(
                  labelText: 'Berat Untuk Stok',
                ),
              ),
              TextField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga per Stok',
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //TODO: Tombol untuk Create dan Update
              ElevatedButton(
                child: Text(action == 'create' ? 'Create' : 'Update'),
                onPressed: () async {
                  final String? produk = _produkController.text;
                  final int? stok = int.tryParse(_stokController.text);
                  final String? berat = _beratController.text;
                  final int? harga = int.tryParse(_hargaController.text);
                  if (produk != null &&
                      stok != null &&
                      berat != null &&
                      harga != null) {
                    if (action == 'create') {
                      //TODO: Mengirim ke collection
                      await _gabah.add({
                        "produk": produk,
                        "stok": stok,
                        "berat": berat,
                        "harga": harga
                      });
                    }

                    if (action == 'update') {
                      //TODO: Perintah update
                      await _gabah.doc(documentSnapshot!.id).update({
                        "produk": produk,
                        "stok": stok,
                        "berat": berat,
                        "harga": harga
                      });
                    }

                    //TODO: Menghapus textfield
                    _produkController.text = '';
                    _stokController.text = '';
                    _beratController.text = '';
                    _hargaController.text = '';

                    //TODO: Menghilangkan bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  //TODO: Fungsi untuk delete
  Future<void> _deleteProduct(String gabahId) async {
    await _gabah.doc(gabahId).delete();

    //TODO: Notifikasi jika data berhasil terhapus
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        backgroundColor: ColorPalette.bondyBlue.withOpacity(0.5),
        elevation: 0,
        actions: [
          //TODO: Tombol untuk logout
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showConfirmDialog(
                  context, "Yakin mau Logout ?", "Nanti deh", "Iya", () {
                Navigator.of(context).pop();
              }, () {
                Navigator.of(context).pop();
                FirebaseAuth.instance.signOut();
              });
            },
          ),
        ],
      ),
      backgroundColor: ColorPalette.grey,
      body: Column(
        children: [
          Container(
            height: 50,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                  color: const Color(0xff000000).withOpacity(0.15),
                ),
              ],
              color: ColorPalette.bondyBlue.withOpacity(0.5),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Akun : ' + user.email!,
                style: GoogleFonts.workSans(
                    color: ColorPalette.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          //TODO: Pemanggilan dokumen collection dari firestore
          StreamBuilder(
            stream: _gabah.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(15),
                      child: ListTile(
                        title: Text(
                          documentSnapshot['produk'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          // alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Stok Tersedia : ' +
                                        documentSnapshot['stok'].toString() +
                                        ' ' +
                                        documentSnapshot['berat'],
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Harga : Rp' +
                                        documentSnapshot['harga'].toString() +
                                        '/' +
                                        documentSnapshot['berat'],
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        isThreeLine: true,
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            children: [
                              //TODO: Icon untuk Update
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot),
                                color: Colors.blueAccent,
                              ),
                              //TODO: Icon untuk Delete
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteProduct(documentSnapshot.id),
                                  color: Colors.redAccent),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      //TODO: tombol floating
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        backgroundColor: const Color.fromARGB(229, 236, 174, 40),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
