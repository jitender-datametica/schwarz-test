CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_SIG_STORE_WEEK_2 COMMENT = 'Counts the missing items per store/week/article family'
(
  client_id                        COMMENT 'MIS Client ID'
, loc_sid_wh                       COMMENT 'S-Key der Gesellschaft'
, move_to_store_id                 COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id                            COMMENT 'Gesellschaft ID'
, orig_store_nr                    COMMENT 'Store ID'
, aspect_id                        COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                  COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                      COMMENT 'Interner Währungs-Code'
, item_grp_int_sid                 COMMENT 'S-Key für Internationale Warengruppe'
, sub_item_grp_sid                 COMMENT 'S-Key für Unterwarengruppe'
, item_fam_grp_sid                 COMMENT 'S-Key der Artikelfamiliengruppe'
, itemgroup_int_id                 COMMENT 'Warengruppe ID'
, subitemgroup_id                  COMMENT 'Unterwarengruppe ID'
, item_familygroup_id              COMMENT 'Artikelfamilie ID'
, cy_week                          COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                          COMMENT 'Geschäftsjahr'
, day_cnt                          COMMENT 'Anzahl der Tage in dem den Store auf hat'
, miss_item_cnt                    COMMENT 'Anzahl der Fehlartikeln für die ganze Woche_2'
, miss_item_cnt_avg_day            COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar_2 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , move_to_store_id
       , wh_id
       , orig_store_nr
       , aspect_id
       , CAST(currency_iso_cd AS VARCHAR(3)) AS currency_iso_cd
       , curr_tot_id
       , item_grp_int_sid
       , sub_item_grp_sid
       , item_fam_grp_sid
       , itemgroup_int_id
       , subitemgroup_id
       , item_familygroup_id
       , cy_week
       , busyear
       , day_cnt
       , miss_item_cnt
       , CASE WHEN day_cnt > 0 THEN (miss_item_cnt / day_cnt) ELSE 0 END AS miss_item_cnt_avg_day
  FROM (
        SELECT DISTINCT   asm.client_id
                        , asm.loc_sid_wh
                        , asm.store_id               AS move_to_store_id
                        , asm.wh_id
                        , asm.orig_store_nr
                        , asm.aspect_id
                        , curr.currency_iso_cd
                        , curr.curr_tot_id
                        , d1.item_grp_int_sid
                        , d1.sub_item_grp_sid
                        , d1.item_fam_grp_sid
                        , CAST(sigh.item_grp_int_cd    AS INTEGER)     AS itemgroup_int_id
                        , CAST(sig.src_subitemgrp_cd   AS INTEGER)     AS subitemgroup_id
                        , ifg.src_familygrp_id                         AS item_familygroup_id
                        , cal.cy_week
                        , cal.busyear
                        , COUNT(DISTINCT(CASE WHEN miss_item_cnt IS NOT NULL THEN dat_formdate ELSE NULL END))  OVER (PARTITION BY asm.client_id, asm.store_id, asm.aspect_id, d1.item_fam_grp_sid, cal.cy_week, curr.curr_tot_id) AS day_cnt
                        , SUM(d1.miss_item_cnt)                                                                 OVER (PARTITION BY asm.client_id, asm.store_id, asm.aspect_id, d1.item_fam_grp_sid, cal.cy_week, curr.curr_tot_id) AS miss_item_cnt

          FROM P_LEW_CORE_AC.v_cal_calendarday_2                  AS cal

         INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_2        AS asm
            ON cal.cal_dt               BETWEEN asm.dat_opening_ovis AND COALESCE(asm.dat_closing_ovis, DATE '9999-12-31')

         INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_2        AS asm1
            ON asm.store_id             = asm1.move_to_store_id
           AND asm.aspect_id            = asm1.aspect_id

         INNER JOIN P_LEW_MART_LEAD.t_agg_miss_sig_store_day_2    AS d1
            ON asm.client_id            = d1.client_id
           AND asm1.store_id            = d1.loc_sid_store
           AND cal.cal_dt               = d1.dat_formdate

         INNER JOIN P_LEW_BIL_AC.v_item_familygroup_2             AS ifg
            ON asm.client_id            = ifg.client_id
           AND d1.item_fam_grp_sid      = ifg.item_fam_grp_sid
           AND ifg.deleted_fg           = 0
           AND ifg.active_fg            = 1
           AND ifg.src_familygrp_id     > 0

         INNER JOIN P_LEW_BIL_AC.v_subitemgroup_2                AS sig
            ON asm.client_id        = sig.client_id
           AND d1.sub_item_grp_sid  = sig.sub_item_grp_sid

         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_2           AS sigh
            ON asm.client_id        = sigh.client_id
           AND d1.sub_item_grp_sid  = sigh.sub_item_grp_sid
           AND CURRENT_DATE BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to

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
            ON asm.client_id = curr.client_id
        ) AS md
;