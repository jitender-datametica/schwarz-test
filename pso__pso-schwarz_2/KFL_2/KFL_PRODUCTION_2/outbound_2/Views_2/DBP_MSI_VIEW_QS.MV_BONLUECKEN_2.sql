CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_bonluecken_2 AS SELECT mandant_id,
 wup_id,
 dat_booking,
 bon_dat,
 kasse_nr,
 COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), bon_dat, CAST(kasse_nr AS STRING)
     ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) AS previous_bon_nr,
 bon_nr,
 bon_beginn,
 bon_ende,
 datei_name,
 COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), bon_dat, CAST(kasse_nr AS STRING)
     ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), 0) AS next_bon_nr,
   COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), bon_dat, CAST(kasse_nr AS STRING)
       ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) - bon_nr + 1 AS anz_fehlende_bons,
  CASE
  WHEN COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), bon_dat, CAST(kasse_nr AS STRING)
         ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) - bon_nr + 1 = - 1
  THEN TRIM(SUBSTR(CAST(COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING),
          bon_dat, CAST(kasse_nr AS STRING) ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0
       ) + 1 AS STRING), 1, 39))
  ELSE TRIM(SUBSTR(CAST(COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING),
            bon_dat, CAST(kasse_nr AS STRING) ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
         , 0) + 1 AS STRING), 1, 39)) || ' - ' || TRIM(SUBSTR(CAST(bon_nr - 1 AS STRING), 1, 39))
  END AS fehlende_bon_nr
FROM kfl_production_dbp_v_ods.v_ods_bon_transaction_2 AS T
WHERE mandant_id = 1
QUALIFY COALESCE(MIN(bon_nr) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), bon_dat, CAST(kasse_nr AS STRING)
       ORDER BY bon_nr IS NULL, bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) - bon_nr NOT IN (- 1, 0);