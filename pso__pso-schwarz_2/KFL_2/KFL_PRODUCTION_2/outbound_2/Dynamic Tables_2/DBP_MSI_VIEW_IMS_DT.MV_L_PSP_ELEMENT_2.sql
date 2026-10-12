CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_psp_element_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v02.mandant_id AS mandant_id,
  v02.psp_id AS psp_id,
  v02.psp_id_char AS psp_id_char,
  v02.psp_bez AS psp_bez,
  v02.in_projekt_id AS in_projekt_id,
  v01.in_projekt_id_char AS in_projekt_id_char,
  v01.ims_projekt_typ_id AS projekt_typ_id,
  CASE
    WHEN v01.ims_projekt_typ_id = 'A'
    THEN '17'
    WHEN v01.ims_projekt_typ_id = 'I' AND v02.psp_id > 0
    THEN '16'
    WHEN v01.ims_projekt_typ_id = 'I' AND v02.psp_id < 0
    THEN '15'
    ELSE COALESCE(v01.in_massnahme_typ_id, '-1')
  END AS in_massnahme_typ_id,
  COALESCE(v02.buchungskreis_id, -1) AS buchungskreis_id,
  COALESCE(v02.dat_erfasst, PARSE_DATE('%F', '1900-01-01')) AS dat_erfasst,
  COALESCE(v02.plan_aktivierungs_quote, 1) AS plan_aktivierungs_quote,
  COALESCE(v02.gewerk_id, -1) AS gewerk_id
FROM kfl_production_dbp_view.v_in_projekt_2 AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element_2 AS v02
  ON v01.in_projekt_id = v02.in_projekt_id AND v01.mandant_id = v02.mandant_id
WHERE
  v02.krk_id <> 'DE02' OR v02.mandant_id <> 1;
