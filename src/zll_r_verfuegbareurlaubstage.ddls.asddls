@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Verfügbare Urlaubstage'

define view entity ZLL_R_VerfuegbareUrlaubstage as select from zll_urlaubsantr
association [1..1] to ZLL_R_GeplanteUrlaubstage as _geplant on $projection.mitarbeiter = _geplant.mitarbeiter
association [1..1] to ZLL_R_VerbrauchteUrlaubstage as _verbraucht on $projection.mitarbeiter = _verbraucht.mitarbeiter

{
  key antragsteller_uuid as mitarbeiter,
  sum(urlaubstage) - coalesce(_verbraucht.VerbrauchteUrlaubstage, 0) - coalesce(_geplant.GeplanteUrlaubstage, 0) as VerfuegbareUrlaubstage
}

group by
antragsteller_uuid, 
urlaubstage,
_verbraucht.VerbrauchteUrlaubstage,
_geplant.GeplanteUrlaubstage;
    
