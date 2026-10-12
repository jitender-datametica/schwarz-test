/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/month
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.2     01.12.2022      Michael Morris             Optimized Structures
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_store_mth (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), day_cnt
OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_month_vj
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/MONTH`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 day_cnt,
 cy_month,
 busyear,
 miss_item_cnt,
 skipped_cnt,
  CASE
  WHEN day_cnt > 0
  THEN miss_item_cnt / day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 day_cnt_vj,
 cy_month_vj,
 busyear_vj,
 miss_item_cnt_vj,
 skipped_cnt_vj,
  CASE
  WHEN day_cnt_vj > 0
  THEN miss_item_cnt_vj / day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj AS miss_item_cnt_diff,
   CASE
   WHEN day_cnt > 0
   THEN miss_item_cnt / day_cnt
   ELSE 0
   END - CASE
   WHEN day_cnt_vj > 0
   THEN miss_item_cnt_vj / day_cnt_vj
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN CASE
    WHEN day_cnt_vj > 0
    THEN miss_item_cnt_vj / day_cnt_vj
    ELSE 0
    END > 0
  THEN (CASE
       WHEN day_cnt > 0
       THEN miss_item_cnt / day_cnt
       ELSE 0
       END - CASE
       WHEN day_cnt_vj > 0
       THEN miss_item_cnt_vj / day_cnt_vj
       ELSE 0
       END) / CASE
     WHEN day_cnt_vj > 0
     THEN miss_item_cnt_vj / day_cnt_vj
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta
FROM (SELECT DISTINCT ASM.client_id,
   ASM.loc_sid_wh,
   ASM.store_id AS move_to_store_id,
   ASM.wh_id,
   ASM.orig_store_nr,
   ASM.aspect_id,
   d1.currency_iso_cd,
   d1.curr_tot_id,
   CM.cy_month,
   CM.busyear,
   SUM(d1.day_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   day_cnt,
   SUM(d1.miss_item_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   miss_item_cnt,
   SUM(d1.skipped_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   skipped_cnt,
   CM.cy_month_prev_1y AS cy_month_vj,
    CM.busyear - 1 AS busyear_vj,
   SUM(d2.day_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   day_cnt_vj,
   SUM(d2.miss_item_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   miss_item_cnt_vj,
   SUM(d2.skipped_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(CM.cy_month AS STRING)
      , CAST(ASM.aspect_id AS STRING), d1.currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   skipped_cnt_vj
  FROM ldl_p_lew_core_ac.v_cal_month AS CM
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM ON TRUE
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM1 ON ASM.client_id = ASM1.client_id AND ASM.store_id = ASM1
      .move_to_store_id AND ASM.aspect_id = ASM1.aspect_id
   INNER JOIN (SELECT DISTINCT client_id,
     loc_sid_store,
     cy_month,
     busyear,
     currency_iso_cd,
     curr_tot_id,
     COUNT(CASE
       WHEN miss_item_cnt IS NOT NULL AND skipped_fg = 0
       THEN dat_formdate
       ELSE NULL
       END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING),
        currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
     SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING)
        , currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
     SUM(CASE
       WHEN skipped_fg = 0
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING),
        currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt
    FROM ldl_p_lew_mart_lead.t_agg_miss_itm_store_day AS D) AS d1 ON ASM.client_id = d1.client_id AND ASM1.store_id = d1
      .loc_sid_store AND CM.cy_month = d1.cy_month
   INNER JOIN (SELECT DISTINCT client_id,
     loc_sid_store,
     cy_month,
     busyear,
     currency_iso_cd,
     curr_tot_id,
     COUNT(CASE
       WHEN miss_item_cnt IS NOT NULL AND skipped_fg = 0
       THEN dat_formdate
       ELSE NULL
       END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING),
        currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
     SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING)
        , currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
     SUM(CASE
       WHEN skipped_fg = 0
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(cy_month AS STRING),
        currency_iso_cd RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt
    FROM ldl_p_lew_mart_lead.t_agg_miss_itm_store_day AS D) AS d2 ON ASM.client_id = d2.client_id AND ASM1.store_id = d2
       .loc_sid_store AND CM.cy_month_prev_1y = d2.cy_month AND d1.currency_iso_cd = d2.currency_iso_cd) AS md
WHERE day_cnt + skipped_cnt > 0;