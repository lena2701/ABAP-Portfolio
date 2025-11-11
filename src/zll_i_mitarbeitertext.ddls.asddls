@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Textelement für Mitarbeiter'

define view entity ZLL_I_MitarbeiterText as select from zll_mitarbeiter
{
    key mitarbeiter_uuid as MitarbeiterUuid,
    vorname as Vorname, 
    nachname as Nachname,
    
     concat_with_space(vorname, nachname, 1) as Name
    
}
