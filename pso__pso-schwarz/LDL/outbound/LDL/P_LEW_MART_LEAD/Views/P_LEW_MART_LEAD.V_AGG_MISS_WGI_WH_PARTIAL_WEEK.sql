/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/product group/partial week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     22.08.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_partial_week (client_id
OPTIONS(description='MIS Client ID'), loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), wh_id
OPTIONS(description='Gesellschaft ID'), item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'),
itemgroup_int_id OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
cy_week_partial_week_id OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die Teilwoche'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage der Woche aus dem Vorjahr'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filialetage aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag aus dem Vorjahr'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO GESELLSCHAFT/WARENGRUPPE/TEILWOCHE`) AS SELECT client_id,
 loc_sid_wh,
 wh_id,
 item_grp_int_sid,
 itemgroup_int_id,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 cy_week_partial_week_id,
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
   loc_sid_wh,
   wh_id,
   item_grp_int_sid,
   itemgroup_int_id,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   cy_week_partial_week_id,
   cy_month,
   busyear,
   SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS skipped_cnt,
   MAX(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS store_day_cnt,
   SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(skipped_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS skipped_cnt_vj,
   MAX(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS day_cnt_vj,
   SUM(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS store_day_cnt_vj,
   SUM(miss_item_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS miss_item_cnt_vj
  FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_partial_week) AS ww;