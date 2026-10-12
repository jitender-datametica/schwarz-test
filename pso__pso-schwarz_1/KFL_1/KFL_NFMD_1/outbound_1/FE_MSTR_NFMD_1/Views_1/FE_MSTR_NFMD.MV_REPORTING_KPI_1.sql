CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_reporting_kpi_1 AS WITH BASE AS (SELECT V01.promo_week,
   V01.aktion_id,
   V01.mandant_id,
   V01.art_id,
   V01.curve_week,
   V01.wup_id,
   V01.wg_bez,
   V01.wup_region,
   V01.stock_initial,
    V01.stock_initial - V01.cumulated_sales AS aktueller_bestand,
   V01.sales_1 AS absatz,
   V01.cumulated_sales AS absatz_total,
   V01.sell_ratio AS avq,
   V01.revenue,
   SUM(V01.revenue) OVER (PARTITION BY CAST(V01.promo_week AS STRING), CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING)
      , CAST(V01.wup_id AS STRING), V01.aktion_id, V01.currency RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS umsatz_total,
   SUM(V01.sales_1) OVER (PARTITION BY CAST(V01.promo_week AS STRING), CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING)
      , CAST(V01.wup_id AS STRING), V01.aktion_id, V01.currency RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS akt_absatz_total,
   V01.vk_aktion_brutto,
   V01.currency,
   V03.jf_comment,
   V04.akt_wo,
   DATE(SUBSTR(V01.model_date, 1, 8)) AS model_date_format
  FROM kfl_nfmd_core.src_hdp_md_curves_master_reporting_1 AS V01
   INNER JOIN kfl_nfmd_core.ts_id30_msi_final_submit_1 AS V02 ON V01.aktion_id = V02.aktion_id AND CAST(V01.calendar_week AS FLOAT64)
         = V02.week_id AND CAST(V01.calendar_year AS FLOAT64) = V02.year_id AND V01.art_id = V02.sku_id AND V01.mandant_id
       = V02.mandant_id AND CAST(V02.markdown_decision AS FLOAT64) = 0
   LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id30_latest_comm_wb_1 AS V03 ON V01.aktion_id = V03.aktion_id AND CAST(V01.calendar_year AS FLOAT64)
         = V03.year_id AND CAST(V01.calendar_week AS FLOAT64) = V03.week_id AND V01.art_id = V03.sku_id AND V01.mandant_id
       = V03.mandant_id AND LENGTH(TRIM(V03.jf_comment)) > 0
   INNER JOIN kfl_nfmd_fe_mstr_nfmd.mv_lookup_dates_1 AS V04 ON CAST(V04.kjwo AS FLOAT64) = V01.promo_week AND V04.akt_wo
     <= 0
  WHERE V01.stock_initial > 0), WEEK_8 AS (SELECT DISTINCT promo_week,
   aktion_id,
   mandant_id,
   art_id,
   curve_week,
   wup_id,
   aktueller_bestand AS bestand_8woche,
   absatz_total,
   umsatz_total,
   vk_aktion_brutto,
   currency
  FROM BASE AS v01
  WHERE curve_week = 8
   AND absatz IS NOT NULL), WEEK_1 AS (SELECT DISTINCT promo_week,
   aktion_id,
   mandant_id,
   art_id,
   curve_week,
   wup_id,
   absatz AS absatz_1woche,
   revenue AS umsatz_1woche,
   currency
  FROM BASE AS v01
  WHERE curve_week = 1), SUBMIT_TABLE_BASE AS (SELECT DISTINCT CAST(year_id AS STRING) || TRIM(CAST(CAST(week_id AS BIGNUMERIC)
      AS STRING FORMAT '00')) AS promo_week,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   submitted_price,
   valid_from_date,
   DENSE_RANK() OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), CAST(mandant_id AS STRING),
      aktion_id, CAST(sku_id AS STRING), CAST(wup_id AS STRING) ORDER BY valid_from_date IS NULL, valid_from_date) AS
   markdown
  FROM kfl_nfmd_core.ts_id40_final_submit_1), SUBMIT_TABLE_MD AS (SELECT promo_week,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   MAX(markdown) AS anzahl_markdown
  FROM SUBMIT_TABLE_BASE
  GROUP BY promo_week,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id), SUBMIT_TABLE_1MD AS (SELECT promo_week,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   submitted_price,
   valid_from_date
  FROM SUBMIT_TABLE_BASE
  WHERE markdown = 1), SUBMIT_TABLE_2MD AS (SELECT promo_week,
   mandant_id,
   aktion_id,
   sku_id,
   wup_id,
   submitted_price,
   valid_from_date
  FROM SUBMIT_TABLE_BASE
  WHERE markdown = 2) (SELECT DISTINCT t1.promo_week,
   t1.mandant_id,
   t1.aktion_id,
   t1.art_id,
   TD_ART.kl_art_id,
   t1.wup_id,
   t1.wg_bez,
   t1.wup_region,
   t1.currency,
   t1.akt_wo,
   t1.model_date_format,
    CASE
    WHEN t1.akt_wo BETWEEN - 8 AND 0
    THEN 'laufend'
    WHEN t1.akt_wo < - 8 AND t7.absatz_total IS NULL
    THEN 'abgebrochen'
    ELSE 'abgeschlossen'
    END AS curve_status,
   t1.jf_comment,
   t1.stock_initial AS initialer_bestand,
   t1.vk_aktion_brutto AS initialer_vk_brutto,
    t1.vk_aktion_brutto / 1.19 AS initialer_vk_netto,
   t1.akt_absatz_total AS absatz_total,
   t13.absatz_1woche AS absatz_w1,
   t13.umsatz_1woche AS umsatz_w1,
    t13.umsatz_1woche / 1.19 AS umsatz_w1_netto,
   t7.bestand_8woche AS endbestand_w8,
    t7.bestand_8woche * (t7.vk_aktion_brutto / 1.19) AS restmenge_eur,
   t1.umsatz_total AS umsatz_total_brutto,
    t1.umsatz_total / 1.19 AS umsatz_total_netto,
   COALESCE(t19.anzahl_markdown, 0) AS anzahl_markdown,
   t25.submitted_price AS `1_reduzierung`,
   t31.submitted_price AS `2_reduzierung`,
   COALESCE(t31.submitted_price, t25.submitted_price, t1.vk_aktion_brutto) AS aktueller_vk,
    CASE
    WHEN t19.anzahl_markdown IS NOT NULL
    THEN 1 - COALESCE(t31.submitted_price, t25.submitted_price, t1.vk_aktion_brutto) / t1.vk_aktion_brutto
    ELSE 0
    END AS gegebener_rabatt,
    ROUND(t1.vk_aktion_brutto / 1.19 * t1.akt_absatz_total, 2) - ROUND(t1.umsatz_total / 1.19, 2) AS preisabschrift,
    t7.bestand_8woche * ((t1.vk_aktion_brutto - COALESCE(t31.submitted_price, t25.submitted_price, t1.vk_aktion_brutto)
       ) / 1.19) AS totalabschrift,
     ROUND(t1.vk_aktion_brutto / 1.19 * t1.akt_absatz_total, 2) - ROUND(t1.umsatz_total / 1.19, 2) + t7.bestand_8woche *
      (t7.vk_aktion_brutto / 1.19) AS abschrift_gesamt_eur,
    t1.stock_initial * (t1.vk_aktion_brutto / 1.19) AS initialer_warenwert
  FROM BASE AS t1_1
   INNER JOIN kfl_nfmd_core.src_teradata_master_data_art_1 AS TD_ART ON t1.art_id = TD_ART.art_id AND t1.mandant_id =
     TD_ART.mandant_id
   LEFT JOIN WEEK_8 AS t7 ON t1.promo_week = t7.promo_week AND t1.aktion_id = t7.aktion_id AND t1.mandant_id = t7.mandant_id
         AND t1.art_id = t7.art_id AND t1.wup_id = t7.wup_id AND t1.currency = t7.currency
   LEFT JOIN WEEK_1 AS t13 ON t1.promo_week = t13.promo_week AND t1.aktion_id = t13.aktion_id AND t1.mandant_id = t13.mandant_id
         AND t1.art_id = t13.art_id AND t1.wup_id = t13.wup_id AND t1.currency = t13.currency
   LEFT JOIN SUBMIT_TABLE_MD AS t19 ON t1.promo_week = CAST(t19.promo_week AS FLOAT64) AND t1.aktion_id = t19.aktion_id
      AND t1.mandant_id = t19.mandant_id AND t1.art_id = t19.sku_id AND t1.wup_id = t19.wup_id
   LEFT JOIN SUBMIT_TABLE_1MD AS t25 ON t19.promo_week = t25.promo_week AND t19.aktion_id = t25.aktion_id AND t19.mandant_id
        = t25.mandant_id AND t19.sku_id = t25.sku_id AND t19.wup_id = t25.wup_id
   LEFT JOIN SUBMIT_TABLE_2MD AS t31 ON t19.promo_week = t31.promo_week AND t19.aktion_id = t31.aktion_id AND t19.mandant_id
        = t31.mandant_id AND t19.sku_id = t31.sku_id AND t19.wup_id = t31.wup_id);