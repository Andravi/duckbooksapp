import 'package:app/pages/register_book.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../flutter_flow_theme.dart';
import '../services/duck_app_bar.dart';

class HomePageCa extends StatefulWidget {
  const HomePageCa({
    Key? key,
    this.viewType,
  }) : super(key: key);

  final List<String>? viewType;

  @override
  // ignore: library_private_types_in_public_api
  _HomePageCaState createState() => _HomePageCaState();
}

class _HomePageCaState extends State<HomePageCa> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: DuckAppBar(
            scaffoldKey: scaffoldKey,
          ),
          body: SafeArea(
            top: true,
            child: Align(
              alignment: const AlignmentDirectional(0.0, -1.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.menu,
                                size: 24.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                              child: TextFormField(
                                // controller: _model.textController,
                                // onChanged: (_) => EasyDebounce.debounce(
                                //   '_model.textController',
                                //   Duration(milliseconds: 2000),
                                //   () => setState(() {}),
                                // ),
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Pesquise uma obra aqui...',
                                  labelStyle: FlutterFlowTheme.of(context).titleLarge.override(
                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        useGoogleFonts:
                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context).titleLarge.override(
                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        useGoogleFonts:
                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).info,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 26.0,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).titleLarge.override(
                                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      useGoogleFonts:
                                          GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                    ),
                                cursorColor: FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                size: 24.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 8.0),
                              child: Text(
                                'Funções Administrativas',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).displayLarge.override(
                                      fontFamily: FlutterFlowTheme.of(context).displayLargeFamily,
                                      color: FlutterFlowTheme.of(context).alternate,
                                      useGoogleFonts:
                                          GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).displayLargeFamily),
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                              child: Container(
                                height: 100.0,
                                decoration: const BoxDecoration(),
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: ListView(
                                    padding: const EdgeInsets.only(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterBook()));
                                        },
                                        child: SizedBox(
                                          child: Container(
                                            width: 96.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              borderRadius: BorderRadius.circular(5.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.clipboardCheck,
                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                  size: 30.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Registrar\nempréstimo',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                          fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                          useGoogleFonts: GoogleFonts.asMap()
                                                              .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterBook()));
                                        },
                                        child: Container(
                                          width: 96.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            borderRadius: BorderRadius.circular(5.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_circle,
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                size: 32.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                child: Text(
                                                  'Adicionar\nobra',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(context).labelLarge.override(
                                                        fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                        useGoogleFonts: GoogleFonts.asMap()
                                                            .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Container(
                                        width: 96.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).alternate,
                                          borderRadius: BorderRadius.circular(5.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mode_edit,
                                              color: FlutterFlowTheme.of(context).tertiary,
                                              size: 32.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                'Editar\nobra',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                      useGoogleFonts: GoogleFonts.asMap()
                                                          .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                              child: Container(
                                height: 100.0,
                                decoration: const BoxDecoration(),
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Container(
                                        width: 96.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).accent2,
                                          borderRadius: BorderRadius.circular(5.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.userCheck,
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                size: 30.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                'Validar\nusuário',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                      useGoogleFonts: GoogleFonts.asMap()
                                                          .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Container(
                                        width: 96.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).accent2,
                                          borderRadius: BorderRadius.circular(5.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.userLock,
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                size: 30.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                'Inativar\nusuário',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                      useGoogleFonts: GoogleFonts.asMap()
                                                          .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Container(
                                        width: 96.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).accent2,
                                          borderRadius: BorderRadius.circular(5.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.contact_mail,
                                              color: FlutterFlowTheme.of(context).tertiary,
                                              size: 32.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                'Contactar\nusuário',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                      useGoogleFonts: GoogleFonts.asMap()
                                                          .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 8.0),
                              child: Text(
                                'Histórico de Atividades',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).displayLarge.override(
                                      fontFamily: FlutterFlowTheme.of(context).displayLargeFamily,
                                      color: FlutterFlowTheme.of(context).alternate,
                                      useGoogleFonts:
                                          GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).displayLargeFamily),
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 240.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: DataTable2(
                              columnSpacing: 10,
                              horizontalMargin: 12,
                              minWidth: 100,

                              columns: [
                                DataColumn2(
                                  label: SizedBox(
                                    width: 270,
                                    child: Text(
                                      'Ação',
                                      style: FlutterFlowTheme.of(context).labelLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  fixedWidth: 270,
                                ),
                                DataColumn2(
                                  // size: ColumnSize.values.first,
                                  label: SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Data',
                                      style: FlutterFlowTheme.of(context).labelLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                5, // numero de linhas
                                (index) => DataRow(
                                  cells: [
                                    DataCell(Text('A' * (10 - index % 10))),
                                    DataCell(SizedBox(
                                      width: 100,
                                      child: Text(
                                        'B' * (10 - (index + 5) % 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              headingRowColor: MaterialStateProperty.all(
                                FlutterFlowTheme.of(context).secondary,
                              ),
                              headingRowHeight: 56.0,
                              dataRowColor: MaterialStateProperty.all(
                                FlutterFlowTheme.of(context).secondaryBackground,
                              ),
                              dataRowHeight: 56.0,
                              border: TableBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              dividerThickness: 1.0,
                              showBottomBorder: true,
                              // minWidth: 49.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}