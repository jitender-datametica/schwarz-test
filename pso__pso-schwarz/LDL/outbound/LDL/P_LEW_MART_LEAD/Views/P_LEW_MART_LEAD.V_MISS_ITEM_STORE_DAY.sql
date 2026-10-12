/* #-----------------------------------------------------------------------------
# Description:
# This view provides a non-aggregated list of missing items with a move_to_store_id/dat_formdate key.
#
# The view only returns items that were missing on days where the store was open (miss_item_cnt is not null)
# and has not been skipped (skipped_fg = 0). Skipped day are days where the number of missing items exceeds
# the maximum threshold of missing items per day. The view provides MSTR with at least 1 item record when no
# missing items have occured on a given day. This is required so that the report may count the DISTINCT
# move_to_store_id/dat_formdate keys to establish the store_day_cnt (store day count) for the metric. An
# item_sid is chosen at randon from the ítem sales table for that store on that day with a miss_item_fg
# value of 0. The results in the store/day being counted but with no missing items. This is essential to
# correctly calculate the average missing items in the report. When an item is missing, the value of
# miss_item_fg is set to 1.
#
#----------------------------------------------------------------------------
# History:
#  1.0     29.09.2022      Michael Morris             Initial Version
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_miss_item_store_day (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), dat_formdate
OPTIONS(description='Bezugsdatum'), cy_month OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'),
busyear OPTIONS(description='Geschäftsjahr'), item_id OPTIONS(description='S-Key der Artikel'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
miss_item_fg OPTIONS(description='Konstant: Immer 1'))
OPTIONS(DESCRIPTION = `STORE/DAY LIST OF MISSING ITEMS - ARTIKEL LEVEL`) AS
/* Select any item_sid for the store/day when no missing items have been identified */
/* Select all missing items for the store/day */ SELECT DISTINCT MISD.client_id,
 MISD.loc_sid_wh,
 MISD.move_to_store_id,
 MISD.wh_id,
 MISD.orig_store_nr,
 MISD.aspect_id,
 MISD.dat_formdate,
 MISD.cy_month,
 MISD.busyear,
  CASE
  WHEN MISD.miss_item_cnt > 0
  THEN s.item_sid
  ELSE i.item_sid
  END AS item_sid,
 curr.currency_iso_cd,
 curr.curr_tot_id,
  CASE
  WHEN MISD.miss_item_cnt > 0
  THEN s.miss_item_fg
  ELSE i.miss_item_fg
  END AS miss_item_fg
FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_day AS MISD
 INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS OSM ON MISD.client_id = OSM.client_id AND MISD.move_to_store_id =
        OSM.move_to_store_id AND MISD.aspect_id = OSM.aspect_id AND OSM.test_store_fg = 0 AND OSM.mis_store_active_fg =
     1 AND OSM.dashboard_relevant_fg = 1 AND MISD.dat_formdate BETWEEN OSM.dat_opening_ovis AND (COALESCE(OSM.dat_closing_ovis
     , DATE '9999-12-31'))
 INNER JOIN (SELECT client_id,
   curr_cd AS currency_iso_cd,
   curr_tot_id
  FROM (SELECT client_id,
      'EUR' AS curr_cd,
      0 AS curr_tot_id
     FROM ldl_p_lew_core_ac.v_client AS C
     UNION DISTINCT
     SELECT C.client_id,
      C.curr_cd,
      CU.curr_tot_id
     FROM ldl_p_lew_core_ac.v_client AS C
      INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CU ON C.client_id = CU.client_id AND C.curr_cd = CU.currency_iso_cd
        ) AS c) AS curr ON MISD.client_id = curr.client_id
 LEFT JOIN (SELECT DISTINCT client_id,
   loc_sid_store,
   dwh_cal_dt,
   0 AS miss_item_fg,
   ANY_VALUE(item_sid) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), dwh_cal_dt
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_sid
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day) AS i ON MISD.client_id = i.client_id AND OSM.store_id = i.loc_sid_store
      AND MISD.dat_formdate = i.dwh_cal_dt AND CASE
    WHEN MISD.miss_item_cnt > 0
    THEN 1
    ELSE 0
    END = i.miss_item_fg
 LEFT JOIN (SELECT client_id,
   loc_sid_store,
   dat_formdate AS dwh_cal_dt,
   1 AS miss_item_fg,
   item_sid
  FROM ldl_p_lew_mart_lead.t_miss_itm_store_day_asis) AS s ON MISD.client_id = s.client_id AND OSM.store_id = s.loc_sid_store
      AND MISD.dat_formdate = s.dwh_cal_dt AND CASE
    WHEN MISD.miss_item_cnt > 0
    THEN 1
    ELSE 0
    END = s.miss_item_fg
WHERE MISD.skipped_fg = 0
 AND MISD.miss_item_cnt IS NOT NULL
 AND COALESCE(i.item_sid, s.item_sid) IS NOT NULL;