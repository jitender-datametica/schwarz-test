/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_int_week_2 (client_id OPTIONS(description='MIS Client ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), cy_week OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'),
busyear OPTIONS(description='Geschäftsjahr'), day_cnt OPTIONS(description='Anzahl der öffenen Tage des Monats'),
store_day_cnt OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikel über allen Filialen der Gesellschaft'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Durchschnittliche Fehlartikeltageswert pro Filiale'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_2/WGI/WOCHE_2`) AS SELECT client_id,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 item_grp_int_sid,
 itemgroup_int_id,
 cy_week,
 busyear,
 day_cnt,
 store_day_cnt,
 miss_item_cnt,
 skipped_cnt,
  CASE
  WHEN store_day_cnt > 0
  THEN miss_item_cnt / store_day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day
FROM (SELECT DISTINCT client_id,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   item_grp_int_sid,
   itemgroup_int_id,
   cy_week,
   busyear,
   SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   SUM(CASE
     WHEN miss_item_cnt IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(store_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt,
   SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt
  FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_int_day_2) AS whd;