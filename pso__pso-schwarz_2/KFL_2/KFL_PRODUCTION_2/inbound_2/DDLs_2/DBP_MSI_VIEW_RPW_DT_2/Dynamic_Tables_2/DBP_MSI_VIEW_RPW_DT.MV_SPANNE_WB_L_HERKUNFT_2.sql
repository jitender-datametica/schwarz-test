create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPANNE_WB_L_HERKUNFT_2(
	SPANNE_WB_HERKUNFT_ID,
	SPANNE_WB_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    spr_id AS spanne_wb_herkunft_id,
    CASE
    WHEN spanne_wb_herkunft_id =1
    THEN  'Umlagerung_2 VZ => VZ oder Lieferant => Markt                            '

    WHEN spanne_wb_herkunft_id =2
    THEN  'Dezentral Lieferant => VZ/Markt sowie Umlagerung_2 Markt => Markt'

    WHEN spanne_wb_herkunft_id =3
    THEN  'Zentral VZ => Markt (""Faktura"")'
    END                 AS spanne_wb_herkunft_bez
    FROM dbp_view.v_spr_2
    WHERE spr_id IN ( 1,2,3);
