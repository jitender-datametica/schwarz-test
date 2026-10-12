create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GP_ZUSATZ_PER(
	MANDANT_ID,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	DAT_VON,
	ENTGELT_MIND_KZ,
	RET_SPERRPROFIL_ID,
	SYSTEM_ID,
	DAT_BIS
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                SELECT
                mandant_id,
                gp_id,
                einkaufsorganisation_id,
                dat_von,
                entgelt_mind_kz,
                ret_sperrprofil_id,
                7,
                dat_bis
                FROM dbp_view.v_gp_zusatz_per
                WHERE (gp_id, mandant_id,  dat_bis) IN
                (
                SELECT
                gp_id,
                mandant_id,
                MAX(dat_bis)
                FROM dbp_view.v_gp_zusatz_per
                WHERE mandant_id = 1
                GROUP BY 1,2
                );
