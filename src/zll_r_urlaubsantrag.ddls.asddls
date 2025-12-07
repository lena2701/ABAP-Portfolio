@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Basic View Urlaubsantrag'
define view entity ZLL_R_Urlaubsantrag as select from zll_urlaubsantr
association to parent ZLL_R_Mitarbeiter as _Genehmigender on $projection.GenehmigenderUuid = _Genehmigender.MitarbeiterUuid
association to ZLL_R_Mitarbeiter as _Antragsteller on $projection.AntragstellerUuid = _Antragsteller.MitarbeiterUuid

{
    key urlaubsantrag_uuid as UrlaubsantragUuid,
    antragsteller_uuid as AntragstellerUuid,
    genehmigender_uuid as GenehmigenderUuid,
    startdatum as Startdatum,
    enddatum as Enddatum,
    urlaubstage as Urlaubstage,
    kommentar as Kommentar,
    status as Status,
    
    _Genehmigender,
    _Antragsteller
}
