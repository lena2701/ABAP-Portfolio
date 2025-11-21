@AbapCatalog.sqlViewName: 'ZLL_R_URLAUBSAN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Urlaubsantraege'
define view ZLL_R_Urlaubsantraege
  as select from zll_urlaubsantr
{
  key urlaubsantrag_uuid as UrlaubsantaegeUuid,
      antragsteller_uuid as AntragstellerUuid,
      startdatum         as Startdatum,
      enddatum           as Enddatum,
      kommentar          as Kommentar,
      status             as Status,

      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt

}
