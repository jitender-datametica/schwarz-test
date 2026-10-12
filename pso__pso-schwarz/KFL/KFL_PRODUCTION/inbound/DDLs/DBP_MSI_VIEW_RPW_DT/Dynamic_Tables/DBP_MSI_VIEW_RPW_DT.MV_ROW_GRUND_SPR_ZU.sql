create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ROW_GRUND_SPR_ZU(
	MANDANT_ID,
	ROW_GRUND_ID,
	SPR_ID,
	ROW_GRUND_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 11.09.2025 pkra: group by added to first select to avoid duplicated values.
-- 12.09.2025 pkra: unnecessary part removed from second select. this select is only about to give single row.
       SELECT
       mandant_id,
       row_grund_id,
       spr_id,
       row_grund_bez,
       7 AS system_id 
       FROM dbp_view.v_row_grund_spr_zu
       WHERE mandant_id = 1
       AND spr_id = 22
	GROUP BY 
	mandant_id,
       row_grund_id,
       spr_id,
       row_grund_bez
	   
       UNION ALL

       SELECT
       1 AS mandant_id ,
       '0' AS row_grund_id,
       22 AS spr_id ,
       'Sachkontenbuchung ohne ROW' AS row_grund_bez,
       7 AS system_id;
