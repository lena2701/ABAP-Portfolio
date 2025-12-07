@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TextElement für geplante urlaubstage'

define view entity ZLL_I_GeplanteUrlaubstageText as select from zll_urlaubsanspr
 association to ZLL_I_GeplanteUrlaubstage_ as _geplanteurlaubstage on $projection.MitarbeiterUuid = _geplanteurlaubstage.AntragstellerUuid
{
    key urlaubsanspruch_uuid        as UrlaubsanspruchUuid,
      mitarbeiter_uuid                    as MitarbeiterUuid,
      sum( _geplanteurlaubstage.FilteredDays ) as GeplanteUrlaubstage
      
}
where
  _geplanteurlaubstage.RequestYear = jahr
group by
  urlaubsanspruch_uuid,
  mitarbeiter_uuid
