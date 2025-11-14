@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsanspruch'
@Metadata.allowExtensions: true

define view entity ZLL_C_Urlaubsanspruch
  as projection on ZLL_R_Urlaubsanspruch
{
  key UrlaubsanspruchUuid,
      MitarbeiterUuid,
      @EndUserText.label: 'Jahr'
      Jahr,
      @EndUserText.label: 'Urlaubstage'
      Urlaubstage,
      MitarbeiterName,
      CreatedBy,
     CreatedAt,
     LastChangedBy,
     LastChangedAt,


      _Mitarbeiter : redirected to parent ZLL_C_Mitarbeiter



}
