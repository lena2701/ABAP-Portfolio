CLASS zll_cl_mitarbeiter_generator DEFINITION PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zll_cl_mitarbeiter_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA mitarbeiter  TYPE ZLL_Mitarbeiter.
    DATA mitarbeiters TYPE TABLE OF ZLL_Mitarbeiter.

    DELETE FROM ZLL_Mitarbeiter.
    out->write( |Gelöschte Mitarbeiter: { sy-dbcnt }| ).

    "Create Mitarbeiter
    mitarbeiter-mitarbeiternummer = '1'.
    mitarbeiter-vorname = 'Hans'.
    mitarbeiter-nachname = 'Meier'.
    mitarbeiter-eintrittsdatum = '20000501'.

    mitarbeiter-mitarbeiternummer = '2'.
    mitarbeiter-vorname = 'Lisa'.
    mitarbeiter-nachname = 'Müller'.
    mitarbeiter-eintrittsdatum = '20100701'.

    mitarbeiter-mitarbeiternummer = '3'.
    mitarbeiter-vorname = 'Petra'.
    mitarbeiter-nachname = 'Schmid'.
    mitarbeiter-eintrittsdatum = '20231001'.

    GET TIME STAMP FIELD mitarbeiter-created_at.
    GET TIME STAMP FIELD mitarbeiter-last_changed_at.
    APPEND mitarbeiter TO mitarbeiters.

    " Insert Mitarbeiter
    INSERT ZLL_mitarbeiter FROM TABLE @mitarbeiters.
    out->write( |Inserted Mitarbeiter: { sy-dbcnt }| ).





  endmethod.
ENDCLASS.
