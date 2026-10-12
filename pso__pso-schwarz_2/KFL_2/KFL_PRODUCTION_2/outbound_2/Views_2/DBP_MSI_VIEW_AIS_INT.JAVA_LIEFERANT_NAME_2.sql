CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_lieferant_name_2 (mandant_id, a500, matching_id, a418,
spr_id) AS SELECT T1.mandant_id,
 T1.kjwo_update AS a500,
 T1.matching_id,
 T1.akt_lieferant AS a418,
 t2.spr_id
FROM kfl_production_dbp_view.v_sortiment_leistung_2 AS T1_2
 INNER JOIN (SELECT mandant_id,
    spr_id
   FROM kfl_production_dbp_view.v_mandant_spr_zu_2
   UNION DISTINCT
   SELECT mandant_id,
    22 AS spr_id
   FROM kfl_production_dbp_view.v_mandant_spr_zu_2) AS t2 ON T1.mandant_id = t2.mandant_id;