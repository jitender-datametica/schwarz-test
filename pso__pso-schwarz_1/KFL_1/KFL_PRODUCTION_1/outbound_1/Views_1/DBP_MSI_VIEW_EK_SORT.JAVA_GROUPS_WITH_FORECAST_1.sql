CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_groups_with_forecast_1 (mandant_id, owg_id, wg_id, wug_id
, kjwo_update) AS SELECT mandant_id,
 a5_owg_id AS owg_id,
 a7_wg_id AS wg_id,
 wug_id,
 a500_kjwo_update AS kjwo_update
FROM kfl_production_dbp_msi_data.tupel_mat_1 AS MAT
WHERE EXISTS (SELECT 1
  FROM (SELECT mandant_id,
     a500_kjwo_update,
     matching_id,
     a50_listungsaktion
    FROM kfl_production_dbp_msi_data.tupel_mat_forecast_1
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(a500_kjwo_update AS STRING), CAST(matching_id AS STRING)
          ORDER BY execution_timestamp IS NULL DESC, execution_timestamp DESC)) = 1) AS t6
  WHERE MAT.mandant_id = mandant_id
   AND MAT.a500_kjwo_update = a500_kjwo_update
   AND MAT.matching_id = matching_id
   AND a50_listungsaktion IN ('3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))
GROUP BY mandant_id,
 owg_id,
 wug_id,
 wg_id,
 kjwo_update;