CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_projekt_bereich_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  CAST(v01.hr_objekt_ebene1_id AS BIGNUMERIC) AS it_projekt_bereich_id,
  v01.mandant_id AS mandant_id,
  MAX(v01.hr_objekt_ebene1_bez) AS it_projekt_bereich_bez,
  MAX(v03.sparte_id) AS sparte_id
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_2 AS v01
INNER JOIN (
  SELECT
    hr_objekt_ebene1_id,
    mandant_id,
    spr_id,
    MAX(kjmo) AS max_kjmo
  FROM kfl_production_dbp_view.v_org_einheit_hierarchie_2
  WHERE
    spr_id = 22
  GROUP BY
    mandant_id,
    hr_objekt_ebene1_id,
    spr_id
) AS t1_2
  ON v01.hr_objekt_ebene1_id = t1.hr_objekt_ebene1_id
  AND v01.mandant_id = t1.mandant_id
  AND v01.kjmo = t1.max_kjmo
  AND v01.spr_id = t1.spr_id
INNER JOIN kfl_production_dbp_view.v_l_org_einheit_sparte_2 AS v03
  ON v01.hr_objekt_ebene1_id = v03.hr_objekt_ebene11_id
  AND v01.mandant_id = v03.mandant_id
GROUP BY
  it_projekt_bereich_id,
  v01.mandant_id
UNION ALL
SELECT
  ROUND(CAST(it_projekt_bereich_id AS BIGNUMERIC), 0) AS it_projekt_bereich_id,
  mandant_id,
  it_projekt_bereich_bez,
  sparte_id
FROM kfl_production_dbp_view.v_l_it_projekt_bereich_2;
