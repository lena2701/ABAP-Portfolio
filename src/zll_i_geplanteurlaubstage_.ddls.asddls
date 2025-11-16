
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Geplante Urlaubstage'

define view entity ZLL_I_GeplanteUrlaubstage_ as select from zll_urlaubsantr
{
key urlaubsantrag_uuid as UrlaubsantragUuid,
antragsteller_uuid as AntragstellerUuid,
substring(startdatum, 1, 4) as RequestYear,
 urlaubstage               as FilteredDays

}
where
      startdatum > $session.system_date
  and status     != 'A'



    
