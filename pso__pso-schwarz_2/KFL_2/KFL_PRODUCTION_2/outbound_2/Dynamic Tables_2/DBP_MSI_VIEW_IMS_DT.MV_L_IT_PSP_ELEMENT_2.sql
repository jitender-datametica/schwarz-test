CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_psp_element_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v02.mandant_id AS mandant_id,
  v02.psp_id AS it_psp_id,
  v02.psp_id_char AS it_psp_id_char,
  v02.psp_bez AS psp_bez,
  v02.psp_id_char AS it_projekt_id,
  v01.in_projekt_id_char AS it_projekt_def
FROM kfl_production_dbp_view.v_in_projekt_2 AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element_2 AS v02
  ON v01.in_projekt_id = v02.in_projekt_id AND v01.mandant_id = v02.mandant_id
WHERE
  v01.ims_projekt_typ_id = 'P' AND v02.statistisch_fg = 1;
