CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_SIG_STORE_DAY_1 COMMENT = 'Base view for all item_1/store views: Counts the missing items per UWG-SIG/day'
(
  client_id                    COMMENT 'MIS Client ID'
, loc_sid_wh                   COMMENT 'S-Key der Gesellschaft'
, move_to_store_id             COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                        COMMENT 'Gesellschaft ID'
, orig_store_nr                COMMENT 'Store ID'
, item_grp_int_sid             COMMENT 'S-Key für Internationale Warengruppe'
, sub_item_grp_sid             COMMENT 'S-Key für Unterwarengruppe'
, item_fam_grp_sid             COMMENT 'S-Key der Artikelfamiliengruppe'
, itemgroup_int_id             COMMENT 'Warengruppe ID'
, subitemgroup_id              COMMENT 'Unterwarengruppe ID'
, item_familygroup_id          COMMENT 'Artikelfamilie ID'
, aspect_id                    COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd              COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                  COMMENT 'Interner Währungs-Code'
, dat_formdate                 COMMENT 'Bezugsdatum'
, day_of_week                  COMMENT 'Tag_1 der Woche_1'
, cy_month                     COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, cy_week_partial_week_id      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_week                      COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                      COMMENT 'Geschäftsjahr'
, miss_item_cnt                COMMENT 'Anzahl der Fehlartikel'
, skipped_fg                   COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'
, cal_dt_vj_cal                COMMENT 'Datum des Vorjahres (gleiche Wochentag)'
, cy_week_vj_cal               COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj_cal              COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj_cal               COMMENT 'Geschäftsjahr - von Vorjahr'
, miss_item_cnt_vj_cal         COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, skipped_fg_vj_cal            COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'
, miss_item_cnt_diff_cal       COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_cnt_diff_delta_cal COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
, cal_dt_vj_dat                COMMENT 'Datum des Vorjahres'
, cy_week_vj_dat               COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj_dat              COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj_dat               COMMENT 'Geschäftsjahr - von Vorjahr'
, miss_item_cnt_vj_dat         COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, skipped_fg_vj_dat            COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'
, miss_item_cnt_diff_dat       COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_cnt_diff_delta_dat COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/product group/month.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     09.12.2022      Michael Morris             Vorjahr CALC und DAT hinzugefügt
#
#-----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , move_to_store_id
       , wh_id
       , orig_store_nr
       , item_grp_int_sid
       , sub_item_grp_sid
       , item_fam_grp_sid
       , itemgroup_int_id
       , subitemgroup_id
       , item_familygroup_id
       , aspect_id
       , currency_iso_cd
       , curr_tot_id
       , dat_formdate
       , day_of_week
       , cy_month
       , cy_week_partial_week_id
       , cy_week
       , busyear
       , miss_item_cnt
       , skipped_fg
       , cal_dt_vj_cal
       , cy_week_vj_cal
       , cy_month_vj_cal
       , busyear_vj_cal
       , miss_item_cnt_vj_cal
       , skipped_fg_vj_cal
       , miss_item_cnt_diff_cal
       , miss_item_cnt_diff_delta_cal
       , cal_dt_vj_dat
       , cy_week_vj_dat
       , cy_month_vj_dat
       , busyear_vj_dat
       , miss_item_cnt_vj_dat
       , skipped_fg_vj_dat
       , miss_item_cnt_diff_dat
       , miss_item_cnt_diff_delta_dat
  FROM P_LEW_MART_LEAD.v_agg_miss_sig_store_day_1
;