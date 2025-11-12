@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Basic View Urlaubsantrag'
define view entity ZLL_R_Urlaubsantrag as select from zll_urlaubsantr
association to parent ZLL_R_Mitarbeiter as _Antragsteller on $projection.AntragstellerUuid = _Antragsteller.MitarbeiterUuid
association [1..1] to ZLL_R_Mitarbeiter as _Genehmigender on $projection.GenehmigenderUuid = _Genehmigender.MitarbeiterUuid
association [1..1] to ZLL_I_MitarbeiterText as _GenehmigenderText on $projection.GenehmigenderUuid = _GenehmigenderText.MitarbeiterUuid


{
    key urlaubsantrag_uuid as UrlaubsantragUuid,
    antragsteller_uuid as AntragstellerUuid,
    @ObjectModel.text.element: ['GenehmigenderName']
    genehmigender_uuid as GenehmigenderUuid,
    startdatum as Startdatum,
    enddatum as Enddatum,
    urlaubstage as Urlaubstage,
    kommentar as Kommentar,
    status as Status,
    
    /* Transient Data */
     _GenehmigenderText.Name as GenehmigenderName,
     
     /* Associations */
    _Antragsteller,
    _Genehmigender
   
    
}
