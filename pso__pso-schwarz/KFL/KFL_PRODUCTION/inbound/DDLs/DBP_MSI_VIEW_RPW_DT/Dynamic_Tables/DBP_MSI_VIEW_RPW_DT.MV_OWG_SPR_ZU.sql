create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_OWG_SPR_ZU(
	OWG_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	OWG_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       owg_id,
       spr_id,
       arthiertyp_id,
       mandant_id,
       owg_bez,
       7
       FROM dbp_view.v_owg_spr_zu
       WHERE mandant_id = 1
       AND  spr_id = 22
       AND  arthiertyp_id = 2
       --17.07.10: Filterung der Korrektur- WG aus VIS/MIS
       AND owg_id >= -3;
