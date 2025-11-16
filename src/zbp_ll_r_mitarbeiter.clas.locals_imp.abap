CLASS lhc_mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorization FOR Instance AUTHORIZATION
      IMPORTING key REQUEST requested_authorization FOR ZLL_R_Mitarbeiter RESULT result.

    METHODS get_instance_authorization_i FOR instance AUTHORIZATION
     IMPORTING key REQUEST requested_authorization FOR ZLL_R_Urlaubsantrag RESULT result.


    METHODS BestimmeUrlaubstage
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZLL_R_Urlaubsantrag~BestimmeUrlaubstage.

    METHODS GenehmigeUrlaubsantrag FOR MODIFY
      IMPORTING keys FOR ACTION zll_r_urlaubsantrag~GenehmigeUrlaubsantrag RESULT result.

    METHODS AblehnenUrlaubsantrag FOR MODIFY
      IMPORTING keys FOR ACTION zll_r_urlaubsantrag~AblehnenUrlaubsantrag RESULT result.

    METHODS BestaetigeDatum
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZLL_R_Urlaubsantrag~BestaetigeDatum.

    METHODS BestaetigeUrlaubstage
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZLL_R_Urlaubsantrag~BestaetigeUrlaubstage.

    METHODS BestimmeStatus
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZLL_R_Urlaubsantrag~BestimmeStatus.


ENDCLASS.

CLASS lhc_mitarbeiter IMPLEMENTATION.

  METHOD get_instance_authorization.
  ENDMETHOD.

  METHOD get_instance_authorization_i.
  ENDMETHOD.

  METHOD GenehmigeUrlaubsantrag.
   DATA message TYPE REF TO zll_cm_mitarbeiter.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE zll_r_urlaubsantrag
         FIELDS ( Status Kommentar )
         WITH CORRESPONDING #( keys )
         RESULT DATA(urlaubsantraege).

    " Process Inquiry
    LOOP AT urlaubsantraege REFERENCE INTO DATA(urlaubsantrag).

      " Validate State and Create Error Message
      IF urlaubsantrag->Status = 'A'.
        message = NEW zll_cm_mitarbeiter( textid   = zll_cm_mitarbeiter=>urlaubsantrag_schon_abelehnt
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = urlaubsantrag->Kommentar ).
        APPEND VALUE #( %tky = urlaubsantrag->%tky
                        %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag->%tky ) TO failed-zll_r_urlaubsantrag.
        DELETE urlaubsantraege INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF urlaubsantrag->Status = 'G'.
        message = NEW zll_cm_mitarbeiter( textid   = zll_cm_mitarbeiter=>urlaubsantrag_schon_angenommen
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = urlaubsantrag->Kommentar ).
        APPEND VALUE #( %tky = urlaubsantrag->%tky
                        %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag->%tky ) TO failed-zll_r_urlaubsantrag.
        DELETE urlaubsantraege INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to G und Create Success Message
      urlaubsantrag->Status = 'G'.
      message = NEW zll_cm_mitarbeiter(
           textid = zll_cm_mitarbeiter=>urlaubsantrag_angenommen
          severity = if_abap_behv_message=>severity-success
         comment = urlaubsantrag->Kommentar
    ).
      APPEND VALUE #( %tky = urlaubsantrag->%tky %msg = message ) TO reported-zll_r_urlaubsantrag.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zll_r_urlaubsantrag
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR lr IN urlaubsantraege
                         ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN urlaubsantraege
                      ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.

  METHOD AblehnenUrlaubsantrag.
   DATA message TYPE REF TO zll_cm_mitarbeiter.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE zll_r_urlaubsantrag
        FIELDS ( Status Kommentar )
        WITH CORRESPONDING #( keys )
        RESULT DATA(urlaubsantraege).

    " Process Inquiry
    LOOP AT urlaubsantraege REFERENCE INTO DATA(urlaubsantrag).

      " Validate State and Create Error Message
      IF urlaubsantrag->Status = 'A'.
        message = NEW zll_cm_mitarbeiter(
            textid = zll_cm_mitarbeiter=>urlaubsantrag_schon_abelehnt
             severity = if_abap_behv_message=>severity-error
             comment  = urlaubsantrag->Kommentar
         ).
        APPEND VALUE #( %tky = urlaubsantrag->%tky %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag->%tky ) TO failed-zll_r_urlaubsantrag.
        DELETE urlaubsantraege INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF urlaubsantrag->Status = 'G'.
        message = NEW zll_cm_mitarbeiter(
            textid = zll_cm_mitarbeiter=>urlaubsantrag_schon_angenommen
            severity = if_abap_behv_message=>severity-error
            comment  = urlaubsantrag->Kommentar
        ).
        APPEND VALUE #( %tky = urlaubsantrag->%tky %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag->%tky ) TO failed-zll_r_urlaubsantrag.
        DELETE urlaubsantraege INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to A und Create Success Message
      urlaubsantrag->Status = 'A'.
      message = NEW zll_cm_mitarbeiter(
         textid = zll_cm_mitarbeiter=>urlaubsantrag_ablehnen
         severity = if_abap_behv_message=>severity-success
         comment = urlaubsantrag->Kommentar
      ).
      APPEND VALUE #( %tky = urlaubsantrag->%tky %msg = message ) TO reported-zll_r_urlaubsantrag.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zll_r_urlaubsantrag
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR lr IN urlaubsantraege ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN urlaubsantraege ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.


  METHOD BestimmeStatus.

    READ ENTITY IN LOCAL MODE ZLL_R_Urlaubsantrag
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
         RESULT DATA(urlaubsantraege).

    MODIFY ENTITY IN LOCAL MODE ZLL_R_Urlaubsantrag
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR vr IN urlaubsantraege
                         ( %tky   = vr-%tky
                           Status = 'B' ) ).
  ENDMETHOD.
   METHOD BestimmeUrlaubstage.
    READ ENTITY IN LOCAL MODE zll_r_urlaubsantrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(urlaubsantraege).

    LOOP AT urlaubsantraege INTO DATA(urlaubsantrag).

      DATA(startdatum) = urlaubsantrag-Startdatum.
      startdatum = startdatum - 1.
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdatum iv_end = urlaubsantrag-Enddatum ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      MODIFY ENTITY IN LOCAL MODE zll_r_urlaubsantrag
             UPDATE FIELDS ( Urlaubstage )
             WITH VALUE #( FOR vr IN urlaubsantraege
                           ( %tky   = vr-%tky
                             urlaubstage = working_days ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD BestaetigeDatum.
    DATA message TYPE REF TO zll_cm_mitarbeiter.
    DATA(lo_context_info) = NEW cl_abap_context_info( ).
    DATA(lv_current_date) = lo_context_info->get_system_date( ).


    READ ENTITY IN LOCAL MODE ZLL_R_Urlaubsantrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(urlaubsantraege).


    LOOP AT urlaubsantraege INTO DATA(urlaubsantrag).

      IF urlaubsantrag-Enddatum < urlaubsantrag-Startdatum.
        message = NEW zll_cm_mitarbeiter( textid = zll_cm_mitarbeiter=>enddatum_vor_startdatum
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = urlaubsantrag-%tky
                        %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag-%tky ) TO failed-zll_r_urlaubsantrag.
    ENDIF.

  IF urlaubsantrag-Startdatum < lv_current_date.
        message = NEW zll_cm_mitarbeiter( textid = zll_cm_mitarbeiter=>urlaubsantrag_start_vorbei
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = urlaubsantrag-%tky
                        %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag-%tky ) TO failed-zll_r_urlaubsantrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD BestaetigeUrlaubstage.
    DATA message TYPE REF TO zll_cm_mitarbeiter.

    READ ENTITY IN LOCAL MODE zll_r_urlaubsantrag
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(urlaubsantraege).

    LOOP AT urlaubsantraege INTO DATA(urlaubsantrag).

      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(urlaubstage) = ( calendar->calc_workingdays_between_dates( iv_start = urlaubsantrag-Startdatum iv_end = urlaubsantrag-Enddatum ) + 1 ) .
        CATCH cx_fhc_runtime.
          CONTINUE.
      ENDTRY.

     SELECT SINGLE VerfuegbareUrlaubstage
      FROM zll_r_urlaubsanspruch
      WHERE MitarbeiterUuid = @urlaubsantrag-AntragstellerUuid
        AND Jahr            = @urlaubsantrag-Startdatum+0(4)
      INTO @DATA(verfuegbareurlaubstage).


      IF verfuegbareurlaubstage < urlaubstage.

      message = NEW zll_cm_mitarbeiter(
                    textid                      = zll_cm_mitarbeiter=>nicht_genuegend_urlaubstage
                    severity                    = if_abap_behv_message=>severity-error
                ).

      APPEND VALUE #( %tky = urlaubsantrag-%tky
                      %msg = message ) TO reported-zll_r_urlaubsantrag.

      APPEND VALUE #( %tky = urlaubsantrag-%tky )
          TO failed-zll_r_urlaubsantrag.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
