@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Mitarbeiter'
define root view entity ZLL_R_Mitarbeiter
  as select from zll_mitarbeiter
  composition [0..*] of ZLL_R_Urlaubsanspruch        as _Urlaubsanspruch
  composition [0..*] of ZLL_R_Urlaubsantrag          as _Urlaubsantrag
  association [1..1] to ZLL_I_MitarbeiterText        as _MitarbeiterText on $projection.MitarbeiterUuid = _MitarbeiterText.MitarbeiterUuid
  association [1..*] to ZLL_R_Urlaubsantrag          as _Antragsteller on $projection.MitarbeiterUuid = _Antragsteller.AntragstellerUuid
  association [1..*] to ZLL_R_Urlaubsantrag          as _Genehmigender on $projection.MitarbeiterUuid = _Genehmigender.GenehmigenderUuid
  association [1..1] to ZLL_R_VerfuegbareUrlaubstage as _verfuegbar    on $projection.MitarbeiterUuid = _verfuegbar.mitarbeiter
  association [1..1] to ZLL_R_GeplanteUrlaubstage    as _geplant       on $projection.MitarbeiterUuid = _geplant.mitarbeiter
  association [1..1] to ZLL_R_VerbrauchteUrlaubstage as _verbraucht    on $projection.MitarbeiterUuid = _verbraucht.mitarbeiter

{
  key mitarbeiter_uuid                   as MitarbeiterUuid,
      mitarbeiternummer                  as Mitarbeiternummer,
      vorname                            as Vorname,
      nachname                           as Nachname,
      eintrittsdatum                     as Eintrittsdatum,

      created_by                         as CreatedBy,
      created_at                         as CreatedAt,
      last_changed_by                    as LastChangedBy,
      last_changed_at                    as LastChangedAt,

      _verbraucht.VerbrauchteUrlaubstage as VerbrauchteUrlaubstage,
      _geplant.GeplanteUrlaubstage       as GeplanteUrlaubstage,
      _verfuegbar.VerfuegbareUrlaubstage as VerfuegbareUrlaubstage,


      _Urlaubsanspruch,
      _Antragsteller,
      _Genehmigender,
      _Urlaubsantrag,
      
      _MitarbeiterText.Name as MitarbeiterName
      
      


}
