CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_materialgruppe (mandant_id, in_art_id, werk_id,
materialgruppe_id) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
  CASE
  WHEN V02.art_col_auspr = '01'
  THEN 1
  WHEN V02.art_col_auspr = '02'
  THEN 2
  WHEN V02.art_col_auspr = '03'
  THEN 3
  ELSE NULL
  END AS materialgruppe_id
FROM kfl_production_dbp_view.v_flw_art_wup_status AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_col_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02
    .flw_art_id AND V02.flw_art_col_id = 2
 INNER JOIN kfl_production_dbp_view.v_flw_werk AS V03 ON V01.werk_id = V03.werk_id AND V01.mandant_id = V03.mandant_id
WHERE CASE
  WHEN V02.art_col_auspr = '01'
  THEN 1
  WHEN V02.art_col_auspr = '02'
  THEN 2
  WHEN V02.art_col_auspr = '03'
  THEN 3
  ELSE NULL
  END IS NOT NULL
 AND V01.mandant_id IN (1, 2)
 AND V03.flw_fg = 1
UNION ALL
SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 4 AS materialgruppe_id
FROM kfl_production_dbp_view.v_flw_art_wup_status AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_col_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02
      .flw_art_id AND V02.flw_art_col_id = 1 AND V02.art_col_auspr = 'FFERT' AND V01.beschaffungsart_id = 'F'
 INNER JOIN kfl_production_dbp_view.v_flw_werk AS V03 ON V01.werk_id = V03.werk_id AND V01.mandant_id = V03.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V03.flw_fg = 1;