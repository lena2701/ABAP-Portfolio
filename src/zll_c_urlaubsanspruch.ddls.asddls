@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Urlaubsanspruch'
define view entity ZLL_C_Urlaubsanspruch as select from ZLL_R_Urlaubsanspruch
{
    key UrlaubsanspruchUuid,
    MitarbeiterUuid,
    Jahr,
    Urlaubstage
    
}
