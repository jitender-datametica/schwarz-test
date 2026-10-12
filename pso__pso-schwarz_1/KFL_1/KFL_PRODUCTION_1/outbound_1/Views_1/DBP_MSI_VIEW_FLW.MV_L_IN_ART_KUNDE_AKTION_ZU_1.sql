CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_art_kunde_aktion_zu_1 AS SELECT V01.mandant_id,
 V03.flw_kunde_id AS in_kunde_id,
 V02.flw_art_id AS in_art_id,
 V01.dat,
  CASE
  WHEN V01.aktion_fg = 1
  THEN 1002
  ELSE 1001
  END AS bewart_id
FROM kfl_production_dbp_view.v_art_wup_tag_denorm_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id
WHERE V01.mandant_id = 1
 AND V03.wup_id > 0;