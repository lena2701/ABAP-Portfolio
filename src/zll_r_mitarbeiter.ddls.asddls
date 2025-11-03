@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Mitarbeiter'
define root view entity ZLL_R_Mitarbeiter
  as select from zll_mitarbeiter
{
  key id_uuid           as ID,
      mitarbeiternummer as Mitarbeiternummer,
      vorname           as Vorname,
      nachname          as Nachname,
      eintrittsdatum    as Eintrittsdatum,
      
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
      
}
