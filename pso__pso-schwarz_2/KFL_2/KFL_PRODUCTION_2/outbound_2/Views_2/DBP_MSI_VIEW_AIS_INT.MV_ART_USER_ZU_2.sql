CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_art_user_zu_2 AS SELECT DISTINCT V01.art_id,
 V01.mandant_id,
 V02.user_id
FROM kfl_production_dbp_msi_v_view.v_art_zek_zu_2 AS V01
 INNER JOIN kfl_production_dbp_security.user_zek_zu_2 AS V02 ON V01.zek_id = V02.zek_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN (SELECT DISTINCT user_id
  FROM kfl_production_dbp_msi_v_view.v_akt_msi_user_2) AS v03 ON V02.user_id = v03.user_id;