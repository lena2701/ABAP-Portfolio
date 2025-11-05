CLASS zll_cl_mitarbeiter_generator DEFINITION PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zll_cl_mitarbeiter_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA mitarbeiter  TYPE ZLL_Mitarbeiter.
    DATA mitarbeitende TYPE TABLE OF ZLL_Mitarbeiter.

    DATA urlaubsanspruch TYPE ZLL_Urlaubsanspr.
    DATA urlaubsansprueche TYPE TABLE OF ZLL_Urlaubsanspr.

    DATA urlaubsantrag TYPE ZLL_Urlaubsantr.
    DATA urlaubsantraege TYPE TABLE OF ZLL_Urlaubsantr.

    DATA hans_uuid  TYPE sysuuid_x16.
    DATA lisa_uuid  TYPE sysuuid_x16.
    DATA petra_uuid TYPE sysuuid_x16.

    DELETE FROM ZLL_Mitarbeiter.
    out->write( |Gelöschte Mitarbeiter: { sy-dbcnt }| ).

    DELETE FROM ZLL_Urlaubsanspr.
    out->write( |Gelöschte Urlaubsansprüche: { sy-dbcnt }| ).

    DELETE FROM ZLL_Urlaubsantr.
    out->write( |Gelöschte Urlaubsanträge: { sy-dbcnt }| ).

    " Mitarbeiter erstellen
    mitarbeiter-mitarbeiternummer = '1'.
    mitarbeiter-mitarbeiter_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    hans_uuid = mitarbeiter-mitarbeiter_uuid.
    mitarbeiter-client = sy-mandt.
    mitarbeiter-vorname = 'Hans'.
    mitarbeiter-nachname = 'Meier'.
    mitarbeiter-eintrittsdatum = '20000501'.
    GET TIME STAMP FIELD mitarbeiter-created_at.
    GET TIME STAMP FIELD mitarbeiter-last_changed_at.
    APPEND mitarbeiter TO mitarbeitende.

    "Urlaubsanspruch erstellen
    urlaubsanspruch-client = sy-mandt.
    urlaubsanspruch-mitarbeiter_uuid = hans_uuid.
    urlaubsanspruch-urlaubsanspruch_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsanspruch-jahr = '2022'.
    urlaubsanspruch-urlaubstage = '30'.
    APPEND urlaubsanspruch TO urlaubsansprueche.

    urlaubsanspruch-client = sy-mandt.
    urlaubsanspruch-mitarbeiter_uuid = hans_uuid.
    urlaubsanspruch-urlaubsanspruch_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsanspruch-jahr = '2023'.
    urlaubsanspruch-urlaubstage = '30'.
    APPEND urlaubsanspruch TO urlaubsansprueche.

    " Mitarbeiter erstellen
    mitarbeiter-mitarbeiternummer = '2'.
    mitarbeiter-mitarbeiter_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    lisa_uuid = mitarbeiter-mitarbeiter_uuid.
    mitarbeiter-client = sy-mandt.
    mitarbeiter-vorname = 'Lisa'.
    mitarbeiter-nachname = 'Müller'.
    mitarbeiter-eintrittsdatum = '20100701'.
    GET TIME STAMP FIELD mitarbeiter-created_at.
    GET TIME STAMP FIELD mitarbeiter-last_changed_at.
    APPEND mitarbeiter TO mitarbeitende.

    "Urlaubsanspruch erstellen
    urlaubsanspruch-mitarbeiter_uuid = lisa_uuid.
    urlaubsanspruch-urlaubsanspruch_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsanspruch-jahr = '2023'.
    urlaubsanspruch-urlaubstage = '30'.
    APPEND urlaubsanspruch TO urlaubsansprueche.


    "Mitarbeiter erstellen
    mitarbeiter-mitarbeiternummer = '3'.
    mitarbeiter-mitarbeiter_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    petra_uuid = mitarbeiter-mitarbeiter_uuid.
    mitarbeiter-client = sy-mandt.
    mitarbeiter-vorname = 'Petra'.
    mitarbeiter-nachname = 'Schmid'.
    mitarbeiter-eintrittsdatum = '20231001'.
    GET TIME STAMP FIELD mitarbeiter-created_at.
    GET TIME STAMP FIELD mitarbeiter-last_changed_at.
    APPEND mitarbeiter TO mitarbeitende.

    "Urlaubsanspruch erstellen
    urlaubsanspruch-client = sy-mandt.
    urlaubsanspruch-mitarbeiter_uuid =  petra_uuid.
    urlaubsanspruch-urlaubsanspruch_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsanspruch-jahr = '2023'.
    urlaubsanspruch-urlaubstage = '7'.
    APPEND urlaubsanspruch TO urlaubsansprueche.

    "Urlaubsantrag erstellen
    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = hans_uuid.
    urlaubsantrag-genehmigender_uuid = lisa_uuid.
    urlaubsantrag-startdatum = '20220701'.
    urlaubsantrag-enddatum = '20220710'.
    urlaubsantrag-urlaubstage = '8'.
    urlaubsantrag-kommentar = 'Sommerurlaub'.
    urlaubsantrag-status = 'G'.
    APPEND urlaubsantrag TO urlaubsantraege.

    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = hans_uuid.
    urlaubsantrag-genehmigender_uuid = lisa_uuid.
    urlaubsantrag-startdatum = '20221227'.
    urlaubsantrag-enddatum = '20221230'.
    urlaubsantrag-urlaubstage = '3'.
    urlaubsantrag-kommentar = 'Weihnachtsurlaub'.
    urlaubsantrag-status = 'A'.
    APPEND urlaubsantrag TO urlaubsantraege.

    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = hans_uuid.
    urlaubsantrag-genehmigender_uuid = lisa_uuid.
    urlaubsantrag-startdatum = '20221228'.
    urlaubsantrag-enddatum = '20221230'.
    urlaubsantrag-urlaubstage = '3'.
    urlaubsantrag-kommentar = 'Weihnachtsurlaub (2. Versuch)'.
    urlaubsantrag-status = 'G'.
    APPEND urlaubsantrag TO urlaubsantraege.

    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = hans_uuid.
    urlaubsantrag-genehmigender_uuid = lisa_uuid.
    urlaubsantrag-startdatum = '20230527'.
    urlaubsantrag-enddatum = '20230614'.
    urlaubsantrag-urlaubstage = '14'.
    urlaubsantrag-kommentar = ' '.
    urlaubsantrag-status = 'G'.
    APPEND urlaubsantrag TO urlaubsantraege.

    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = hans_uuid.
    urlaubsantrag-genehmigender_uuid = lisa_uuid.
    urlaubsantrag-startdatum = '20231220'.
    urlaubsantrag-enddatum = '20231231'.
    urlaubsantrag-urlaubstage = '8'.
    urlaubsantrag-kommentar = 'Winterurlaub'.
    urlaubsantrag-status = 'B'.
    APPEND urlaubsantrag TO urlaubsantraege.

    urlaubsantrag-client = sy-mandt.
    urlaubsantrag-urlaubsantrag_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    urlaubsantrag-antragsteller_uuid = petra_uuid.
    urlaubsantrag-genehmigender_uuid = hans_uuid.
    urlaubsantrag-startdatum = '20231227'.
    urlaubsantrag-enddatum = '20231231'.
    urlaubsantrag-urlaubstage = '3'.
    urlaubsantrag-kommentar = 'Weihnachtsurlaub'.
    urlaubsantrag-status = 'B'.
    APPEND urlaubsantrag TO urlaubsantraege.

    INSERT ZLL_mitarbeiter FROM TABLE @mitarbeitende.
    out->write( |Eingefügte Mitarbeiter: { sy-dbcnt }| ).

    INSERT ZLL_Urlaubsanspr FROM TABLE @urlaubsansprueche.
    out->write( |Eingefügte Urlaubsansprüche: { sy-dbcnt }| ).

    INSERT ZLL_Urlaubsantr FROM TABLE @urlaubsantraege.
    out->write( |Eingefügte Urlaubseinträge: { sy-dbcnt }| ).




  ENDMETHOD.
ENDCLASS.
