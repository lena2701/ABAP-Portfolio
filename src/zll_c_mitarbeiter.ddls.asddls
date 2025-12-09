@EndUserText.label: 'BO Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZLL_C_Mitarbeiter
  provider contract transactional_query
  as projection on ZLL_R_Mitarbeiter
{
  key MitarbeiterUuid,
      @EndUserText.label: 'Mitarbeiternummer'
      Mitarbeiternummer,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Vorname'
      Vorname,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Nachname'
      Nachname,
      @EndUserText.label: 'Eintrittsdatum'
      Eintrittsdatum,


      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      

      _Urlaubsanspruch : redirected to composition child ZLL_C_Urlaubsanspruch,
      _Urlaubsantrag   : redirected to composition child ZLL_C_Urlaubsantrag

}
