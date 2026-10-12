CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_art_einkaeuf_bis_zu_2 (art_mandant_id, in_art_id,
eink_mandant_id, einkaeufer_bis_id) AS SELECT mandant_id AS art_mandant_id,
 in_art_id,
 99 AS eink_mandant_id,
 einkaeufer_bis_int_id AS einkaeufer_bis_id
FROM kfl_production_dbp_view.v_in_art_2 AS V01
UNION DISTINCT
SELECT mandant_id AS art_mandant_id,
 in_art_id,
 mandant_id AS eink_mandant_id,
 COALESCE(einkaeufer_grp_id, '-1') AS einkaeufer_bis_id
FROM kfl_production_dbp_view.v_in_art_2 AS V01;