CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_art_name (mandant_id, a500, matching_id, a12, spr_id) AS
SELECT T1.mandant_id,
 T1.kjwo_update AS a500,
 T1.matching_id,
 T2.art_bez AS a12,
 T2.spr_id
FROM kfl_production_dbp_view.v_sortiment_leistung AS T1
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS T2 ON T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id;