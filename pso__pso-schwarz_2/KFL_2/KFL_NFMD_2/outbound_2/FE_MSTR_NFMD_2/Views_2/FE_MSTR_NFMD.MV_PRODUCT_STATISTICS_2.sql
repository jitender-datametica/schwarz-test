CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_product_statistics_2 AS WITH BASE AS (SELECT year_id,
   week_id,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   created_at,
   submitted_price,
   valid_from_date,
   latest_transfer_date
  FROM kfl_nfmd_core.ts_id40_final_submit_2), LAGGED AS (SELECT year_id,
   week_id,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   submitted_price,
   valid_from_date,
   created_at,
   LAG(submitted_price) OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), aktion_id, CAST(sku_id AS STRING)
      , CAST(wup_id AS STRING), CAST(mandant_id AS STRING) ORDER BY latest_transfer_date IS NULL, latest_transfer_date)
   AS previous_submitted_price,
   LAG(valid_from_date) OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), aktion_id, CAST(sku_id AS STRING)
      , CAST(wup_id AS STRING), CAST(mandant_id AS STRING) ORDER BY latest_transfer_date IS NULL, latest_transfer_date)
   AS previous_submitted_valid_from,
   ROW_NUMBER() OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), aktion_id, CAST(sku_id AS STRING), CAST(wup_id AS STRING)
      , CAST(mandant_id AS STRING) ORDER BY latest_transfer_date IS NULL, latest_transfer_date) AS nb_of_markdowns,
   latest_transfer_date
  FROM BASE AS b
  ORDER BY latest_transfer_date NULLS LAST), LATEST AS (SELECT year_id,
   week_id,
   aktion_id,
   sku_id,
   wup_id,
   mandant_id,
   MAX(nb_of_markdowns) AS nb_of_markdowns
  FROM LAGGED
  GROUP BY year_id,
   week_id,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id) (SELECT t25.year_id,
   t25.week_id,
   t25.mandant_id,
   t25.aktion_id,
   t25.sku_id,
   t25.wup_id,
   t25.submitted_price,
   t25.valid_from_date,
   t25.sap_transfer_date,
   t25.submitted_date,
   t25.previous_submitted_price,
   t25.previous_submitted_valid_from,
   t25.nb_of_markdowns0 AS nb_of_markdowns,
   t25.loaded
  FROM (SELECT lg.year_id,
     lg.week_id,
     lg.mandant_id,
     lg.aktion_id,
     lg.sku_id,
     lg.wup_id,
     lg.submitted_price,
     lg.valid_from_date,
     lg.latest_transfer_date AS sap_transfer_date,
     lg.created_at AS submitted_date,
      CASE
      WHEN lg.created_at >= (SELECT MAX(timestamp)
        FROM kfl_nfmd_core.sap_pipeline_writeback_2
        WHERE mandant_id = lg.mandant_id)
      THEN lg.previous_submitted_price
      ELSE lg.submitted_price
      END AS previous_submitted_price,
      CASE
      WHEN lg.created_at >= (SELECT MAX(timestamp)
        FROM kfl_nfmd_core.sap_pipeline_writeback_2
        WHERE mandant_id = lg.mandant_id)
      THEN lg.previous_submitted_valid_from
      ELSE lg.valid_from_date
      END AS previous_submitted_valid_from,
      CASE
      WHEN lg.created_at >= (SELECT MAX(timestamp)
        FROM kfl_nfmd_core.sap_pipeline_writeback_2
        WHERE mandant_id = lg.mandant_id)
      THEN lg.nb_of_markdowns - 1
      ELSE lg.nb_of_markdowns
      END AS nb_of_markdowns0,
      CASE
      WHEN lg.created_at >= (SELECT MAX(timestamp)
        FROM kfl_nfmd_core.sap_pipeline_writeback_2
        WHERE mandant_id = lg.mandant_id)
      THEN 'Loaded'
      ELSE 'Not yet Loaded'
      END AS loaded,
     lg.nb_of_markdowns
    FROM LAGGED AS lg
     INNER JOIN LATEST AS lst ON lg.year_id = lst.year_id AND lg.week_id = lst.week_id AND lg.aktion_id = lst.aktion_id
         AND lg.sku_id = lst.sku_id AND lg.wup_id = lst.wup_id AND lg.mandant_id = lst.mandant_id AND lg.nb_of_markdowns
        = lst.nb_of_markdowns
    ORDER BY lg.nb_of_markdowns DESC NULLS FIRST) AS t25);