CLASS zvman_wordwrap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES text_table TYPE string_table.

    DATA original_text TYPE string.

    DATA parsed_text TYPE text_table READ-ONLY.

    DATA text_width TYPE i.

    DATA output TYPE REF TO if_oo_adt_classrun_out.

    METHODS wordwrap_text_old IMPORTING text_input TYPE string.

    METHODS wordwrap_text IMPORTING text_input TYPE string.

    METHODS show_parsed_text IMPORTING output TYPE REF TO if_oo_adt_classrun_out.

    METHODS get_text_line IMPORTING line_number TYPE i RETURNING VALUE(result) TYPE string.

    METHODS constructor IMPORTING text_width TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvman_wordwrap IMPLEMENTATION.


  METHOD show_parsed_text.
    LOOP AT parsed_text INTO DATA(parsed_line).
      output->write(  parsed_line ).
    ENDLOOP.
  ENDMETHOD.

  METHOD wordwrap_text_old.
    DATA(text_length) = strlen( text_input ).
    DATA current_index TYPE i.
    DATA parsed_line LIKE LINE OF parsed_text.
    DATA text_offset TYPE i.
    DATA last_character_of_line TYPE c LENGTH 1.

    original_text = text_input.

    WHILE text_offset <= text_length.
      IF ( text_offset + text_width ) <= text_length.
        parsed_line = text_input+text_offset(text_width).
        text_offset = text_offset + text_width.
        DATA(parsed_line_size) = strlen( parsed_line ) - 1.
        last_character_of_line = parsed_line+parsed_line_size(1).
        WHILE last_character_of_line <> ' '.
          parsed_line_size = parsed_line_size - 1.
          last_character_of_line = parsed_line+parsed_line_size(1).
          text_offset = text_offset - 1.
        ENDWHILE.
        parsed_line = parsed_line(parsed_line_size).
      ELSE.
        parsed_line = text_input+text_offset.
        text_offset = text_length + 1.
      ENDIF.

      INSERT parsed_line INTO TABLE parsed_text.
    ENDWHILE.
  ENDMETHOD.

  METHOD wordwrap_text.

    DATA wraped_text_line TYPE string.
    DATA wraped_text_size TYPE i.


    SPLIT text_input AT space INTO TABLE DATA(parsed_words) IN CHARACTER MODE.

    LOOP AT parsed_words INTO DATA(parsed_word).
      DATA(new_wraped_text_size) = wraped_text_size + strlen( parsed_word ) + 1.
      IF new_wraped_text_size <= text_width.
        wraped_text_size = new_wraped_text_size.
        wraped_text_line = |{ wraped_text_line }{ parsed_word } |.
      ELSE.
        DATA(trimmed_text_size) = strlen( wraped_text_line ) - 1.
        wraped_text_line = wraped_text_line(trimmed_text_size).
        INSERT wraped_text_line INTO TABLE parsed_text.
        wraped_text_line = |{ parsed_word } |.
        wraped_text_size = strlen( parsed_word ) + 1.
      ENDIF.
    ENDLOOP.
    trimmed_text_size = strlen( wraped_text_line ) - 1.
    wraped_text_line = wraped_text_line(trimmed_text_size).
    INSERT wraped_text_line INTO TABLE parsed_text.
  ENDMETHOD.

  METHOD constructor.
    me->text_width = text_width.
  ENDMETHOD.

  METHOD get_text_line.
    result = VALUE #( parsed_text[ line_number ] OPTIONAL ).
  ENDMETHOD.

ENDCLASS.
