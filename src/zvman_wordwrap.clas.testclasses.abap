CLASS ltcl_wordwrap DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CONSTANTS expected_first_line_25 TYPE string VALUE 'Semaine après semaine, '.
    CONSTANTS expected_last_line_25 TYPE string VALUE 'suspects avant elles.'.
    CONSTANTS number_lines_25 TYPE i VALUE 19.

    CONSTANTS expected_first_line_50 TYPE string VALUE 'Semaine après semaine, les arrestations, opérées '.
    CONSTANTS expected_last_line_50 TYPE string VALUE 'dizaines d’autres suspects avant elles.'.
    CONSTANTS number_lines_50 TYPE i VALUE 9.

    METHODS:
      number_lines_test_25 FOR TESTING RAISING cx_static_check.
    METHODS:
      first_line_test_25 FOR TESTING RAISING cx_static_check.
    METHODS:
      last_line_test_25 FOR TESTING RAISING cx_static_check.

    METHODS:
      number_lines_test_50 FOR TESTING RAISING cx_static_check.
    METHODS:
      first_line_test_50 FOR TESTING RAISING cx_static_check.
    METHODS:
      last_line_test_50 FOR TESTING RAISING cx_static_check.

    METHODS setup.

    METHODS teardown.

    DATA code_under_test TYPE REF TO zvman_wordwrap.

    DATA text_input TYPE string.
ENDCLASS.


CLASS ltcl_wordwrap IMPLEMENTATION.

  METHOD setup.
    text_input =
        |Semaine après semaine, les arrestations, opérées conjointement | &&
        |par la police et le Shin Bet, les services de renseignement | &&
        |intérieurs israéliens, se multiplient sur tout le territoire | &&
        |hébreu. Début juillet, cinq nouvelles personnes interpellées | &&
        |ont comparu devant un tribunal pour une mise en détention | &&
        |immédiate. Toutes sont de confession juive, nées en Israël,| &&
        |comme des dizaines d’autres suspects avant elles.|.

  ENDMETHOD.

  METHOD teardown.
    FREE code_under_test.
    FREE text_input.
  ENDMETHOD.

  METHOD number_lines_test_25.
    code_under_test = NEW zvman_wordwrap( text_width = 25 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(number_of_lines) = lines( code_under_test->parsed_text ).
  ENDMETHOD.

  METHOD first_line_test_25.

    code_under_test = NEW zvman_wordwrap( text_width = 25 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(first_line) = code_under_test->get_text_line(  1 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = first_line
        exp                  = expected_first_line_25
        msg                  = 'First Line not as expected.'
    ).

  ENDMETHOD.

  METHOD last_line_test_25.
    code_under_test = NEW zvman_wordwrap( text_width = 25 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(last_line) = code_under_test->get_text_line( 19 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = last_line
        exp                  = expected_last_line_25
        msg                  = 'Last Line not as expected.'
    ).
  ENDMETHOD.

  METHOD number_lines_test_50.
    code_under_test = NEW zvman_wordwrap( text_width = 50 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(number_of_lines) = lines( code_under_test->parsed_text ).
  ENDMETHOD.

  METHOD first_line_test_50.

    code_under_test = NEW zvman_wordwrap( text_width = 50 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(first_line) = code_under_test->get_text_line(  1 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = first_line
        exp                  = expected_first_line_50
        msg                  = 'First Line not as expected.'
    ).

  ENDMETHOD.

  METHOD last_line_test_50.
    code_under_test = NEW zvman_wordwrap( text_width = 50 ).

    code_under_test->wordwrap_text( text_input = text_input ).

    DATA(last_line) = code_under_test->get_text_line( 9 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = last_line
        exp                  = expected_last_line_50
        msg                  = 'Last Line not as expected.'
    ).
  ENDMETHOD.

ENDCLASS."* use this source file for your ABAP unit test classes
