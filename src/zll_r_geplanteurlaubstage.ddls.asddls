@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Geplante Urlaubstage'

define view entity ZLL_R_GeplanteUrlaubstage as select from zll_urlaubsantr
{
          antragsteller_uuid as mitarbeiter,
sum( 
case when startdatum > $session.system_date
then urlaubstage
else 0
end) 
as GeplanteUrlaubstage
}
where status <> 'D'
group by
antragsteller_uuid;
    
