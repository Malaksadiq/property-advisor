// ignore_for_file: use_build_context_synchronously, unused_field, unused_catch_clause, unused_local_variable, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:property_app/Utils/lists.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/const/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';
import 'package:property_app/screens/post_screen/amenities_and_features_screen%20.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/city_bottom_sheet.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/coordinate_textField.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/description_modal_bottom_sheet.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/map_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/database_services.dart';
import 'post_screen_widgets/circle_avatar_wrap.dart';
import 'post_screen_widgets/build_row_widget.dart';
import 'post_screen_widgets/location_row.dart';
import 'post_screen_widgets/text_container.dart';
import 'post_screen_widgets/ulpload_log.dart';
import 'post_screen_widgets/upload_image_widget.dart';
import 'post_screen_widgets/upload_screen_text_input.dart';

class UploadDataPage extends StatefulWidget {
  const UploadDataPage({super.key});

  @override
  State<UploadDataPage> createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  List<String> _commercialFeatures = [];
  List<String> _constructionFeatures = [];
  List<String> _nearByLocationFeatures = [];
  List<String> _outDoorFeatures = [];

  final _formKey = GlobalKey<FormState>();
  final _discriptionController = TextEditingController();
  final _cityController = TextEditingController();
  final _featuresController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _sqrftController = TextEditingController();

  // ***************
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int _selectedBeds = 0;

  int _selectedBaths = 0;

  int _selectedGarage = 0;

  // *********************8
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  void uploadData() async {
    await DatabaseServices.uploadDataToDatabase(
      context: context,
      uid: FirebaseAuth.instance.currentUser?.uid,
      title: _titleController.text,
      propertyType: selectedPropertyType!,
      selectedCity: _selectedCity.toString(),
      amount: int.parse(_priceController.text),
      selectedImages: _imageFiles,
      bedroom: _selectedBeds.toString(),
      bathrooms: _selectedBaths.toString(),
      garage: _selectedGarage.toString(),
      areaSize: _sqrftController.text,
      propertyDescription: _description,
      commercialList: _commercialFeatures,
      constructionList: _constructionFeatures,
      outdoorDetails: _outDoorFeatures,
      nearByLocationList: _nearByLocationFeatures,
      companyName: _companyController.text,
      email: _emailController.text,
      name: _nameController.text,
      phone: _phoneController.text,
      lang: _longitudeController.text,
      lat: _latitudeController.text,
      selectedMeasurement: _selectedMeasurement,
      selectedLogo: _logoFile as File,
      purpose: _purpose.toString(),
    );

    // show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully uploaded!'),
        duration: Duration(seconds: 2),
      ),
    );
    // clear inputs
    _titleController.clear();
    _priceController.clear();
    _sqrftController.clear();
    setState(() {
      _selectedBeds = 0;
      _selectedBaths = 0;
      _selectedGarage = 0;
      selectedPropertyType = null;
      _selectedCity = null;
      _description = '';
      _imageFiles.clear();
    });
  }

  final imagePicker = ImagePicker();
  final List<XFile> _imageFiles = [];

  File? _logoFile;
  List<String> features = [];
  String? selectedPropertyType;

  void addFeature(String feature) {
    setState(() {
      features.add(feature);
    });
  }

  Future<void> uploadImage(ImageSource source) async {
    List<XFile>? resultList = [];
    try {
      resultList = await ImagePicker().pickMultiImage();
    } on Exception catch (e) {
      // Handle exception if any
    }

    if (!mounted) return;

    setState(() {
      _imageFiles.addAll(resultList!.cast<XFile>());
    });
  }

  uploadLogo(ImageSource sourcee) async {
    XFile? pickedLogo = await ImagePicker().pickImage(source: sourcee);
    setState(() {
      _logoFile = File(pickedLogo!.path);
    });
  }

  @override
  void dispose() {
    _sqrftController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    kpkCities;
  }

  String? _selectedCity;

  void _showCitySelectionModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return CitySelectionModal(
          onCitySelected: (selectedCity) {
            setState(() {
              _selectedCity = selectedCity;
            });
          },
          selectedCity: _selectedCity, // Pass the selected city to the modal
        );
      },
    );
  }

  String _description = '';

  void _showDescriptionModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DescriptionModalBottomSheet(
          descriptionController: _discriptionController,
          onDescriptionChanged: (value) {
            setState(() {
              _description = value;
            });
          },
        );
      },
    );
  }

  void removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  LatLng? selectedLocation;
  LatLng selectedLatLng = const LatLng(0.0, 0.0);

  final bool _isDropdownOpen = false;
  // String? _selectedMeasurement;
  // String _selectedMeasurement = 'Sq.Ft.';
  String? _selectedMeasurement;
  String? _purpose;

  Future<void> _navigateToAmenitiesAndFeaturesScreen() async {
    final selectedFeatures = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmenitiesAndFeaturesScreen(
          commercialFeatures: _commercialFeatures,
          constructionFeatures: _constructionFeatures,
          nearbyLocationFeatures: _nearByLocationFeatures,
          outdoorFeatures: _outDoorFeatures,
        ),
      ),
    );

    if (selectedFeatures != null &&
        selectedFeatures is Map<String, List<String>>) {
      setState(() {
        _commercialFeatures = selectedFeatures['commercial'] ?? [];
        _constructionFeatures = selectedFeatures['construction'] ?? [];
        _nearByLocationFeatures = selectedFeatures['nearby'] ?? [];
        _outDoorFeatures = selectedFeatures['outdoor'] ?? [];
        print(_commercialFeatures);
        print(_constructionFeatures);
        print(_nearByLocationFeatures);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: const CustomAppBar(
          automaticallyImplyLeadingg: true,
          title: 'Post Details',
          toolbarHeight: 50,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UploadScreenTextInput(
                  iconName: 'assets/images/title.png',
                  controller: _titleController,
                  hintText: "Enter Property Title",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                UploadScreenTextInput(
                  iconName: 'assets/images/price.png',
                  controller: _priceController,
                  hintText: "Enter Amount",
                ),
                const SizedBox(width: 4),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: UploadScreenTextInput(
                        iconName: 'assets/images/resize.png',
                        controller: _sqrftController,
                        hintText: "Enter area size",
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: DropdownButton<String>(
                              value: _selectedMeasurement ??
                                  'Sq.Ft.', // Use 'Sq.Ft.' as the default value if _selectedMeasurement is null
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedMeasurement = newValue!;
                                });
                              },
                              items: <String>[
                                'Sq.Ft.',
                                'Sq. M.',
                                'Sq. Yd',
                                'Marla',
                                'Kanal',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: authTextStyle,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildRowWidget(
                  iconName: 'assets/images/ptype.png',
                  child: DropdownButton(
                    value: selectedPropertyType,
                    hint: Text(
                      selectedPropertyType ?? 'select Property Type',
                      style: authTextStyle,
                    ),
                    onChanged: (v) {
                      setState(() {
                        selectedPropertyType = v!;
                      });
                    },
                    items: propertyTypes.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e, style: authTextStyle),
                      );
                    }).toList(),
                    dropdownColor: const Color(0xffEBEBEB),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    iconSize: 24,
                    isExpanded: true,
                    borderRadius: BorderRadius.zero,
                    underline: const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildRowWidget(
                  iconName: 'assets/images/ptype.png',
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DropdownButton<String>(
                        value: _purpose ?? 'Sale',
                        onChanged: (newValue) {
                          setState(() {
                            _purpose = newValue;
                            print(_purpose);
                          });
                        },
                        items: <String>[
                          'Sale',
                          'Rent',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: authTextStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildRowWidget(
                  iconName: 'assets/images/clocation.png',
                  child: InkWell(
                    onTap: () => _showCitySelectionModal(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_selectedCity ?? 'Select a city',
                              style: authTextStyle),
                          const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildRowWidget(
                  iconName: 'assets/images/description.png',
                  child: InkWell(
                    onTap: () {
                      _showDescriptionModalBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 4),
                      child: Text(
                          _description.isNotEmpty
                              ? _description
                              : 'Describe your property in detail',
                          style: authTextStyle),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Column(
                  children: [
                    if (selectedPropertyType == 'Home' ||
                        selectedPropertyType == 'Residential')
                      Column(
                        children: [
                          buildRow(
                            iconName: 'assets/images/bed.png',
                            child: Text('Bedrooms',
                                style: authTextStyle.copyWith(
                                    color: const Color(0xff1E3C64))),
                          ),
                          const SizedBox(height: 8),
                          CircleAvatarWrap(
                            itemCount: 7,
                            onTap: (index) {
                              setState(() {
                                _selectedBeds = index;
                              });
                            },
                            // selectedValue: _selectedBeds ?? 0,
                            selectedValue: _selectedBeds,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          buildRow(
                            iconName: 'assets/images/bath.png',
                            child: Text('Bathrooms',
                                style: authTextStyle.copyWith(
                                    color: const Color(0xff1E3C64))),
                          ),
                          const SizedBox(height: 8),
                          CircleAvatarWrap(
                            itemCount: 11,
                            onTap: (index) {
                              setState(() {
                                _selectedBaths = index;
                              });
                            },
                            selectedValue: _selectedBaths,
                            // selectedValue: _selectedBaths ?? 0,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          buildRow(
                            iconName: 'assets/images/garage.png',
                            child: Text('Garage',
                                style: authTextStyle.copyWith(
                                    color: const Color(0xff1E3C64))),
                          ),
                          const SizedBox(height: 8),
                          CircleAvatarWrap(
                            itemCount: 7,
                            onTap: (index) {
                              setState(() {
                                _selectedGarage = index;
                              });
                            },
                            selectedValue: _selectedGarage,
                          ),
                        ],
                      ),
                    // Empty column for other property types
                    if (selectedPropertyType != 'Home' &&
                        selectedPropertyType != 'Residential')
                      Column(),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: TextButton(
                      onPressed: _navigateToAmenitiesAndFeaturesScreen,
                      child: const Text(
                        'Select Amenities and Features',
                        style: authTextStyle,
                      )),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                buildRowWidget(
                  iconName: 'assets/images/image.png',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Upload Image',
                      style: authTextStyle.copyWith(
                          color: const Color(0xff1E3C64)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Column(
                  children: [
                    UploadImageWidget(
                      fromCamera: () => uploadImage(ImageSource.camera),
                      fromGallery: () => uploadImage(ImageSource.gallery),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFiles.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  width: 80, // Set the desired width
                                  height: 100, // Set the desired height
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      File(_imageFiles[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _imageFiles.removeAt(index);
                                    });
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 8,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.close,
                                      size: 8,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                TextContainer(text: 'Location'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                //Location widget
                MyRowWidget(
                  onPressed: () async {
                    // Open the LocationPickerPage
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationPickerPage(),
                      ),
                    );

                    if (result != null && result is LatLng) {
                      // Handle the selected location
                      setState(() {
                        selectedLatLng = result;
                        _latitudeController.text = result.latitude.toString();
                        _longitudeController.text = result.longitude.toString();
                      });
                    }
                  },
                  labelText: 'GPS Coordinate',
                  buttonText: 'Pick Location',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    CoordinateTextField(
                      controller: _latitudeController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final double? parsedValue = double.tryParse(value);
                        if (parsedValue != null) {
                          // Update your logic with the parsed value
                        }
                      },
                      labelText: 'Latitude',
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    CoordinateTextField(
                      controller: _longitudeController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final double? parsedValue = double.tryParse(value);
                        if (parsedValue != null) {
                          // Update your logic with the parsed value
                        }
                      },
                      labelText: 'Longitude',
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextContainer(text: 'Contact Details'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const SizedBox(height: 8),
                UploadScreenTextInput(
                  iconName: 'assets/images/user.png',
                  controller: _nameController,
                  hintText: "Enter Dealer name",
                ),
                const SizedBox(height: 8),
                UploadScreenTextInput(
                  iconName: 'assets/images/terms.png',
                  controller: _companyController,
                  hintText: "Enter company Name",
                ),
                const SizedBox(height: 8),
                UploadScreenTextInput(
                  iconName: 'assets/images/mail.png',
                  controller: _emailController,
                  hintText: "Enter email",
                ),
                const SizedBox(height: 8),
                UploadScreenTextInput(
                  iconName: 'assets/images/phone-call.png',
                  controller: _phoneController,
                  hintText: "Enter phone",
                ),
                const SizedBox(height: 8),
                buildRowWidget(
                  iconName: 'assets/images/image.png',
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Upload Picture or Logo',
                      style: authTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _logoFile == null
                    ? UploadImageWidgett(
                        fromGallery: () => uploadLogo(ImageSource.gallery),
                      )
                    : SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Image.file(File(_logoFile!.path)),
                      ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  height: 45,
                  child: CElevatedButton(
                    loading: false,
                    onPressed: uploadData,
                    bText: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
