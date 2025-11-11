@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help für Mitarbeiter'
@AbapCatalog.sqlViewName: 'ZLLIMTVH'
define view ZLL_I_MitarbeiterVH
  as select from zll_mitarbeiter
{
  key mitarbeiter_uuid  as MitarbeiterUuid,
      vorname           as Vorname,
      nachname          as Nachname
   
}
