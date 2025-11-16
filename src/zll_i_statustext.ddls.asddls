
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text Element Status'

define view entity ZLL_I_StatusText as select from zll_urlaubsantr
{
     key urlaubsantrag_uuid,
      status,

      case
        when status = 'B' then 'Beantragt'
        when status = 'A' then 'Abgelehnt'
        when status = 'G' then 'Genehmigt'
        else ''
      end as StatusText
}
