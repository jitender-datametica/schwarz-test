CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_SIG_STORE_MTH_1 COMMENT = 'Counts the missing items per store/month/article family'
(
  client_id                      COMMENT 'MIS Client ID'
, loc_sid_wh                     COMMENT 'S-Key der Gesellschaft'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                          COMMENT 'Gesellschaft ID'
, orig_store_nr                  COMMENT 'Store ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                    COMMENT 'Interner Währungs-Code'
, item_grp_int_sid               COMMENT 'S-Key für Internationale Warengruppe'
, sub_item_grp_sid               COMMENT 'S-Key für Unterwarengruppe'
, item_fam_grp_sid               COMMENT 'S-Key der Artikelfamiliengruppe'
, itemgroup_int_id               COMMENT 'Warengruppe ID'
, subitemgroup_id                COMMENT 'Unterwarengruppe ID'
, item_familygroup_id            COMMENT 'Artikelfamilie ID'
, cy_month                       COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, day_cnt                        COMMENT 'Anzahl der öffenen Tage des Monats'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikel'
, miss_item_cnt_avg_day          COMMENT 'Durchschnittliche Fehlartikeltageswert'
, cy_month_vj                    COMMENT 'Monat_1 des Vorgeschäftsjahres im Format "JJJJMM"'
, busyear_vj                     COMMENT 'Geschäftsjahr des Vorjahres'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/article family group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     01.12.2022      Michael Morris             Optimized Structures
#
#----------------------------------------------------------------------------
*/
SELECT   d.client_id
       , d.loc_sid_wh
       , d.move_to_store_id
       , d.wh_id
       , d.orig_store_nr
       , d.aspect_id
       , d.currency_iso_cd
       , d.curr_tot_id
       , d.item_grp_int_sid
       , d.sub_item_grp_sid
       , d.item_fam_grp_sid
       , d.itemgroup_int_id
       , d.subitemgroup_id
       , d.item_familygroup_id
       , d.cy_month
       , d.busyear
       , day_cnt
       , skipped_cnt
       , miss_item_cnt
       , CASE WHEN d.day_cnt > 0 THEN (d.miss_item_cnt / d.day_cnt) ELSE 0 END                                             AS miss_item_cnt_avg_day
       , d.cy_month_vj
       , d.busyear_vj
       , d.day_cnt_vj
       , d.skipped_cnt_vj
       , d.miss_item_cnt_vj
       , CASE WHEN d.day_cnt_vj > 0 THEN (d.miss_item_cnt_vj / d.day_cnt_vj) ELSE 0 END                                    AS miss_item_cnt_avg_day_vj
       , (d.miss_item_cnt - d.miss_item_cnt_vj)                                                                            AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                                                                AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100 ) ELSE 0 END AS miss_item_avg_day_diff_delta
  FROM (
          SELECT DISTINCT asm.client_id
                 , asm.loc_sid_wh
                 , asm.store_id                                                                AS move_to_store_id
                 , asm.wh_id
                 , asm.orig_store_nr
                 , maj.item_grp_int_sid
                 , maj.sub_item_grp_sid
                 , maj.item_fam_grp_sid
                 , maj.itemgroup_int_id
                 , maj.subitemgroup_id
                 , maj.item_familygroup_id
                 , asm.aspect_id
                 , maj.currency_iso_cd
                 , maj.curr_tot_id
                 , cm.cy_month
                 , cm.busyear
                 , SUM(maj.day_cnt)       OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS day_cnt
                 , SUM(maj.skipped_cnt)   OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS skipped_cnt
                 , SUM(maj.miss_item_cnt) OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS miss_item_cnt
                 , cm.cy_month_prev_1y                                                                                                                              AS cy_month_vj
                 , cm.busyear - 1                                                                                                                                   AS busyear_vj
                 , SUM(mvj.day_cnt)       OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS day_cnt_vj
                 , SUM(mvj.skipped_cnt)   OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS skipped_cnt_vj
                 , SUM(mvj.miss_item_cnt) OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, maj.item_familygroup_id, maj.currency_iso_cd) AS miss_item_cnt_vj

            FROM P_LEW_CORE_AC.v_cal_month_1                        AS cm

           INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_1        AS asm
              ON 1                        = 1

           INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_1        AS asm1
              ON asm.client_id            = asm1.client_id
             AND asm.store_id             = asm1.move_to_store_id
             AND asm.aspect_id            = asm1.aspect_id

           INNER JOIN (
                       SELECT DISTINCT d1.client_id
                              , d1.loc_sid_store
                              , d1.cy_month
                              , d1.busyear
                              , d1.item_grp_int_sid
                              , d1.sub_item_grp_sid
                              , d1.item_fam_grp_sid
                              , d1.itemgroup_int_id
                              , d1.subitemgroup_id
                              , d1.item_familygroup_id
                              , d1.currency_iso_cd
                              , d1.curr_tot_id
                              , COUNT(DISTINCT(CASE WHEN d1.miss_item_cnt IS NOT NULL AND d1.skipped_fg = 0 THEN d1.dat_formdate ELSE NULL END))
                                                                                                  OVER (PARTITION BY d1.client_id, d1.loc_sid_store, d1.cy_month, d1.item_familygroup_id, d1.currency_iso_cd) AS day_cnt
                              , SUM(d1.skipped_fg)                                                OVER (PARTITION BY d1.client_id, d1.loc_sid_store, d1.cy_month, d1.item_familygroup_id, d1.currency_iso_cd) AS skipped_cnt
                              , SUM(CASE WHEN d1.skipped_fg = 0 THEN d1.miss_item_cnt ELSE 0 END) OVER (PARTITION BY d1.client_id, d1.loc_sid_store, d1.cy_month, d1.item_familygroup_id, d1.currency_iso_cd) AS miss_item_cnt

                         FROM p_lew_mart_lead.t_agg_miss_sig_store_day_1    AS d1

                      ) AS maj
              ON asm.client_id            = maj.client_id
             AND asm1.store_id            = maj.loc_sid_store
             AND cm.cy_month              = maj.cy_month

           INNER JOIN (
                       SELECT DISTINCT d2.client_id
                              , d2.loc_sid_store
                              , d2.cy_month
                              , d2.busyear
                              , d2.item_grp_int_sid
                              , d2.sub_item_grp_sid
                              , d2.item_fam_grp_sid
                              , d2.itemgroup_int_id
                              , d2.subitemgroup_id
                              , d2.item_familygroup_id
                              , d2.currency_iso_cd
                              , d2.curr_tot_id
                              , COUNT(DISTINCT(CASE WHEN d2.miss_item_cnt IS NOT NULL AND d2.skipped_fg = 0 THEN d2.dat_formdate ELSE NULL END))
                                                                                                  OVER (PARTITION BY d2.client_id, d2.loc_sid_store, d2.cy_month, d2.item_familygroup_id, d2.currency_iso_cd) AS day_cnt
                              , SUM(d2.skipped_fg)                                                OVER (PARTITION BY d2.client_id, d2.loc_sid_store, d2.cy_month, d2.item_familygroup_id, d2.currency_iso_cd) AS skipped_cnt
                              , SUM(CASE WHEN d2.skipped_fg = 0 THEN d2.miss_item_cnt ELSE 0 END) OVER (PARTITION BY d2.client_id, d2.loc_sid_store, d2.cy_month, d2.item_familygroup_id, d2.currency_iso_cd) AS miss_item_cnt

                               FROM p_lew_mart_lead.t_agg_miss_sig_store_day_1    AS d2
                     ) AS mvj
              ON asm.client_id            = mvj.client_id
             AND asm1.store_id            = mvj.loc_sid_store
             AND cm.cy_month_prev_1y      = mvj.cy_month
             AND maj.item_familygroup_id  = mvj.item_familygroup_id
             AND maj.currency_iso_cd      = mvj.currency_iso_cd

        ) AS d
;