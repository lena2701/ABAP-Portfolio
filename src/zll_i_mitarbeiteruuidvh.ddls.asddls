@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MitarbeiterUuid Value Help'

define view entity ZLL_I_MitarbeiterUuidVH
  as select from zll_mitarbeiter
{
      @EndUserText: { label: 'Mitarbeiter Uuid', quickInfo: 'MitarbeiterUuid' }
  key mitarbeiter_uuid  as MitarbeiterUuid,

      @EndUserText: { label: 'Mitarbeiternummer', quickInfo: 'Mitarbeiternummer' }
      mitarbeiternummer as Mitarbeiternummer,

      @EndUserText: { label: 'Vorname', quickInfo: 'Vorname' }
      vorname           as Vorname,

      @EndUserText: { label: 'Nachname', quickInfo: 'Nachname' }
      nachname          as Nachname
}
