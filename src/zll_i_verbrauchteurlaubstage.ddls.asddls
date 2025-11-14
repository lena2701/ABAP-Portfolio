@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Verbrauchte Urlaubstage'
define view entity ZLL_I_VerbrauchteUrlaubstage as select from zll_urlaubsantr
{
        antragsteller_uuid as mitarbeiter,
     sum(
        case when enddatum > $session.user_date and startdatum < $session.user_date
          then
           dats_days_between(startdatum, enddatum) 
          when enddatum < $session.user_date and startdatum < $session.user_date
          then
            urlaubstage
           else 0
        end)       
 as VerbrauchteUrlaubstage
}
where status = 'G'
group by
antragsteller_uuid;
    
