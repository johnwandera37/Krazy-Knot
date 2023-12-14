import 'dart:convert';
// import 'dart:html' as html;
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/export_files.dart';

class GuestRegistrationForm extends StatefulWidget {
  const GuestRegistrationForm({Key? key}) : super(key: key);

  @override
  _GuestRegistrationFormState createState() => _GuestRegistrationFormState();
}

class _GuestRegistrationFormState extends State<GuestRegistrationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _eventId;
  Map<String, dynamic> eventData = {};
  final String baseUrl = Constants.baseUrl;

  @override
  void initState() {
    super.initState();
    _eventId = _extractEventIdFromUrl();
    debugPrint('event id::::::::: $_eventId');
    if (_eventId != null) {
      fetchEventData();
    }
  }

  String? _extractEventIdFromUrl() {
    // String currentUrl = html.window.location.href;
    // Uri uri = Uri.parse(currentUrl);
    // return uri.queryParameters['eventId'];
  }

  Future<void> fetchEventData() async {
    final String eventUrl = '${baseUrl}event/getEventData?eventID=$_eventId';
    try {
      var response = await http.get(Uri.parse(eventUrl));
      debugPrint('${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          eventData = json.decode(response.body)['event'] ?? {};

        });
      } else {
        // _showErrorDialog('Failed to fetch event data');
      }
    } catch (error) {
      debugPrint('Error fetching event data: $error');
      _showErrorDialog('Error fetching event data');
    }
  }

  Future<void> _submitForm() async {
    String name = _nameController.text;
    String phone = _phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    final String apiUrl = '${baseUrl}addPeople';

    Map<String, String> data = {
      'attendeeName': name,
      'attendeePhone': phone,
      'eventId': _eventId ?? '',
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(name);
        _nameController.clear();
        _phoneController.clear();
      } else {
        debugPrint('${response.body}');
        var errorMessage = json.decode(response.body)['error'];
        _showErrorDialog('Failed to register. $errorMessage');
      }
    } catch (error) {
      debugPrint('Error: $error');
      _showErrorDialog('Failed to register. $error');
    }
  }

  void _showSuccessDialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful!'),
          content: Text(
              'Thank you, $name! You are registered for the event ${eventData['eventName']}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String formatDateTime(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('MMM dd, hh:mm a').format(parsedDate);
    // Dec 17 8:00 AM to Dec 19 11:00 AM
    return formattedDate;
  } catch (e) {
    // unexpected date format
    return 'Invalid Date $date';
  }
}

launchURL(String query) async {
    var url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '${eventData['eventName'] ?? 'Event Title Comes here'}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Location: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                text: '${eventData['eventVenue'] ?? 'Location Comes here'}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchURL(eventData['eventVenue']);
                },
              ),
              const TextSpan(
                text: '\n\nDate: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                text:
                    '${formatDateTime(eventData['eventStartDate'])}  to  ${formatDateTime(eventData['eventEndDate'])}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'RSVP Here!',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: "Enter your name",
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Phone',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: "Enter your phone number",
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40),
              ),
            ),
            child: const Text('Accept Invitation'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text(
            "Event Invitation",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/join_us.png',
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Join our event by completing the form below",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (eventData.isNotEmpty)
                MediaQuery.of(context).size.width >
                        650 // Adjust the width according to your design
                    ? Card(
                        margin: const EdgeInsets.all(20.0),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          width: 200,
                          child: _buildEventDetails(),
                        ),
                      )
                    : _buildEventDetails()
              else if (eventData.isEmpty && _eventId != null)
                Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 20),
                      Text(
                        'Failed to fetch event details. Please try again later.',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
      // resizeToAvoidBottomInset: true,
    );
  }
}
