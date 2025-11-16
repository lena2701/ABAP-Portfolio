
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TextElement für verbrauchte urlaubstage'

define view entity ZLL_I_VerbrauchteUrlaubstageT as select from zll_urlaubsanspr
association to ZLL_I_VerbrauchteUrlaubstage_ as _verbrauchteurlaubstage on $projection.MitarbeiterUuid = _verbrauchteurlaubstage.AntragstellerUuid
{
    key urlaubsanspruch_uuid     as UrlaubsanspruchUuid,
      mitarbeiter_uuid                 as MitarbeiterUuid,
      sum( _verbrauchteurlaubstage.FilteredDays ) as VerbrauchteUrlaubstage
      
}
where
  _verbrauchteurlaubstage.RequestYear = jahr
group by
  urlaubsanspruch_uuid,
  mitarbeiter_uuid
    
