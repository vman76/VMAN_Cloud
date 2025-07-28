CLASS zvman_test001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvman_test001 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    data table001_row type zvman001.
    data table001 type standard table of zvman001.

    insert value #(  id = 'V01' description = 'Value 1' value = '100.50' currency = 'EUR' email = 'clash1@gmail.com' ) into table table001.
    insert value #(  id = 'V02' description = 'Value 2' value = '10050.00' currency = 'EUR' email = 'clash2@gmail.com' ) into table table001.
    insert value #(  id = 'V03' description = 'Value 3' value = '1005000.00' currency = 'USD' email = 'clash3@gmail.com' ) into table table001.

    delete from zvman001.

    out->write( |Deleted { conv string( sy-dbcnt ) } rows from table zvman001| ).

    insert zvman001 from table @table001.

    out->write( |Inserted { conv string( sy-dbcnt ) } rows from table zvman001| ).

  ENDMETHOD.

ENDCLASS.
