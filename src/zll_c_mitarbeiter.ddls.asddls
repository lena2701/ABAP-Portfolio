@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Mitarbeiter'
define root view entity ZLL_C_Mitarbeiter
  as select from ZLL_R_Mitarbeiter
{
  key ID,
      Mitarbeiternummer,
      Vorname,
      Nachname,
      Eintrittsdatum,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
