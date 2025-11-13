@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Basic View Urlaubsantrag'
define view entity ZLL_R_Urlaubsantrag
  as select from zll_urlaubsantr
  association        to parent ZLL_R_Mitarbeiter as _Antragsteller     on $projection.AntragstellerUuid = _Antragsteller.MitarbeiterUuid
  association [1..1] to ZLL_R_Mitarbeiter        as _Genehmigender     on $projection.GenehmigenderUuid = _Genehmigender.MitarbeiterUuid
  association [1..1] to ZLL_I_MitarbeiterText    as _GenehmigenderText on $projection.GenehmigenderUuid = _GenehmigenderText.MitarbeiterUuid
 association [1..1] to ZLL_I_MitarbeiterText    as _AntragstellerText on $projection.AntragstellerUuid = _AntragstellerText.MitarbeiterUuid

{
  key urlaubsantrag_uuid      as UrlaubsantragUuid,
      @Semantics.uuid: true
      @ObjectModel.text.element: ['Antragsteller']
      antragsteller_uuid      as AntragstellerUuid,
      @Semantics.uuid: true
      @ObjectModel.text.element: ['Genehmigender']
      genehmigender_uuid      as GenehmigenderUuid,
      startdatum              as Startdatum,
      enddatum                as Enddatum,
      urlaubstage             as Urlaubstage,
      kommentar               as Kommentar,
      status                  as Status,
      
      @Semantics.user.createdBy: true
      created_by              as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at              as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by         as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at         as LastChangedAt,



      /* Transient Data */
      _GenehmigenderText.Name as Genehmigender,
      _AntragstellerText.Name as Antragsteller,

      /* Associations */
      _Antragsteller,
      _Genehmigender

}
