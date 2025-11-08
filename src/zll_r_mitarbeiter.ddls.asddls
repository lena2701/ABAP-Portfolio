@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Mitarbeiter'
define root view entity ZLL_R_Mitarbeiter
  as select from zll_mitarbeiter
  composition [0..*] of ZLL_R_Urlaubsanspruch as _Urlaubsanspruch
  composition [0..*] of ZLL_R_Urlaubsantrag as _Urlaubsantrag
  
  
{
  key mitarbeiter_uuid  as MitarbeiterUuid,
      mitarbeiternummer as Mitarbeiternummer,
      vorname           as Vorname,
      nachname          as Nachname,
      eintrittsdatum    as Eintrittsdatum,

      created_by        as CreatedBy,
      created_at        as CreatedAt,
      last_changed_by   as LastChangedBy,
      last_changed_at   as LastChangedAt,
        
       
       _Urlaubsanspruch,
       _Urlaubsantrag
       
      
}
