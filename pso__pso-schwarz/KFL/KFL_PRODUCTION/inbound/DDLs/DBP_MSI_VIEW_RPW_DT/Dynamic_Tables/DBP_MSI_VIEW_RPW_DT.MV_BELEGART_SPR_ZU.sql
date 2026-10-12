create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BELEGART_SPR_ZU(
	MANDANT_ID,
	BELEGART_ID,
	SPR_ID,
	BELEGART_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
--INC INC5341249 Hard-coded system_id ersetzen durch Spaltenbezug

             SELECT
             mandant_id,
             belegart_id,
             spr_id,
             belegart_bez,
             system_id
             FROM dbp_view.v_belegart_spr_zu
             WHERE mandant_id = 1
             AND spr_id = 22
 ;
