create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_RECH_KONTOART_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_KONTOART_ID,
	SPR_ID,
	RECH_KONTOART_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       rech_kontoart_id,
       spr_id,
       rech_kontoart_bez
       FROM dbp_view.v_rech_kontoart_spr_zu
       WHERE mandant_id = 1
       AND  spr_id = 22

       UNION ALL

       SELECT
       7,
       1,
       '0',
       22,
       'system generated'
       FROM dbp_view.v_rech_kontoart_spr_zu
       GROUP BY 1,2,3,4
 ;
