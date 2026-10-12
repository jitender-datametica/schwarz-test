create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_PMR_WERBETHEMA(
	PMR_WERBETHEMA_ID,
	PMR_WERBETHEMA_BEZ
) as
   SELECT 
   v01.pmr_werbethema_id
   , v01.pmr_werbethema_bez                 
   FROM dbp_view.v_pmr_werbethema  v01
   UNION ALL
   SELECT
   '0'
   , ' ';