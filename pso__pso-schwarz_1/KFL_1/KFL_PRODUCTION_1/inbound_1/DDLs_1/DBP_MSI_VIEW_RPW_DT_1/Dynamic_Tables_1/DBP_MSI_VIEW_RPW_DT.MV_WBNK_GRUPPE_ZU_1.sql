create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WBNK_GRUPPE_ZU_1(
	SYSTEM_ID,
	MANDANT_ID,
	WBNKART_ID,
	ROW_GRUND_ID,
	KONDITIONSART_ID,
	WBNK_GRUPPE_ID,
	WBNK_GRUPPE_BEZ,
	WBNK_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    v01.mandant_id,
    v01.wbnk_id AS wbnkart_id,
    CASE WHEN SUBSTR( v01.wbnk_id, 1, 2) <> 'YN' THEN v01.wbnk_id ELSE '0'
    END AS konditionsart_id,
    CASE WHEN SUBSTR( v01.wbnk_id, 1, 2) = 'YN' THEN v01.wbnk_id ELSE '0'
    END AS row_grund_id,
    v01.wbnk_gruppe_id,
    v02.wbnk_gruppe_bez,
    v03.wbnk_bez
    FROM dbp_view.v_wbnk_gruppe_zu_1 v01
    INNER JOIN dbp_view.v_wbnk_gruppe_spr_zu_1 v02
    ON v01.mandant_id = v02.mandant_id AND
    v01.wbnk_gruppe_id = v02.wbnk_gruppe_id AND
    v02.spr_id = 22
    INNER JOIN dbp_view.v_wbnk_spr_zu_1 v03
    ON v01.mandant_id = v03.mandant_id AND
    v01.wbnk_id = v03.wbnk_id AND
    v03.spr_id = 22

    WHERE v01.mandant_id =1;
