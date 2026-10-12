create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_PMR_WERBETHEMA(
	PMR_WERBETHEMA_ID,
	PMR_WERBETHEMA_BEZ
) as


SELECT 
   v01.werbethema_id AS pmr_werbethema_id
   , v01.werbethema_bez AS pmr_werbethema_bez                 
   FROM dbp_view.v_ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU v01 
   GROUP BY 1,2
  


;
