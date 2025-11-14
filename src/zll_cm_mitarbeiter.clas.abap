CLASS zll_cm_mitarbeiter DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    " Interfaces
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    " Message Constants

    CONSTANTS:
      BEGIN OF enddatum_vor_startdatum,
        msgid TYPE symsgid      VALUE 'ZLL_Mitarbeiter',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enddatum_vor_startdatum.

    CONSTANTS:
      BEGIN OF nicht_genuegend_urlaubstage,
        msgid TYPE symsgid      VALUE 'ZLL_Mitarbeiter',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF nicht_genuegend_urlaubstage .


    " Attributs
    DATA Kommentar TYPE zll_kommentar.

    " Constructor
    METHODS constructor
      IMPORTING severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
                textid    LIKE if_t100_message=>t100key         DEFAULT if_t100_message=>default_textid
                !previous LIKE previous                         OPTIONAL
                Comment   TYPE zll_kommentar                   OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zll_cm_mitarbeiter IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->kommentar = kommentar.
  ENDMETHOD.

ENDCLASS.
