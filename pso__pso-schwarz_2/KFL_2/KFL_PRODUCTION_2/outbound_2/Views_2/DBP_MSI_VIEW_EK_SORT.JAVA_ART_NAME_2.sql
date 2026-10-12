CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_art_name_2 AS SELECT T1.mandant_id,
 T1.kjwo_update AS a500,
 T1.matching_id,
 T2.art_bez AS a12,
 T2.spr_id
FROM kfl_production_dbp_view.v_sortiment_leistung_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id;