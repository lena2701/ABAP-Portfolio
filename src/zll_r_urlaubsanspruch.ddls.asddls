@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Basic View Urlaubsanspruch'
define view entity ZLL_R_Urlaubsanspruch
  as select from zll_urlaubsanspr
  association to parent ZLL_R_Mitarbeiter as _Mitarbeiter on $projection.MitarbeiterUuid = _Mitarbeiter.MitarbeiterUuid
  
{
  key urlaubsanspruch_uuid as UrlaubsanspruchUuid,
      mitarbeiter_uuid     as MitarbeiterUuid,
      jahr                 as Jahr,
      urlaubstage          as Urlaubstage,

      _Mitarbeiter

}
