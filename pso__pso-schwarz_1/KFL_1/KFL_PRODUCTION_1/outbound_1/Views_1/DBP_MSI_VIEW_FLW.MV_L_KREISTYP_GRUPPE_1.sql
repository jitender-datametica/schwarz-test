CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_kreistyp_gruppe_1 (mandant_id, kreistyp_gruppe_id) AS SELECT
 mandant_id,
 kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_l_kreistyp_gruppe_1
WHERE mandant_id IN (1, 2)
UNION ALL
SELECT mandant_id,
 '-1' AS kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id IN (1, 2);