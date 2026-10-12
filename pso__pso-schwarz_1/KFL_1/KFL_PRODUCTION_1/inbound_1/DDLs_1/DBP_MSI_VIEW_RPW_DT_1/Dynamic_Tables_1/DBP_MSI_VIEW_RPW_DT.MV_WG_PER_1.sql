create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WG_PER_1(
	WG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	LEAD_MWST_ID,
	DAT_VON,
	ABT_ID,
	DAT_BIS,
	SYSTEM_ID,
	OWG_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    wg_id,
    arthiertyp_id,
    mandant_id,
    lead_mwst_id,
    dat_von,
    abt_id,
    dat_bis,
    7,
    owg_id
FROM dbp_view.v_wg_per_1
WHERE mandant_id = 1
AND arthiertyp_id = 2
AND abt_id NOT IN (0,-1,-2,-3)
AND dat_bis = '9999-12-31';
