CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_mat_kjwo_update_1 (mandant_id, kjmo, kjwo_update) AS
SELECT mandant_id,
 kjmo,
 kjwo_update
FROM kfl_production_dbp_view.v_l_kjmo_sort_1
WHERE (mandant_id, kjwo_update) IN (SELECT (mandant_id, a500_kjwo_update)
   FROM kfl_production_dbp_msi_data.tupel_mat_1
   GROUP BY mandant_id,
    a500_kjwo_update)
 AND (kjwo_update > 202046 AND mandant_id = 1 OR kjwo_update >= 202205 AND mandant_id <> 1 AND (kjwo_update NOT IN (202217
        , 202218) OR mandant_id <> 2));