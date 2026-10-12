CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MISS_ITEM_STORE_DAY_2 COMMENT = 'Store/Day list of missing items - Artikel_2 level'
(
  client_id        COMMENT 'MIS Client ID'
, loc_sid_wh       COMMENT 'S-Key der Gesellschaft'
, move_to_store_id COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id            COMMENT 'Gesellschaft ID'
, orig_store_nr    COMMENT 'Store ID'
, aspect_id        COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, dat_formdate     COMMENT 'Bezugsdatum'
, cy_month         COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear          COMMENT 'Geschäftsjahr'
, item_id          COMMENT 'S-Key der Artikel_2'
, currency_iso_cd  COMMENT '3 stelliger Währungs-Code'
, curr_tot_id      COMMENT 'Interner Währungs-Code'
, miss_item_fg     COMMENT 'Konstant: Immer 1'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a non-aggregated list of missing items with a move_to_store_id/dat_formdate key.
#
# The view only returns items that were missing on days where the store was open (miss_item_cnt is not null)
# and has not been skipped (skipped_fg = 0). Skipped day are days where the number of missing items exceeds
# the maximum threshold of missing items per day. The view provides MSTR with at least 1 item_2 record when no
# missing items have occured on a given day. This is required so that the report may count the DISTINCT
# move_to_store_id/dat_formdate keys to establish the store_day_cnt (store day count) for the metric. An
# item_sid is chosen at randon from the ítem sales_2 table for that store on that day with a miss_item_fg
# value of 0. The results in the store/day being counted but with no missing items. This is essential to
# correctly calculate the average missing items in the report. When an item_2 is missing, the value of
# miss_item_fg is set to 1.
#
#----------------------------------------------------------------------------
# History:
#  1.0     29.09.2022      Michael Morris             Initial Version
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT DISTINCT misd.client_id
       , misd.loc_sid_wh
       , misd.move_to_store_id
       , misd.wh_id
       , misd.orig_store_nr
       , misd.aspect_id
       , misd.dat_formdate
       , misd.cy_month
       , misd.busyear
       , CASE WHEN misd.miss_item_cnt > 0 THEN s.item_sid     ELSE i.item_sid     END AS item_sid
       , curr.currency_iso_cd
       , curr.curr_tot_id
       , CASE WHEN misd.miss_item_cnt > 0 THEN s.miss_item_fg ELSE i.miss_item_fg END AS miss_item_fg

  FROM P_LEW_MART_LEAD.v_agg_miss_item_store_day_2           AS misd

 INNER JOIN P_LEW_MART_MSI_AC.v_org_store_merge_2            AS osm
    ON misd.client_id            = osm.client_id
   AND misd.move_to_store_id     = osm.move_to_store_id
   AND misd.aspect_id            = osm.aspect_id
   AND osm.test_store_fg         = 0
   AND osm.mis_store_active_fg   = 1
   AND osm.dashboard_relevant_fg = 1
   AND misd.dat_formdate         BETWEEN osm.dat_opening_ovis AND COALESCE(osm.dat_closing_ovis, DATE '9999-12-31')

 INNER JOIN (
            SELECT   c.client_id
                   , c.curr_cd       AS currency_iso_cd
                   , c.curr_tot_id
              FROM (
                    SELECT   c.client_id
                           , 'EUR'       AS curr_cd
                           , 0           AS curr_tot_id
                      FROM p_lew_core_ac.v_client_2 AS c
                     UNION
                    SELECT   c.client_id
                           , c.curr_cd
                           , cu.curr_tot_id
                      FROM p_lew_core_ac.v_client_2 AS c
                     INNER JOIN p_lew_mart_msi_ac.v_ref_currency_2 AS cu
                        ON c.client_id = cu.client_id
                       AND c.curr_cd   = cu.currency_iso_cd
                   ) AS c
            )                   AS curr
   ON misd.client_id = curr.client_id

 LEFT OUTER JOIN (           /* Select any item_sid for the store/day when no missing items have been identified */
             SELECT DISTINCT client_id
                   , loc_sid_store
                   , dwh_cal_dt
                   , 0                 AS miss_item_fg
                   , ANY_VALUE(item_sid) OVER (PARTITION BY client_id, loc_sid_store, dwh_cal_dt) AS item_sid
              FROM P_LEW_BIL_AC.V_AGG_POS_STORE_ITEM_DAY_2
            )                   AS i

    ON misd.client_id        = i.client_id
   AND  osm.store_id         = i.loc_sid_store
   AND misd.dat_formdate     = i.dwh_cal_dt
   AND CASE WHEN misd.miss_item_cnt > 0 THEN 1 ELSE 0 END   = i.miss_item_fg

 LEFT OUTER JOIN (         /* Select all missing items for the store/day */
            SELECT   client_id
                   , loc_sid_store
                   , dat_formdate      AS dwh_cal_dt
                   , 1                 AS miss_item_fg
                   , item_sid
              FROM P_LEW_MART_LEAD.t_miss_itm_store_day_asis_2
            )                                               AS s
     ON misd.client_id        = s.client_id
   AND  osm.store_id         = s.loc_sid_store
   AND misd.dat_formdate     = s.dwh_cal_dt
   AND CASE WHEN misd.miss_item_cnt > 0 THEN 1 ELSE 0 END   = s.miss_item_fg

 WHERE misd.skipped_fg                   = 0
   AND misd.miss_item_cnt               IS NOT NULL
   AND COALESCE(i.item_sid, s.item_sid) IS NOT NULL
;