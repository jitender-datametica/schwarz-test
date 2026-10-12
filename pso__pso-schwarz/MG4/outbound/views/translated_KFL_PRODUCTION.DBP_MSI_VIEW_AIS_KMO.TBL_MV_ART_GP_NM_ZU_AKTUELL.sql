CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_art_gp_nm_zu_aktuell (mandant_id, art_id, akt_gp_id,
gp_name, spr_id) AS SELECT v01.mandant_id,
 v01.art_id,
 v01.gp_id AS akt_gp_id,
 v02.gp_name,
 v02.spr_id
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS v01
 INNER JOIN (SELECT v010.mandant_id,
   v010.gp_id,
   v02.spr_id,
    CASE
    WHEN v02.spr_id = 18
    THEN v010.gp_name
    ELSE v010.gp_name_lat
    END AS gp_name
  FROM kfl_production_dbp_view.v_gp AS v010
   INNER JOIN (SELECT DISTINCT spr_id
    FROM kfl_production_dbp_view.v_mandant_spr_zu) AS v02 ON TRUE) AS v02 ON v01.mandant_id = v02.mandant_id AND v01.gp_id
    = v02.gp_id
WHERE v01.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND v01.gp_id <> - 1
 AND v01.mandant_id <> 1;