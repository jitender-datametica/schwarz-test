CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_land_spr_2
(
  land_id,
  mandant_id,
  land_bez,
  land_bez_de,
  land_bez_cz,
  land_bez_pl,
  land_bez_md,
  land_bez_sk,
  land_bez_hr,
  land_bez_ro,
  land_bez_bg
)
AS
SELECT
  t0.land_id,
  v2.mandant_id,
  t0.`1` AS land_bez,
  t0.`1` AS land_bez_de,
  COALESCE(t0.`2`, t0.`1`) AS land_bez_cz,
  COALESCE(t0.`3`, t0.`1`) AS land_bez_pl,
  COALESCE(t0.`4`, t0.`1`) AS land_bez_md,
  COALESCE(t0.`5`, t0.`1`) AS land_bez_sk,
  COALESCE(t0.`6`, t0.`1`) AS land_bez_hr,
  COALESCE(t0.`7`, t0.`1`) AS land_bez_ro,
  COALESCE(t0.`8`, t0.`1`) AS land_bez_bg
FROM (
  SELECT *
  FROM (
    
    SELECT
      land_id,
      mandant_id,
      CAST(land_bez AS STRING) AS land_bez
    FROM kfl_production_dbp_view.v_land_2
  )
  PIVOT (
    MAX(land_bez)
    FOR mandant_id IN (
      1 AS `1`,
      2 AS `2`,
      3 AS `3`,
      4 AS `4`,
      5 AS `5`,
      6 AS `6`,
      7 AS `7`,
      8 AS `8`
    )
  )
) AS t0
CROSS JOIN kfl_production_dbp_view.v_mandant_2 AS v2;