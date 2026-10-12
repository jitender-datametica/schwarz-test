create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WOCHE(
	GJWO,
	GJWO_VJ,
	KJWO,
	KJWO_VJ,
	WO_DAT_VON,
	WO_DAT_BIS,
	AKT_WO,
	AKT_WO_KOMPLETT,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
             SELECT
             gjwo,
             gjwo_vj,
             kjwo,
             kjwo_vj,
             wo_dat_von,
             wo_dat_bis,
             akt_wo,
             akt_wo_komplett,
             7 AS system_id
             FROM dbp_view.v_woche
             WHERE kjwo >= 200501
             AND EXTRACT(YEAR FROM wo_dat_von) <= EXTRACT(YEAR FROM CURRENT_DATE);
