import 'dart:developer';

import 'package:flutter/material.dart';

import 'contact.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //List of contact
  List<Contact> contacts = List.empty(growable: true);
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Contacts List',style: TextStyle(fontSize: 30),) ,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
             TextFormField(
              controller:nameController,
              keyboardType: TextInputType.text,

              decoration: const InputDecoration(
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                } else {
                  return null;
                }
              }
            ),
            const SizedBox(height: 20,),
             TextFormField(
               controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: const InputDecoration(
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Contact';
                   } else {
                     return null;
                   }
                 }
            ),
            const SizedBox(height: 20,),
            //Save button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  String name = nameController.text.trim();
                  String number = numberController.text.trim();

                  if(name.isNotEmpty && number.isNotEmpty){
                   setState(() {
                     nameController.text='';
                     numberController.text='';
                     contacts.add(Contact(name: name, number: number));
                   });

                  }

                }, child: const Text("Save")),

                //Update button
                ElevatedButton(onPressed: (){
                  String name = nameController.text.trim();
                  String number = numberController.text.trim();

                    if(name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        numberController.text = '';
                        contacts[selectedIndex].name=name;
                        contacts[selectedIndex].number =number;
                       selectedIndex = 0;
                      });
                    }

                },child: const Text("Update")),
              ],
            ),

            //validation contactList
            const SizedBox(height: 20,),
            contacts.isEmpty? const Text('No Contact yet..',
              style: TextStyle(fontSize: 22),)
            //itemList
           : Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                  itemBuilder: (context,index) => getRow(index)),
            )
          ],
        ),
      ),
    );
  }
//item
 Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2==0 ? Colors.deepOrangeAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(contacts[index].name[0],style: const TextStyle(fontWeight: FontWeight.bold),), //name [first position letter]show

        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name,style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text(contacts[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  nameController.text=contacts[index].name;
                  numberController.text=contacts[index].number;
                setState(() {
                  selectedIndex =index;
                  log('data: $selectedIndex');

                });
                },
                  child: const Icon(Icons.edit)),
              const SizedBox(width: 10,),
              InkWell(
                  onTap: (){
                    setState(() {
                      contacts.removeAt(index);

                    });

                  },
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
 }
}
