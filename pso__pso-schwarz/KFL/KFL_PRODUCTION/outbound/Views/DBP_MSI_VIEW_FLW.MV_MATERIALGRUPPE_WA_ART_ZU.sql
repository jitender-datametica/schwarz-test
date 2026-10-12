CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_materialgruppe_wa_art_zu (mandant_id, in_art_id, werk_id,
materialgruppe_id) AS SELECT prd_stufe1.mandant_id,
 prd_stufe1.flw_art_id AS in_art_id,
 V01.werk_id,
  CASE
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '01' AND V01.beschaffungsart_id = 'E'
  THEN 1
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '02' AND V01.beschaffungsart_id = 'E'
  THEN 2
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '03' AND V01.beschaffungsart_id = 'E'
  THEN 3
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND V01.beschaffungsart_id = 'F'
  THEN 4
  ELSE NULL
  END AS materialgruppe_id
FROM (SELECT art_col_auspr,
   mandant_id,
   flw_art_id
  FROM kfl_production_dbp_view.v_flw_art_col_zu
  WHERE flw_art_col_id = 1) AS prd_stufe1
 INNER JOIN (SELECT art_col_auspr,
   mandant_id,
   flw_art_id
  FROM kfl_production_dbp_view.v_flw_art_col_zu
  WHERE flw_art_col_id = 2) AS prd_stufe2 ON prd_stufe1.mandant_id = prd_stufe2.mandant_id AND prd_stufe1.flw_art_id =
   prd_stufe2.flw_art_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_wup_status AS V01 ON prd_stufe2.mandant_id = V01.mandant_id AND prd_stufe2
   .flw_art_id = V01.flw_art_id
 INNER JOIN kfl_production_dbp_view.v_flw_werk AS V02 ON V01.werk_id = V02.werk_id AND V01.mandant_id = V02.mandant_id
WHERE CASE
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '01' AND V01.beschaffungsart_id = 'E'
  THEN 1
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '02' AND V01.beschaffungsart_id = 'E'
  THEN 2
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND prd_stufe2.art_col_auspr = '03' AND V01.beschaffungsart_id = 'E'
  THEN 3
  WHEN prd_stufe1.art_col_auspr = 'FFERT' AND V01.beschaffungsart_id = 'F'
  THEN 4
  ELSE NULL
  END IS NOT NULL
 AND V01.mandant_id IN (1, 2)
 AND V02.flw_fg = 1;