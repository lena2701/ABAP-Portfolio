
@AbapCatalog.sqlViewName: 'ZLL_I_GEPLANT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Geplante Urlaubstage'

define view ZLL_I_GeplanteUrlaubstage_ as select from zll_urlaubsantr
{
          antragsteller_uuid as mitarbeiter,
sum( 
case when startdatum > $session.system_date
then urlaubstage
else 0
end) 
as GeplanteUrlaubstage
}
where status <> 'A'
group by
antragsteller_uuid;
    

    
