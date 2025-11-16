CLASS lhc_mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorization FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorization FOR ZLL_R_Mitarbeiter RESULT result.

    METHODS get_global_authorization_i FOR GLOBAL AUTHORIZATION
     IMPORTING REQUEST requested_authorization FOR ZLL_R_Urlaubsantrag RESULT result.


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

  METHOD get_global_authorization.
  ENDMETHOD.

  METHOD get_global_authorization_i.
  ENDMETHOD.

  METHOD GenehmigeUrlaubsantrag.
  ENDMETHOD.

  METHOD AblehnenUrlaubsantrag.
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
    ENDLOOP.

  ENDMETHOD.



  METHOD BestaetigeUrlaubstage.
    DATA message TYPE REF TO zll_cm_mitarbeiter.


    READ ENTITY IN LOCAL MODE ZLL_R_Urlaubsantrag
         FIELDS ( Startdatum Enddatum AntragstellerName )
         WITH CORRESPONDING #( keys )
         RESULT DATA(urlaubsantraege).


    LOOP AT urlaubsantraege INTO DATA(urlaubsantrag).
      TRY.
          DATA(Startdatum) = urlaubsantrag-startdatum.
          startdatum -= 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdatum
                                                                         iv_end   = urlaubsantrag-Enddatum ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      SELECT FROM zll_r_mitarbeiter
           FIELDS  VerfuegbareUrlaubstage
           WHERE MitarbeiterUuid = @urlaubsantrag-AntragstellerUuid
           INTO @DATA(verfuegbareurlaubstage).
      ENDSELECT.
      IF VerfuegbareUrlaubstage < working_days.
        message = NEW zll_cm_mitarbeiter( textid   = zll_cm_mitarbeiter=>nicht_genuegend_urlaubstage
                                          severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = urlaubsantrag-%tky
                        %msg = message ) TO reported-zll_r_urlaubsantrag.
        APPEND VALUE #( %tky = urlaubsantrag-%tky ) TO failed-zll_r_urlaubsantrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
