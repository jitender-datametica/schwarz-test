create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_OWG_PER_2(
	OWG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	HWG_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    owg_id,
    arthiertyp_id,
    mandant_id,
    dat_von,
    dat_bis,
    hwg_id,
    7
    FROM dbp_view.v_owg_per_2
    WHERE mandant_id = 1
    AND arthiertyp_id = 2
    AND dat_bis = '9999-12-31';
