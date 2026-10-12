create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_NB(
	NB_ID,
	NB_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
--   12.07.2010 A. Lipkin  nb_id =99 aufgenommen

    SELECT
    nb_id,
    nb_bez,
    7
    FROM dbp_view.v_nb
    WHERE nb_id IN (-111,0,2, 99);
