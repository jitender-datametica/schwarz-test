CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_art_gp_nm_zu_aktuell_2 (mandant_id, art_id, akt_gp_id,
gp_name, spr_id) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id AS akt_gp_id,
 v02.gp_name,
 v02.spr_id
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS V01
 INNER JOIN (SELECT V010.mandant_id,
   V010.gp_id,
   v02.spr_id,
    CASE
    WHEN v02.spr_id = 18
    THEN V010.gp_name
    ELSE V010.gp_name_lat
    END AS gp_name
  FROM kfl_production_dbp_view.v_gp_2 AS V010
   INNER JOIN (SELECT DISTINCT spr_id
    FROM kfl_production_dbp_view.v_mandant_spr_zu_2) AS v02 ON TRUE) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.gp_id
    = v02.gp_id
WHERE V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND V01.gp_id <> - 1
 AND V01.mandant_id <> 1;