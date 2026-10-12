CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_kreistyp_gruppe_2 (mandant_id, kreistyp_gruppe_id) AS SELECT
 mandant_id,
 kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_l_kreistyp_gruppe_2
WHERE mandant_id = 1;