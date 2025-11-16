@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsantrag'
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZLL_C_Urlaubsantrag
  as projection on ZLL_R_Urlaubsantrag
{
  key UrlaubsantragUuid,
      AntragstellerUuid,
      @Search.defaultSearchElement: true
      AntragstellerName,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLL_I_MitarbeiterVH', element: 'MitarbeiterUuid' } }]
      GenehmigenderUuid,
      GenehmigenderName,
      @EndUserText.label: 'Startdatum'
      Startdatum,
      @EndUserText.label: 'Enddatum'
      Enddatum,
      @EndUserText.label: 'Urlaubsatage'
      Urlaubstage,
      @EndUserText.label: 'Kommentar'
      Kommentar,
      @ObjectModel.text.element: [ 'StatusText' ]
      Status,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      StatusText,

    


      /* Administrative Data */
      _Antragsteller : redirected to parent ZLL_C_Mitarbeiter,
      _Genehmigender : redirected to ZLL_C_Mitarbeiter

}
