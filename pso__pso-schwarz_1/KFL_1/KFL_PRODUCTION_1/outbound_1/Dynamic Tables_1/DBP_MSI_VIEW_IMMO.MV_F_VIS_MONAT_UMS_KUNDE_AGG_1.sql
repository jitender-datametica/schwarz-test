CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_f_vis_monat_ums_kunde_agg_1 (
  mandant_id BIGNUMERIC(38, 0),
  wrg_id STRING(3),
  wrg_typ_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  we_intreno STRING(20),
  f_anz_kunde_anz INT64,
  kjmo BIGNUMERIC(38, 0),
  f_anz_kunde_agg BIGNUMERIC(38, 0),
  f_ums_netto_agg BIGNUMERIC(38, 2),
  avg_ums_netto BIGNUMERIC(38, 0),
  avg_anz_kunde BIGNUMERIC(38, 0)
) AS
SELECT
  mandant_id AS mandant_id,
  wrg_id AS wrg_id,
  wrg_typ_id AS wrg_typ_id,
  wup_id AS wup_id,
  we_intreno AS we_intreno,
  SUM(CASE WHEN f_anz_kunde > 0 THEN 1 ELSE 0 END) AS f_anz_kunde_anz,
  MAX(kjmo) AS kjmo,
  SUM(f_anz_kunde) AS f_anz_kunde_agg,
  SUM(f_ums_netto) AS f_ums_netto_agg,
  CASE
    WHEN SUM(CASE WHEN f_anz_kunde > 0 THEN 1 ELSE 0 END) <> 0
    THEN ROUND(
      CAST(TRUNC(
        CAST(SUM(f_ums_netto) / SUM(CASE WHEN f_anz_kunde > 0 THEN 1 ELSE 0 END) AS BIGNUMERIC)
      ) AS NUMERIC),
      2
    )
    ELSE 0
  END AS avg_ums_netto,
  CASE
    WHEN SUM(CASE WHEN f_anz_kunde > 0 THEN 1 ELSE 0 END) <> 0
    THEN ROUND(
      CAST(TRUNC(
        CAST(SUM(f_anz_kunde) / SUM(CASE WHEN f_anz_kunde > 0 THEN 1 ELSE 0 END) AS BIGNUMERIC)
      ) AS NUMERIC),
      2
    )
    ELSE 0
  END AS avg_anz_kunde
FROM kfl_production_dbp_msi_view_immo.mv_f_vis_monat_ums_kunde_1 AS v1
WHERE
  akt_buchungs_schluss <= 0 AND akt_buchungs_schluss >= -11
GROUP BY
  mandant_id,
  wrg_id,
  wrg_typ_id,
  wup_id,
  we_intreno;
