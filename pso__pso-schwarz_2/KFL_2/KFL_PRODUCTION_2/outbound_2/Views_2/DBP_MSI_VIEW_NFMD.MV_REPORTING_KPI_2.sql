CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_reporting_kpi_2 AS WITH BASE AS (SELECT V01.kjwo_ww,
   V01.aktion_id,
   V01.mandant_id,
   V01.art_id,
   V01.curve_week_nr,
   V01.wup_id,
   V01.stock_initial_cnt,
    V01.stock_initial_cnt - V01.cumulated_sales_cnt AS aktueller_bestand,
   V01.weekly_sales_cnt AS absatz,
   V01.cumulated_sales_cnt AS absatz_total,
   V01.weekly_sell_rate AS avq,
   V01.weekly_revenue_gross_local_val,
   SUM(V01.weekly_revenue_gross_local_val) OVER (PARTITION BY V01.kjwo_ww, V01.mandant_id, V01.art_id, V01.wup_id, V01.aktion_id
      , V01.wrg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS umsatz_total,
   SUM(V01.weekly_sales_cnt) OVER (PARTITION BY V01.kjwo_ww, V01.mandant_id, V01.art_id, V01.wup_id, V01.aktion_id, V01
      .wrg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_absatz_total,
   V01.selling_price_gross_local_val,
   V01.wrg_id,
   V03.comment_txt,
   v04.akt_kjwo_ww,
   V01.model_execution_tmsp AS model_date_format,
    V06.mwst / 100 AS mwst_per_2,
   V07.promo_lifecycle_weeks_cnt
  FROM kfl_production_dbp_view.v_nfmd_article_store_curves_2 AS V01
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_2 AS V02 ON V01.kjwo_ww = V02.kjwo_ww AND V01.art_id
        = V02.art_id AND V01.mandant_id = V02.mandant_id AND V02.markdown_decision_id = 0
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_comments_2 AS V03 ON V01.kjwo_ww = V03.kjwo_ww AND V01.art_id = V03
       .art_id AND V01.mandant_id = V03.mandant_id AND LENGTH(TRIM(V03.comment_txt)) > 0
   INNER JOIN (SELECT DISTINCT mandant_id,
     kjwo_ww,
     akt_kjwo_ww
    FROM kfl_production_dbp_view.v_werbewoche_kl_2) AS v04 ON V01.kjwo_ww = v04.kjwo_ww AND V01.mandant_id = v04.mandant_id
       AND v04.akt_kjwo_ww <= 0
   INNER JOIN kfl_production_dbp_view.v_art_2 AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
   INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V06 ON V05.mwst_id = V06.mwst_id AND V05.mandant_id = V06.mandant_id
       AND V06.dat_bis = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_data.nfmd_parameter_2 AS V07 ON V01.mandant_id = V07.mandant_id
  WHERE V01.stock_initial_cnt > 0), WEEK_8 AS (SELECT DISTINCT kjwo_ww,
   aktion_id,
   mandant_id,
   art_id,
   curve_week_nr,
   wup_id,
   aktueller_bestand AS bestand_8woche,
   absatz_total,
   umsatz_total,
   selling_price_gross_local_val,
   wrg_id
  FROM BASE AS v01
  WHERE curve_week_nr = promo_lifecycle_weeks_cnt
   AND absatz IS NOT NULL), WEEK_1 AS (SELECT DISTINCT kjwo_ww,
   aktion_id,
   mandant_id,
   art_id,
   curve_week_nr,
   wup_id,
   absatz AS absatz_1woche,
   weekly_revenue_gross_local_val AS umsatz_1woche,
   wrg_id
  FROM BASE AS v01
  WHERE curve_week_nr = 1), SUBMIT_TABLE_BASE AS (SELECT DISTINCT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   manual_promo_price_gross_local_val,
   manual_promo_price_dt,
   model_price_gross_local_val,
   DENSE_RANK() OVER (PARTITION BY kjwo_ww, mandant_id, aktion_id, art_id, wup_id ORDER BY manual_promo_price_dt
      NULLS LAST) AS markdown
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_2), SUBMIT_TABLE_MD AS (SELECT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   MAX(markdown) AS anzahl_markdown
  FROM SUBMIT_TABLE_BASE
  GROUP BY kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id), SUBMIT_TABLE_1MD AS (SELECT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   manual_promo_price_gross_local_val,
   manual_promo_price_dt,
   model_price_gross_local_val
  FROM SUBMIT_TABLE_BASE
  WHERE markdown = 1), SUBMIT_TABLE_2MD AS (SELECT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   manual_promo_price_gross_local_val,
   manual_promo_price_dt,
   model_price_gross_local_val
  FROM SUBMIT_TABLE_BASE
  WHERE markdown = 2) (SELECT DISTINCT t3.kjwo_ww,
   t3.mandant_id,
   t3.aktion_id,
   t3.art_id,
   t3.wup_id,
   t3.wrg_id,
   t3.akt_kjwo_ww,
   t3.model_date_format,
    CASE
    WHEN t3.akt_kjwo_ww BETWEEN -t3.promo_lifecycle_weeks_cnt AND 0
    THEN 1
    WHEN t3.akt_kjwo_ww < -t3.promo_lifecycle_weeks_cnt AND t11.absatz_total IS NULL
    THEN 2
    ELSE 3
    END AS curve_status,
   t3.comment_txt AS comment_text,
   t3.stock_initial_cnt AS initialer_bestand,
   t3.selling_price_gross_local_val AS initialer_vk_brutto,
    t3.selling_price_gross_local_val / (1 + t3.mwst_per_2) AS initialer_vk_netto,
   t3.akt_absatz_total AS absatz_total,
   t19.absatz_1woche AS absatz_w1,
   t19.umsatz_1woche AS umsatz_w1,
    t19.umsatz_1woche / (1 + t3.mwst_per_2) AS umsatz_w1_netto,
   t11.bestand_8woche AS endbestand_w8,
    t11.bestand_8woche * (t11.selling_price_gross_local_val / (1 + t3.mwst_per_2)) AS restmenge_eur,
   t3.umsatz_total AS umsatz_total_brutto,
    t3.umsatz_total / (1 + t3.mwst_per_2) AS umsatz_total_netto,
   COALESCE(t25.anzahl_markdown, 0) AS anzahl_markdown,
   t31.manual_promo_price_gross_local_val AS `1_reduzierung`,
   t37.manual_promo_price_gross_local_val AS `2_reduzierung`,
   COALESCE(t37.manual_promo_price_gross_local_val, t31.manual_promo_price_gross_local_val, t3.selling_price_gross_local_val
    ) AS aktueller_vk,
    CASE
    WHEN t25.anzahl_markdown IS NOT NULL
    THEN 1 - COALESCE(t37.manual_promo_price_gross_local_val, t31.manual_promo_price_gross_local_val, t3.selling_price_gross_local_val
       ) / t3.selling_price_gross_local_val
    ELSE 0
    END AS gegebener_rabatt,
    ROUND(t3.selling_price_gross_local_val / (1 + t3.mwst_per_2) * t3.akt_absatz_total, 2) - ROUND(t3.umsatz_total / (1 +
        t3.mwst_per_2), 2) AS preisabschrift,
    t11.bestand_8woche * ((t3.selling_price_gross_local_val - COALESCE(t37.manual_promo_price_gross_local_val, t31.manual_promo_price_gross_local_val
         , t3.selling_price_gross_local_val)) / (1 + t3.mwst_per_2)) AS totalabschrift,
     ROUND(t3.selling_price_gross_local_val / (1 + t3.mwst_per_2) * t3.akt_absatz_total, 2) - ROUND(t3.umsatz_total / (1 +
         t3.mwst_per_2), 2) + t11.bestand_8woche * (t11.selling_price_gross_local_val / (1 + t3.mwst_per_2)) AS
   abschrift_gesamt_eur,
    t3.stock_initial_cnt * (t3.selling_price_gross_local_val / (1 + t3.mwst_per_2)) AS initialer_warenwert,
   MAX(CASE
     WHEN COALESCE(t37.manual_promo_price_gross_local_val, t31.manual_promo_price_gross_local_val, t3.selling_price_gross_local_val
       ) <> t31.manual_promo_price_gross_local_val
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY t3.mandant_id, t3.kjwo_ww, t3.art_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS preis_angepasst_fg
  FROM BASE AS t3
   LEFT JOIN WEEK_8 AS t11 ON t3.kjwo_ww = t11.kjwo_ww AND t3.aktion_id = t11.aktion_id AND t3.mandant_id = t11.mandant_id
         AND t3.art_id = t11.art_id AND t3.wup_id = t11.wup_id AND t3.wrg_id = t11.wrg_id
   LEFT JOIN WEEK_1 AS t19 ON t3.kjwo_ww = t19.kjwo_ww AND t3.aktion_id = t19.aktion_id AND t3.mandant_id = t19.mandant_id
         AND t3.art_id = t19.art_id AND t3.wup_id = t19.wup_id AND t3.wrg_id = t19.wrg_id
   LEFT JOIN SUBMIT_TABLE_MD AS t25 ON t3.kjwo_ww = t25.kjwo_ww AND t3.aktion_id = t25.aktion_id AND t3.mandant_id = t25
       .mandant_id AND t3.art_id = t25.art_id AND t3.wup_id = t25.wup_id
   LEFT JOIN SUBMIT_TABLE_1MD AS t31 ON t25.kjwo_ww = t31.kjwo_ww AND t25.aktion_id = t31.aktion_id AND t25.mandant_id =
       t31.mandant_id AND t25.art_id = t31.art_id AND t25.wup_id = t31.wup_id
   LEFT JOIN SUBMIT_TABLE_2MD AS t37 ON t25.kjwo_ww = t37.kjwo_ww AND t25.aktion_id = t37.aktion_id AND t25.mandant_id =
       t37.mandant_id AND t25.art_id = t37.art_id AND t25.wup_id = t37.wup_id);