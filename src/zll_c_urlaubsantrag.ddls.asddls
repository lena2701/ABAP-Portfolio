@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsantrag'
@Metadata.allowExtensions: true

define view entity ZLL_C_Urlaubsantrag as projection on ZLL_R_Urlaubsantrag
{
    key UrlaubsantragUuid,
    AntragstellerUuid,
    GenehmigenderUuid,
    @EndUserText.label: 'Startdatum'
    Startdatum,
    @EndUserText.label: 'Enddatum'
    Enddatum,
    @EndUserText.label: 'Urlaubsatage'
    Urlaubstage,
    @EndUserText.label: 'Kommentar'
    Kommentar,
    @EndUserText.label: 'Status'
    Status,
    
     _Antragsteller : redirected to parent ZLL_C_Mitarbeiter,
    _Genehmigender : redirected to ZLL_C_Mitarbeiter

    
}
