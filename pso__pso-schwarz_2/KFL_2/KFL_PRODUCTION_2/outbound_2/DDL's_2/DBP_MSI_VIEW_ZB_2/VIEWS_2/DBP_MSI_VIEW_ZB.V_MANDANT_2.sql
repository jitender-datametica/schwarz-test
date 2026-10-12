CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_mandant_2 (mandant_id, mandant_bez, mandant_kbez, mandant_sort_id
) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_data.mandant_2;