CLASS zvman_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvman_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( Text-001 ).
    out->write( text-t01 ).
  ENDMETHOD.
ENDCLASS.
