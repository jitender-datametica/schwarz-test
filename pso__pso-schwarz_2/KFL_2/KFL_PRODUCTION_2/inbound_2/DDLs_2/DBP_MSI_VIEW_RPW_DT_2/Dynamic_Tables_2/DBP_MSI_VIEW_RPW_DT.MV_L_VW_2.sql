create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_VW_2(
	VW_ID,
	MANDANT_ID,
	SPR_ID,
	VK_ID,
	VW_BEZ,
	VWVT_BEZ,
	VWART_ID,
	SAP_VW_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       vw_id,
    mandant_id,
    spr_id,
    vk_id,
    vw_bez,
    vwvt_bez,
    vwart_id,
    sap_vw_id,
    7
    FROM dbp_view.v_l_vw_2
    WHERE mandant_id = 1
      AND spr_id = 22
 ;
