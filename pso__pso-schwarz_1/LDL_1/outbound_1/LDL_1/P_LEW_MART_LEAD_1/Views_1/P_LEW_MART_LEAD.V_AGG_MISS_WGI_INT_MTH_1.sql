/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_1/product group/month.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     22.08.2022      Michael Morris             Comparison to previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_int_mth_1 (client_id OPTIONS(description='MIS Client ID'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), cy_month
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1'), cy_month_vj
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM" - Vorjahr'), busyear_vj
OPTIONS(description='Geschäftsjahr - Vorjahr'), day_cnt_vj
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filialetage aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1 - aus dem Vorjahr'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1 - aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel (im Monat_1) aus aktuellem Jahr minus Anzahl der Fehlartikel (im Monat_1) aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_1/WARENGRUPPE/MONAT_1`) AS SELECT client_id,
 item_grp_int_sid,
 itemgroup_int_id,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 cy_month,
 busyear,
 day_cnt,
 store_day_cnt,
 skipped_cnt,
 miss_item_cnt,
  CASE
  WHEN store_day_cnt > 0
  THEN miss_item_cnt / store_day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 cy_month_vj,
 busyear_vj,
 day_cnt_vj,
 store_day_cnt_vj,
 skipped_cnt_vj,
 miss_item_cnt_vj,
  CASE
  WHEN store_day_cnt_vj > 0
  THEN miss_item_cnt_vj / store_day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj AS miss_item_cnt_diff,
   CASE
   WHEN store_day_cnt > 0
   THEN miss_item_cnt / store_day_cnt
   ELSE 0
   END - CASE
   WHEN store_day_cnt_vj > 0
   THEN miss_item_cnt_vj / store_day_cnt_vj
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN CASE
    WHEN store_day_cnt_vj > 0
    THEN miss_item_cnt_vj / store_day_cnt_vj
    ELSE 0
    END > 0
  THEN (CASE
       WHEN store_day_cnt > 0
       THEN miss_item_cnt / store_day_cnt
       ELSE 0
       END - CASE
       WHEN store_day_cnt_vj > 0
       THEN miss_item_cnt_vj / store_day_cnt_vj
       ELSE 0
       END) / CASE
     WHEN store_day_cnt_vj > 0
     THEN miss_item_cnt_vj / store_day_cnt_vj
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta
FROM (SELECT DISTINCT client_id,
   item_grp_int_sid,
   itemgroup_int_id,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   cy_month,
   busyear,
   MAX(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS day_cnt,
   SUM(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS store_day_cnt,
   SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS miss_item_cnt,
   SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS skipped_cnt,
   cy_month_vj,
   busyear_vj,
   MAX(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS day_cnt_vj,
   SUM(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS store_day_cnt_vj,
   SUM(miss_item_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS miss_item_cnt_vj,
   SUM(skipped_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS skipped_cnt_vj
  FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_mth_1) AS ww;