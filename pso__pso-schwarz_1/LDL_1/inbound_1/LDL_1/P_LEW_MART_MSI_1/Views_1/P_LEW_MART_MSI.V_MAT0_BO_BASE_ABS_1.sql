/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_mat0_bo_base_abs_1
#----------------------------------------------------------------------------
# Description:

# Grundgesamtheit der zu beruecksichtigenden Zeilen aus SFO-Aggregat und Umsaetzen (EJR) fuer alle Laender und alle fuer ABS relevanten Zeitraeume
#
# Da die Daten aus dem BIL-Layer stammen, erfolgt die notwendige Korrektur in der Vergangenheit falsch zugeordneter
# ITEM_SIDs wegen des bekannten Fehlers des WAWI-Transportweges und dessen automatischer Anlage_1 von unbekannten Artikeln mit CASE_SIZE = -1.
# Es wird der Klammer-Artikel_1 der Keyintegration verwendet um somit immer den aktuellsten Stand evtl vorgenommener ITEM_SID-Korrekturen zu liefern
#
# Die View ist die unterste Basis zur Ziel-View v_mat_bo_base_abs_1 und deren Materialisierung
# v_mat0_bo_base_abs_1 ---> v_mat1_bo_base_abs_1 ---> v_mat_bo_base_abs_1 ---> t_bo_base_abs_1
#
#----------------------------------------------------------------------------
# History:
#                                         Neuanlage
#                                         Korrektur Zeitauswahl PY
#                                         Eliminierung von UNION fuer Zeitauswahl PY
#                                         BugFix Zeitauswahl PY
#  1.5  04.07.2018    Arnold,Arne         Rueckbau fuer HotFix
#  1.6  05.07.2018    Arnold,Arne         Aufnahme von CURRENT_YEAR_DATA_FG und Umstellung der EJR-Quelle
#  1.7  17.07.2018    Thole,Jens          Einbau einer Prozess-Tabelle, mit der die Clienten Clustergesteuert ausgewaehlt werden.
#  1.8  25.07.2018    Thole,Jens          INNER JOIN fuer ITEM_SID-Klammer-Schluessel ITEM_SID_MAP nach Aenderung
#                                         des Paradigmas der Klammer-SID-Bildung (Vollstaendig - nicht nur fuer real zu
#                                         klammernde ITEMS sodern fuer alle).
#  1.9  05.10.2018    Wandtke,Andrzej     20180925_1840_FBO_Provide_Filial_Abschriften_Part2 -
#                                         Add columns related to specific types of writeoffs
# 1.91  16.11.2018    Michael Strauch     20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some
#                                         columns to differenziate the values by pcwo_resons
# 1.92  23.01.2019    Arnold,Arne         BackOffice Performanceoptimierung - Jira DWH-2400
# 1.93  27.02.2019    Wandtke,Andrzej     20190227_1972_TD_FBO_New_Reason_SonstigeWarenverluste
#                                         Add codes 136, 137 to other stock losses
# 1.94  05.03.2019    Arnold,Arne         BackOffice Performanceoptimierung - Jira DWH-2400 -
#                                         Filter auf T_BO_ABS_CLIENT_STATUS_1 aus Performancegruenden
#                                         in Sub-Select ausgelagert
# 1.95  05.03.2019    Wandtke,Andrzej     20190227_1972_TD_FBO_New_Reason_SonstigeWarenverluste Add
#                                         codes 136, 137 to other stock losses (redo changes because of version confilct)
# 1.96  26.03.2019    Michael Ueding      Rename Attribut discount_id to discount_sid
# 1.97  18.04.2019    Michael Strauch     adjust discount calculation - instead of using v_agg_pos_store_item_day_1 as source
#                                         now v_agg_store_day_item_sfo_asis_1 will be used
#                                          - LEAD-7212 | 20190326_2011_Rab_Logic_Fil_Mobile
#  2.0  15.10.2019    Luca Mancini        20191015_2252_HF_mat0_bo_base_DWHSup
#                     Slavik Taubkin      Cast changed from DECIMAL(36,10) to DECIMAL(18,5) for better performance
#  2.1  22.10.2019    Luca Mancini        20191022_2261_HF_mat0_bo_base_2DWHSup
#                     Slavik Taubkin      GROUP BY have been added for better performance
#  2.2  08.01.2021    Michael Morris      20210108_2703_v_mat0_bo_base_abs_cy_week_corr (Jira: REP4-8253)
#                                         Handling of the previous year cy_week and cy_week_seq corrected in both sub queries for previous year values.
#                                         Patch includes code standards modifications.
#  2.3  29.01.2021    Michael Morris      Transfer to Snowflake
#  2.4  22.06.2022    Martin Murtenthaler User Story 340475, INC4858373, PCWO_REASON_ID 152 added
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_BO_BASE_ABS_1
(
       client_Id
     , store_id
     , dat_formdate
     , cy_week
     , cy_week_seq
     , cy_month
     , currency_iso_cd
     , sub_item_grp_sid
     , subitemgroup_id
     , item_grp_int_sid
     , itemgroup_int_id
     , val_rtl_rl_sfo
     , val_rtl_rl_net_sfo
     , val_rtl_net_sfo_mhd_break
     , val_rtl_net_sfo_other_stc_loss
     , val_rtl_net_sfo_str_deliv_qlty
     , val_rtl_rl_sfo_py
     , val_rtl_rl_net_sfo_py
     , val_net_sfo_mhd_break_py
     , val_net_sfo_other_stc_loss_py
     , val_net_sfo_str_deliv_qlty_py
     , val_wrtoff_zero
     , val_wrtoff_zero_net
     , val_wrtoff_zero_net_mhd_break
     , val_wrtoff_zero_net_other_stc_loss
     , val_wrtoff_zero_net_str_deliv_qlty
     , val_discount_ejr
     , val_discount_net_ejr
     , val_rtl_ejr_adj
     , val_rtl_net_ejr_adj
     , val_rtl_ejr_adj_py
     , val_rtl_net_ejr_adj_py
) AS
/* SFO fuer aktuelles Jahr  */
SELECT
       client_Id
     , store_id
     , dat_formdate
     , cy_week
     , cy_week_seq
     , cy_month
     , currency_iso_cd
     , sub_item_grp_sid
     , subitemgroup_id
     , item_grp_int_sid
     , itemgroup_int_id
     , val_rtl_rl_sfo
     , val_rtl_rl_net_sfo
     , val_rtl_net_sfo_mhd_break
     , val_rtl_net_sfo_other_stc_loss
     , val_rtl_net_sfo_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_mhd_break_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_other_stc_loss_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_str_deliv_qlty_py
     , val_wrtoff_zero
     , val_wrtoff_zero_net
     , val_wrtoff_zero_net_mhd_break
     , val_wrtoff_zero_net_other_stc_loss
     , val_wrtoff_zero_net_str_deliv_qlty
     , val_discount_ejr
     , val_discount_net_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj_py
FROM (
        SELECT   sfo.client_id
               , sfo.loc_sid_store                                              AS store_id
               , sfo.booking_dat                                                AS dat_formdate
               , cal.cy_week
               , cal.cy_week_seq
               , cal.cy_month
               , sfo.curr_cd                                                    AS currency_iso_cd
               , sig.sub_item_grp_sid
               , TO_NUMBER(TRIM(sig.src_subitemgrp_cd))                         AS subitemgroup_id
               , sigh.item_grp_int_sid
               , TO_NUMBER(TRIM(sigh.item_grp_int_cd))                          AS itemgroup_int_id
               , SUM(sfo.sfo_total_rtl_rl_val_asis)                             AS val_rtl_rl_sfo
               , SUM(sfo.sfo_total_rtl_rl_net_val_asis)                         AS val_rtl_rl_net_sfo
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 1, 127, 134, 135 /* mhd                      */
                                                        ,2, 128         /* break                    */
                                                                     )  /* in total store writeoffs */
                           THEN sfo.sfo_total_rtl_rl_net_val_asis
                           ELSE 0
                      END)                                                      AS val_rtl_net_sfo_mhd_break    /* writeoffs for mhd and break of stores  */
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 3, 136, 137, 152        /* force majeure                 */
                                                   ,4, 101, 102, 110, 111, 129 /* Warenentnahme Filiale         */
                                                   ,7, 130, 131                /* Spenden Filiale               */
                                                  )                            /* in total "other stock losses" */
                           THEN sfo.sfo_total_rtl_rl_net_val_asis
                           ELSE 0
                      END)                                                      AS val_rtl_net_sfo_other_stc_loss /* writeoffs for other stock losses of stores */
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 8 )
                          THEN sfo.sfo_total_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_rtl_net_sfo_str_deliv_qlty /* writeoffs for quality of delivery          */
               , SUM(sfo.sfo_wrtoff_zero_rtl_rl_val_asis)                       AS val_wrtoff_zero
               , SUM(sfo.sfo_wrtoff_zero_rtl_rl_net_val_asis)                   AS val_wrtoff_zero_net
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 1, 127, 134, 135 /* mhd                        */
                                                  ,2, 128               /* break                      */
                                                 )                      /* in total store writeoffs   */
                          THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_wrtoff_zero_net_mhd_break
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 3, 136, 137, 152       /* force majeure                  */
                                                  ,4, 101, 102, 110, 111, 129 /* Warenentnahme Filiale          */
                                                  ,7, 130, 131                /* Spenden Filiale                */
                                                 )                            /* in total "other stock losses"  */
                          THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_wrtoff_zero_net_other_stc_loss
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 8 )
                          THEN sfo.sfo_wrtoff_zero_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_wrtoff_zero_net_str_deliv_qlty
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 5 )                     /* discount */
                          THEN sfo.sfo_total_rtl_rl_val_asis
                          ELSE 0
                      END)                                                      AS val_discount_ejr
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 5 )                     /* discount */
                          THEN sfo.sfo_total_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_discount_net_ejr
          FROM P_LEW_BIL_AC.v_agg_store_day_item_sfo_asis_1          AS sfo
            /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt */
         INNER JOIN P_LEW_PROCESS_AC.v_bo_base_abs_cal_actual_year_1 AS cal
            ON sfo.booking_dat       = cal.cal_dt
            /*  Item_1-Umschluesselung  */
         INNER JOIN P_LEW_CORE_AC.v_item_map_key_1                   AS imap
            ON sfo.client_id         = imap.client_id
           AND sfo.item_sid          = imap.item_sid
            /*  Item_1-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item_1 bestimmen */
         INNER JOIN P_LEW_CORE_AC.v_item_hist_1                      AS ih
            ON imap.client_id        = ih.client_id
           AND imap.item_sid         = ih.item_sid
           AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1          AS ifgh
            ON ih.client_id          = ifgh.client_id
           AND ih.item_fam_grp_sid   = ifgh.item_fam_grp_sid
           AND CURRENT_DATE BETWEEN ifgh.dwh_valid_from AND ifgh.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_1                   AS sig
            ON ifgh.client_id        = sig.client_id
           AND ifgh.sub_item_grp_sid = sig.sub_item_grp_sid
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_1              AS sigh
            ON sig.client_id         = sigh.client_id
           AND sig.sub_item_grp_sid  = sigh.sub_item_grp_sid
           AND CURRENT_DATE BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to
        /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
           noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status_1) vorliegt */
        WHERE EXISTS (
                      SELECT 1
                      FROM P_LEW_PROCESS_AC.v_bo_abs_client_status_1 AS clients
                      WHERE sfo.client_id = clients.client_id
                     )
          AND  sfo.sfotype_id IN (137, 147)
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
) mT

UNION ALL

SELECT
       client_Id
     , store_id
     , dat_formdate
     , cy_week
     , cy_week_seq
     , cy_month
     , currency_iso_cd
     , sub_item_grp_sid
     , subitemgroup_id
     , item_grp_int_sid
     , itemgroup_int_id
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_str_deliv_qlty
     , val_rtl_rl_sfo_py
     , val_rtl_rl_net_sfo_py
     , val_net_sfo_mhd_break_py
     , val_net_sfo_other_stc_loss_py
     , val_net_sfo_str_deliv_qlty_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_net_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj_py
FROM (
/* SFO fuer Vorjahr  */
        SELECT   sfo.client_id
               , sfo.loc_sid_store AS store_id
               , ADD_MONTHS(sfo.booking_dat, 12)                                AS dat_formdate /* auf das aktuelle Jahr mappen */
               , cy.cy_week
               , cy.cy_week_seq
               , cy.cy_month
               , sfo.curr_cd AS currency_iso_cd
               , sig.sub_item_grp_sid
               , TO_NUMBER(TRIM(sig.src_subitemgrp_cd))                         AS subitemgroup_id
               , sigh.item_grp_int_sid
               , TO_NUMBER(TRIM(sigh.item_grp_int_cd))                          AS itemgroup_int_id
               , SUM(sfo.sfo_total_rtl_rl_val_asis)                             AS val_rtl_rl_sfo_py
               , SUM(sfo.sfo_total_rtl_rl_net_val_asis)                         AS val_rtl_rl_net_sfo_py
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 1, 127, 134, 135 /* mhd                      */
                                                  ,2, 128               /* break                    */
                                                 )                      /* in total store writeoffs */
                          THEN sfo.sfo_total_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_net_sfo_mhd_break_py   /* writeoffs for mhd and break of stores  */
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 3, 136, 137, 152       /* force majeure                 */
                                                  ,4, 101, 102, 110, 111, 129 /* Warenentnahme Filiale         */
                                                  ,7, 130, 131                /* Spenden Filiale               */
                                                 )                            /* in total "other stock losses" */
                          THEN sfo.sfo_total_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_net_sfo_other_stc_loss_py /* writeoffs for other stock losses of stores */
               , SUM(CASE WHEN sfo.pcwo_reason_id IN ( 8 )
                          THEN sfo.sfo_total_rtl_rl_net_val_asis
                          ELSE 0
                      END)                                                      AS val_net_sfo_str_deliv_qlty_py     --writeoffs for quality of delivery
          FROM P_LEW_BIL_AC.v_agg_store_day_item_sfo_asis_1          AS sfo
            /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt  */
         INNER JOIN (
                     SELECT   cal_dt
                            , MAX(cy_week) AS cy_week
                            , MAX(cy_week_seq) AS cy_week_seq
                            , cy_month
                       FROM P_LEW_PROCESS_AC.v_bo_base_abs_cal_prev_year_1
                      GROUP BY   cal_dt
                               , cy_month
                     )                                               AS cal
            ON sfo.booking_dat = cal.cal_dt
            /* Get the cy_week_seq for the current date of year  */
         INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1                AS cy
            ON ADD_MONTHS(sfo.booking_dat, 12) = cy.cal_dt
            /*  Item_1-Umschluesselung */
         INNER JOIN P_LEW_CORE_AC.v_item_map_key_1                   AS imap
            ON sfo.client_id         = imap.client_id
           AND sfo.item_sid          = imap.item_sid
            /*  Item_1-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item_1 bestimmen */
         INNER JOIN P_LEW_CORE_AC.v_item_hist_1                      AS ih
            ON imap.client_id        = ih.client_id
           AND imap.item_sid         = ih.item_sid
           AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1          AS ifgh
            ON ih.client_id          = ifgh.client_id
           AND ih.item_fam_grp_sid   = ifgh.item_fam_grp_sid
           AND CURRENT_DATE BETWEEN ifgh.dwh_valid_from AND ifgh.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_1                   AS sig
            ON ifgh.client_id        = sig.client_id
           AND ifgh.sub_item_grp_sid = sig.sub_item_grp_sid
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_1              AS sigh
            ON sig.client_id         = sigh.client_id
           AND sig.sub_item_grp_sid  = sigh.sub_item_grp_sid
           AND CURRENT_DATE BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to
            /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status_1) vorliegt  */
        WHERE EXISTS (
                      SELECT 1
                      FROM P_LEW_PROCESS_AC.v_bo_abs_client_status_1 AS clients
                      WHERE sfo.client_id = clients.client_id
                     )
          AND  sfo.sfotype_id IN (137, 147)
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
) mT

UNION ALL

SELECT
       client_Id
     , store_id
     , dat_formdate
     , cy_week
     , cy_week_seq
     , cy_month
     , currency_iso_cd
     , sub_item_grp_sid
     , subitemgroup_id
     , item_grp_int_sid
     , itemgroup_int_id
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_mhd_break_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_other_stc_loss_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_str_deliv_qlty_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_net_ejr
     , val_rtl_ejr_adj
     , val_rtl_net_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj_py
FROM (
/* EJR-Werte fuer das aktuelle Jahr  */
        SELECT   ejr.client_id
               , ejr.loc_sid_store                                              AS store_id
               , ejr.dwh_cal_dt                                                 AS dat_formdate
               , cal.cy_week
               , cal.cy_week_seq
               , cal.cy_month
               , c.curr_cd                                                      AS currency_iso_cd
               , sig.sub_item_grp_sid
               , TO_NUMBER(TRIM(sig.src_subitemgrp_cd))                         AS subitemgroup_id
               , sigh.item_grp_int_sid
               , TO_NUMBER(TRIM(sigh.item_grp_int_cd))                          AS itemgroup_int_id
               , SUM(ejr.return_gross_val + ejr.sales_gross_val)                AS val_rtl_ejr_adj
               , SUM(ejr.return_net_val + ejr.sales_net_val)                    AS val_rtl_net_ejr_adj
          FROM P_LEW_BIL_AC.v_agg_pos_store_item_day_1               AS ejr
            /* suche die Landeswaehrung zum Client */
         INNER JOIN P_LEW_CORE_AC.v_client_1                         AS c
            ON c.client_id= ejr.client_id
            /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt */
         INNER JOIN P_LEW_PROCESS_AC.v_bo_base_abs_cal_actual_year_1 AS cal
            ON ejr.dwh_cal_dt = cal.cal_dt
            /* Item_1-Umschluesselung */
         INNER JOIN P_LEW_CORE_AC.v_item_map_key_1                   AS imap
            ON ejr.client_id         = imap.client_id
           AND ejr.item_sid          = imap.item_sid
            /* Item_1-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item_1 bestimmen */
         INNER JOIN P_LEW_CORE_AC.v_item_hist_1                      AS ih
            ON imap.client_id        = ih.client_id
           AND imap.item_sid         = ih.item_sid
           AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1          AS ifgh
            ON ih.client_id          = ifgh.client_id
           AND ih.item_fam_grp_sid   = ifgh.item_fam_grp_sid
           AND CURRENT_DATE BETWEEN ifgh.dwh_valid_from AND ifgh.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_1                   AS sig
            ON ifgh.client_id        = sig.client_id
           AND ifgh.sub_item_grp_sid = sig.sub_item_grp_sid
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_1              AS sigh
            ON sig.client_id         = sigh.client_id
           AND sig.sub_item_grp_sid  = sigh.sub_item_grp_sid
           AND CURRENT_DATE BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to
            /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status_1) vorliegt */
        WHERE EXISTS (
                      SELECT 1
                      FROM P_LEW_PROCESS_AC.v_bo_abs_client_status_1 AS clients
                      WHERE ejr.client_id = clients.client_id
                     )
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
) mT

UNION ALL

SELECT
       client_Id
     , store_id
     , dat_formdate
     , cy_week
     , cy_week_seq
     , cy_month
     , currency_iso_cd
     , sub_item_grp_sid
     , subitemgroup_id
     , item_grp_int_sid
     , itemgroup_int_id
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_sfo_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_rl_net_sfo_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_mhd_break_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_other_stc_loss_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_net_sfo_str_deliv_qlty_py
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_mhd_break
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_other_stc_loss
     , CAST(NULL AS NUMBER(18, 5))           AS val_wrtoff_zero_net_str_deliv_qlty
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_discount_net_ejr
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_ejr_adj
     , CAST(NULL AS NUMBER(18, 5))           AS val_rtl_net_ejr_adj
     , val_rtl_ejr_adj_py
     , val_rtl_net_ejr_adj_py
FROM (
/* EJR-Werte fuer das Vorjahr */
        SELECT   ejr.client_id
               , ejr.loc_sid_store AS store_id
               , ADD_MONTHS(ejr.dwh_cal_dt, 12)                                 AS dat_formdate /* auf das aktuelle Jahr mappen */
               , cy.cy_week
               , cy.cy_week_seq
               , cy.cy_month
               , c.curr_cd                                                      AS currency_iso_cd
               , sig.sub_item_grp_sid
               , TO_NUMBER(TRIM(sig.src_subitemgrp_cd))                         AS subitemgroup_id
               , sigh.item_grp_int_sid
               , TO_NUMBER(TRIM(sigh.item_grp_int_cd))                          AS itemgroup_int_id
               , SUM(ejr.return_gross_val + ejr.sales_gross_val)                AS val_rtl_ejr_adj_py
               , SUM(ejr.return_net_val + ejr.sales_net_val)                    AS val_rtl_net_ejr_adj_py
          FROM P_LEW_BIL_AC.v_agg_pos_store_item_day_1       AS ejr
            /* suche die Landeswaehrung zum Client  */
         INNER JOIN P_LEW_CORE_AC.v_client_1                 AS c
            ON c.client_id = ejr.client_id
            /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt */
         INNER JOIN (
                      SELECT   cal_dt
                             , MAX(cy_week)     AS cy_week
                             , MAX(cy_week_seq) AS cy_week_seq
                             , cy_month
                        FROM P_LEW_PROCESS_AC.v_bo_base_abs_cal_prev_year_1
                       GROUP BY   cal_dt
                                , cy_month
                      ) AS cal
            ON ejr.dwh_cal_dt = cal.cal_dt
            /* Get the cy_week_seq for the current date of year  */
         INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1        AS cy
            ON ADD_MONTHS(ejr.dwh_cal_dt, 12) = cy.cal_dt
            /* Item_1-Umschluesselung */
         INNER JOIN P_LEW_CORE_AC.v_item_map_key_1           AS imap
            ON ejr.client_id         = imap.client_id
           AND ejr.item_sid          = imap.item_sid
            /* Item_1-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item_1 bestimmen  */
         INNER JOIN P_LEW_CORE_AC.v_item_hist_1              AS ih
            ON imap.client_id        = ih.client_id
           AND imap.item_sid         = ih.item_sid
           AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1  AS ifgh
            ON ih.client_id          = ifgh.client_id
           AND ih.item_fam_grp_sid   = ifgh.item_fam_grp_sid
           AND CURRENT_DATE BETWEEN ifgh.dwh_valid_from AND ifgh.dwh_valid_to
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_1           AS sig
            ON ifgh.client_id        = sig.client_id
           AND ifgh.sub_item_grp_sid = sig.sub_item_grp_sid
         INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_1      AS sigh
            ON sig.client_id         = sigh.client_id
           AND sig.sub_item_grp_sid  = sigh.sub_item_grp_sid
           AND CURRENT_DATE BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to
            /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status_1) vorliegt */
         WHERE EXISTS (
                       SELECT 1
                       FROM P_LEW_PROCESS_AC.v_bo_abs_client_status_1 AS clients
                       WHERE ejr.client_id = clients.client_id
                      )
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
) mT;