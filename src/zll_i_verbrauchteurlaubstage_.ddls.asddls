@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Verbrauchte Urlaubstage'
define view entity ZLL_I_VerbrauchteUrlaubstage_
  as select from zll_urlaubsantr
{
  key urlaubsantrag_uuid          as UrlaubsantragUuid,
      antragsteller_uuid          as AntragstellerUuid,
      substring(startdatum, 1, 4) as RequestYear,
      urlaubstage                 as FilteredDays

}
where
      enddatum < $session.system_date
  and status   != 'A'
