CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemcode_gruppe_zu_2 (system_id, mandant_id, problemgruppe_id
, problemcode_id) AS SELECT 7 AS system_id,
 mandant_id,
 problemgruppe_id,
 problemcode_id
FROM kfl_production_dbp_view.v_problemcode_gruppe_zu_2
WHERE mandant_id = 1;