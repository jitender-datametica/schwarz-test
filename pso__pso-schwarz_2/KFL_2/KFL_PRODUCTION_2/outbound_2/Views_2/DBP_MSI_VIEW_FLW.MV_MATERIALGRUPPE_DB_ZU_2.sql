CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_materialgruppe_db_zu_2 AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
  CASE
  WHEN V01.beschaffungsart_id = 'E' AND V02.art_col_auspr = 'FFERT' AND V03.art_col_auspr IN ('01', '02', '03', '04')
  THEN 1
  WHEN V01.beschaffungsart_id = 'E' AND V02.art_col_auspr = 'FFERT' AND V03.art_col_auspr IN ('05')
  THEN 2
  WHEN V01.beschaffungsart_id = 'F' AND V02.art_col_auspr = 'FFERT'
  THEN 3
  WHEN V02.art_col_auspr = 'FZERL'
  THEN 4
  ELSE 5
  END AS materialgruppe_db_id
FROM kfl_production_dbp_view.v_flw_art_wup_status_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_col_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02
    .flw_art_id AND V02.flw_art_col_id = 1
 INNER JOIN kfl_production_dbp_view.v_flw_art_col_zu_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.flw_art_id = V03
    .flw_art_id AND V03.flw_art_col_id = 3
 INNER JOIN kfl_production_dbp_view.v_flw_werk_2 AS V04 ON V01.werk_id = V04.werk_id AND V01.mandant_id = V04.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V04.flw_fg = 1;