@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Mitarbeiter'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZLL_C_Mitarbeiter
  as select from ZLL_R_Mitarbeiter
{
  key MitarbeiterUuid,
      Mitarbeiternummer,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Vorname,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Nachname,
      Eintrittsdatum,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
      
}
