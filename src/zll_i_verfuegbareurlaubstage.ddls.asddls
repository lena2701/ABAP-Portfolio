
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Verfügbare Urlaubstage'

define view entity ZLL_I_VerfuegbareUrlaubstage as select from zll_urlaubsanspr 

association [1..1] to ZLL_I_GeplanteUrlaubstage_ as _geplant on $projection.mitarbeiter = _geplant.mitarbeiter
association [1..1] to ZLL_I_VerbrauchteUrlaubstage_ as _verbraucht on $projection.mitarbeiter = _verbraucht.mitarbeiter

{
  key mitarbeiter_uuid as mitarbeiter,

  sum(urlaubstage) - coalesce(_verbraucht.VerbrauchteUrlaubstage, 0) - coalesce(_geplant.GeplanteUrlaubstage, 0) as VerfuegbareUrlaubstage
  
}

group by
mitarbeiter_uuid, 
urlaubstage,
_verbraucht.VerbrauchteUrlaubstage,
_geplant.GeplanteUrlaubstage;
