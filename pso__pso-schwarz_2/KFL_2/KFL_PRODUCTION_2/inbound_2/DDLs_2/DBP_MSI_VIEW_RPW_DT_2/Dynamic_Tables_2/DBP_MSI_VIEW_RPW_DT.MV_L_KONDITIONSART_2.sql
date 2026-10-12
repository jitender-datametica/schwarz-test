create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_KONDITIONSART_2(
	SYSTEM_ID,
	MANDANT_ID,
	KONDITIONSART_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 20101130 K.Kaiser -- UNION ALL

    SELECT
    7,
    mandant_id,
    konditionsart_id
    FROM dbp_view.v_l_konditionsart_2
    WHERE mandant_id = 1

 --UNION ALL

 --SELECT
 --  7 AS system_id
 --  ,1 AS mandant_id
 -- ,'0' AS konditionsart_id
 --FROM dbp_view.v_l_konditionsart_2
 --GROUP BY 1,2,3
;
