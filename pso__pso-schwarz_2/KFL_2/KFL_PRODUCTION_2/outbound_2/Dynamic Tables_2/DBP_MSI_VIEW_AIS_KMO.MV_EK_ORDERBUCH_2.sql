CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_ek_orderbuch_2 (
  art_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  gp_id BIGNUMERIC(38, 0),
  orderbuch_gueltig STRING(16777216)
) AS
SELECT DISTINCT
  art_id AS art_id,
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  gp_id AS gp_id,
  'gültiger Orderbucheintrag' AS orderbuch_gueltig
FROM kfl_production_dbp_view.v_ek_orderbuch_2 AS v01
WHERE
  mandant_id <> 1
  AND gesperrt_fg = 0
  AND DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY) BETWEEN dat_von AND dat_bis
UNION ALL
SELECT DISTINCT
  art_id,
  mandant_id,
  wup_id,
  nb_id,
  gp_id,
  'ungültiger Orderbucheintrag' AS orderbuch_gueltig
FROM kfl_production_dbp_view.v_ek_orderbuch_2 AS v02
WHERE
  mandant_id <> 1
  AND NOT (art_id, mandant_id, wup_id, nb_id, gp_id) IN (
    SELECT
      (art_id, mandant_id, wup_id, nb_id, gp_id)
    FROM (
      SELECT DISTINCT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        gp_id
      FROM kfl_production_dbp_view.v_ek_orderbuch_2
      WHERE
        mandant_id <> 1
        AND gesperrt_fg = 0
        AND DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY) BETWEEN dat_von AND dat_bis
    ) AS t4
  );
