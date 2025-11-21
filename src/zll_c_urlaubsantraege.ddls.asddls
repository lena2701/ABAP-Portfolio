@AbapCatalog.sqlViewName: 'ZLL_C_URLAUBSAN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsantraege'
@Search.searchable: true
@Metadata.allowExtensions: true
define view ZLL_C_URLAUBSANTRAEGE
  as select from ZLL_R_Urlaubsantraege
{
  key UrlaubsantaegeUuid,
      @EndUserText.label: 'Atragsteller'
      AntragstellerUuid,
      Startdatum,
      Enddatum,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Kommentar,
      Status,
      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
