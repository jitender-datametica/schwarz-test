CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_rech_det_regalachse_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.bsch_id AS bsch_id,
  v01.bsch_pos_id AS bsch_pos_id,
  v01.art_id AS art_id,
  r.fbb_nr AS fbb_nr,
  r.fachboden_nr AS fachboden_nr,
  r.fachboden_pos AS fachboden_pos,
  v01.dat AS dat,
  v01.bewart_id AS bewart_id,
  v01.mandant_id AS mandant_id,
  v01.nb_id AS nb_id,
  v01.gp_id AS gp_id,
  v01.ba_id AS ba_id,
  v01.ba_pos_id AS ba_pos_id,
  v01.ek_mep AS ek_mep,
  v01.status_1 AS status_1,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.ek_mep
    ELSE NULL
  END AS lief_ek_mep_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.ek_mep
    ELSE NULL
  END AS lief_ek_mep_umsatz_ret,
  v01.lager_bewart_id AS lager_bewart_id,
  v01.wup_id AS wup_id
FROM kfl_production_dbp_view.v_bsch_rech_det_1 AS v01
INNER JOIN kfl_production_dbp_view.v_regalachse_akt_1 AS r
  ON v01.art_id = r.art_id
  AND v01.mandant_id = r.mandant_id
  AND v01.wup_id = r.wup_id
  AND v01.nb_id = r.nb_id
WHERE
  v01.mandant_id = 1
  AND r.mandant_id = 1
  AND v01.status_1 <> 2
  AND NOT v01.nb_id IN (2, 6, 7);
