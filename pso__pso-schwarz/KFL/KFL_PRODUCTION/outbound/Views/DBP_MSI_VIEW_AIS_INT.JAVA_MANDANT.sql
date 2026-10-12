CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_mandant (mandant_id, mandant_bez, mandant_kbez,
default_wrg) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 default_wrg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id NOT IN (4);