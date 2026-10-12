create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LAGER_BEWART_SPR_ZU_2(
	MANDANT_ID,
	LAGER_BEWART_ID,
	SPR_ID,
	LAGER_BEWART_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                      SELECT
                      v01.mandant_id,
                      v01.lager_bewart_id,
                      v01.spr_id,
                      v01.lager_bewart_bez,
                      7 AS system_id
                      FROM dbp_view.v_lager_bewart_spr_zu_2 v01

                      WHERE v01.mandant_id = 1
                      AND v01.spr_id = 22
                      --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
                      AND v01.system_id NOT IN (2,17,28,32,48,53);
