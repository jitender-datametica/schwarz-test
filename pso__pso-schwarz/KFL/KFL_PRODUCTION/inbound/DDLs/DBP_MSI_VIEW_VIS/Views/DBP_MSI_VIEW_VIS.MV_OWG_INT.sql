create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_OWG_INT(
	ARTHIERTYP_ID,
	OWG_ID,
	HWG_ID,
	SORT_ID,
	ORIG_SORT_ID
) as 
  
 





 
SELECT 
  owg.arthiertyp_id
, owg.owg_id
, owg.hwg_id
, CASE WHEN owg.owg_id > 0 
	THEN ABS(owg.hwg_id*100000) + owg.owg_id
	ELSE ABS(owg.hwg_id*100000) - owg.owg_id*10 
  END ::INTEGER AS sort_id
, owg.hwg_id * 100 - (owg.owg_id - 1000) ::INTEGER AS orig_sort_id
FROM dbp_view.v_owg_per owg
 
WHERE owg.arthiertyp_id = 2 AND owg.dat_bis = '9999-12-31' 
 
GROUP BY ALL;
