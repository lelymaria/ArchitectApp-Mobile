import 'package:architect_app/views/main_page.dart';
import 'package:architect_app/views/professional/proposal_approved.dart';
import 'package:architect_app/views/professional/proposal_rejected.dart';
import 'package:architect_app/views/professional/proposal_submit.dart';
import 'package:flutter/material.dart';

class ProposalScreen extends StatefulWidget {
  @override
  _ProposalScreenState createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Proposal Saya",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(initialPage: 3)),
                );
              },
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              // indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              indicatorColor: Colors.amber,
              tabs: [
                Tab(text: "Submit"),
                Tab(text: "Disetujui"),
                Tab(text: "Ditolak"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new ProposalSubmit(),
              new ProposalApproved(),
              new ProposalRejected(),
            ],
          ),
        ),
      ),
    );
  }
}
