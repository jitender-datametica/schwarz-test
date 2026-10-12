CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_bereich_spr_zu (
  ber_id BIGNUMERIC(38, 0),
  ber_bez STRING(50),
  ber_bez_de STRING(50),
  ber_bez_cz STRING(50),
  ber_bez_sk STRING(50),
  ber_bez_hr STRING(50),
  ber_bez_pl STRING(50),
  ber_bez_ro STRING(50),
  ber_bez_bg STRING(50),
  mandant_id BIGNUMERIC(38, 0),
  arthiertyp_id BIGNUMERIC(38, 0)
) AS
SELECT
  v01.wg_hierarchie_id AS ber_id,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A') AS ber_bez,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A') AS ber_bez_de,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 124 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_cz,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 108 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_sk,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 65 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_hr,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 90 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_pl,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 95 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_ro,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 18 THEN v02.wg_hierarchie_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.wg_hierarchie_bez ELSE NULL END), 'N/A')
  ) AS ber_bez_bg,
  v01.mandant_id AS mandant_id,
  v01.arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS v01
INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.wg_hierarchie_ebene_id = v02.wg_hierarchie_ebene_id
  AND v01.wg_hierarchie_id = v02.wg_hierarchie_id
  AND v01.arthiertyp_id = v02.arthiertyp_id
WHERE
  v01.arthiertyp_id = 10
  AND v01.wg_hierarchie_ebene_id = 1
  AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
GROUP BY
  ber_id,
  v01.mandant_id,
  v01.arthiertyp_id;
