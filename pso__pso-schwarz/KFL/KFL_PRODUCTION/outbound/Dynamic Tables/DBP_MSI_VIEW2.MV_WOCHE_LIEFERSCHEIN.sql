CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_woche_lieferschein
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  tab.kjwo AS kjwo,
  v010.wup_id AS wup_id,
  v010.nb_id AS nb_id,
  v010.mandant_id AS mandant_id,
  tab.kw || TRIM(SUBSTR(CAST(tab.dateinum AS STRING), 1, 19)) || tab.yy AS dateinum,
  tab.kw || TRIM(
    SUBSTR(
      CAST(MAX(tab.dateinum) OVER (
        PARTITION BY CAST(tab.kjwo AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS STRING),
      1,
      19
    )
  ) || tab.yy AS dateinum_max,
  'KW ' || SUBSTR(SUBSTR(CAST(CAST(tab.kjwo AS BIGNUMERIC) AS STRING), 1, 39), 10, 2) || '/' || SUBSTR(SUBSTR(CAST(CAST(tab.kjwo AS BIGNUMERIC) AS STRING), 1, 39), 6, 4) || '; ' || 'Referenz =' || ' ' || tab.kw || TRIM(SUBSTR(CAST(tab.dateinum AS STRING), 1, 19)) || tab.yy || 'XXXX' AS referenznummer_bez,
  tab.kw || TRIM(SUBSTR(CAST(tab.dateinum AS STRING), 1, 19)) || tab.yy || TRIM(SUBSTR(CAST(v010.wup_id AS STRING), 1, 39)) AS lieferschein_nr,
  tab.schicken_dat AS schicken_dat,
  tab.gultig_von AS gultig_von,
  tab.gultig_bis AS gultig_bis,
  tab.burda_beleg_dat AS burda_beleg_dat
FROM (
  SELECT
    kjwo,
    akt_mo,
    SUBSTR(SUBSTR(CAST(kjwo AS STRING), 1, 6), 5, 2) AS kw,
    SUBSTR(SUBSTR(CAST(kjwo AS STRING), 1, 6), 3, 2) AS yy,
    ROW_NUMBER() OVER (PARTITION BY CAST(kjwo AS STRING) ORDER BY akt_mo IS NULL, akt_mo) AS dateinum,
    MIN(MIN(dat)) OVER (
      PARTITION BY CAST(kjwo AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS burda_beleg_dat,
    CASE
      WHEN EXTRACT(MONTH FROM MAX(dat)) <> EXTRACT(MONTH FROM DATE_ADD(MAX(dat), INTERVAL '1' DAY))
      AND COUNT(*) <> 7
      THEN DATE_ADD(MAX(dat), INTERVAL '2' DAY)
      ELSE DATE_ADD(MAX(dat), INTERVAL '1' DAY)
    END AS schicken_dat,
    MIN(dat) AS gultig_von,
    MAX(dat) AS gultig_bis
  FROM kfl_production_dbp_view.v_tag AS v01
  GROUP BY
    kjwo,
    akt_mo
) AS tab
INNER JOIN kfl_production_dbp_view.v_wup AS v010
  ON TRUE
WHERE
  v010.mandant_id = 1;
