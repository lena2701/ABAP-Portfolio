@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view Mitarbeiter Text'
define view entity ZLL_I_AntragstellerText as select from zll_urlaubsantr
{
        key antragsteller_uuid as AntragstellerUuid,
    genehmigender_uuid as Genehmigender,
    startdatum as Startdatum
}
