@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsantraege'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZLL_C_URLAUBSANTRAEGE
  as projection on ZLL_R_Urlaubsantrag
{
  key UrlaubsantragUuid,
      @EndUserText.label: 'Atragssteller'
      AntragstellerUuid,
      GenehmigenderUuid,
      @EndUserText.label: 'Startdatum'
      Startdatum,
      @EndUserText.label: 'Enddatum'
      Enddatum,
      @EndUserText.label: 'Kommentar'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Kommentar,
      @EndUserText.label: 'Status'
      Status,
      StatusText,
      Urlaubstage,

      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      GenehmigenderName,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLL_I_MitarbeiterText', element: 'Name' } }]
      AntragstellerName,
      StatusKritikalitaet,


      /*Assoiations*/
      _Antragsteller : redirected to parent ZLL_C_Mitarbeiter_M,
      _Genehmigender : redirected to ZLL_C_Mitarbeiter_M




}
