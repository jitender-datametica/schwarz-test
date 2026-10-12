create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_HWG_INT(
	ARTHIERTYP_ID,
	HWG_ID,
	ABT_ID,
	SORT_ID,
	ORIG_SORT_ID
) as 
 







 
SELECT
  hwg.arthiertyp_id
, hwg.hwg_id
, hwg.abt_id
, CASE WHEN hwg.hwg_id > 0
	THEN CASE WHEN hwg.abt_id = 4 THEN 10000 ELSE hwg.abt_id*1000 END + hwg.hwg_id 
	ELSE CASE WHEN hwg.abt_id = 4 THEN 10000 ELSE hwg.abt_id*1000 END - hwg.hwg_id*10 
  END ::INTEGER AS sort_id
, CASE WHEN hwg.abt_id = 4 THEN 10000 ELSE hwg.abt_id * 1000 END 
  + CASE WHEN hwg.hwg_id > 0 THEN hwg.hwg_id ELSE hwg.hwg_id * -10 END ::INTEGER AS orig_sort_id
 
FROM dbp_view.v_hwg_per hwg
 
WHERE hwg.arthiertyp_id = 2 AND hwg.dat_bis = '9999-12-31'
 
GROUP BY ALL;
