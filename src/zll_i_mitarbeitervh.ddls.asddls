@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help für Mitarbeiter'
define view entity ZLL_I_MitarbeiterVH
  as select from zll_mitarbeiter
{
  key mitarbeiter_uuid                          as MitarbeiterUuid,
      @EndUserText.label: 'Mitarbeiternummer'
      mitarbeiternummer                         as Mitarbeiternummer,
      @EndUserText.label: 'Vorname'
      vorname                                   as Vorname,
      @EndUserText.label: 'Nachname'
      nachname                                  as Nachname,
      concat_with_space( vorname, nachname, 1 ) as Name

}
