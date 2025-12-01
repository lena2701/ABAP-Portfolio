@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Protection View Mitarbeiter Manager'
define root view entity ZLL_C_Mitarbeiter_M
  provider contract transactional_query
  as projection on ZLL_R_Mitarbeiter
{
  key MitarbeiterUuid,
      Mitarbeiternummer,
      Vorname,
      Nachname,
      Eintrittsdatum,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      MitarbeiterName,
      /* Associations */
      _Antragsteller ,
      _Genehmigender ,
      _Urlaubsanspruch,
      _Urlaubsantrag : redirected to composition child ZLL_C_URLAUBSANTRAEGE

    

}
