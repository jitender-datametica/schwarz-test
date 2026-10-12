/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_mat0_bo_base_abs
#----------------------------------------------------------------------------
# Description:

# Grundgesamtheit der zu beruecksichtigenden Zeilen aus SFO-Aggregat und Umsaetzen (EJR) fuer alle Laender und alle fuer ABS relevanten Zeitraeume
#
# Da die Daten aus dem BIL-Layer stammen, erfolgt die notwendige Korrektur in der Vergangenheit falsch zugeordneter
# ITEM_SIDs wegen des bekannten Fehlers des WAWI-Transportweges und dessen automatischer Anlage von unbekannten Artikeln mit CASE_SIZE = -1.
# Es wird der Klammer-Artikel der Keyintegration verwendet um somit immer den aktuellsten Stand evtl vorgenommener ITEM_SID-Korrekturen zu liefern
#
# Die View ist die unterste Basis zur Ziel-View v_mat_bo_base_abs und deren Materialisierung
# v_mat0_bo_base_abs ---> v_mat1_bo_base_abs ---> v_mat_bo_base_abs ---> t_bo_base_abs
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
#                                         Filter auf T_BO_ABS_CLIENT_STATUS aus Performancegruenden
#                                         in Sub-Select ausgelagert
# 1.95  05.03.2019    Wandtke,Andrzej     20190227_1972_TD_FBO_New_Reason_SonstigeWarenverluste Add
#                                         codes 136, 137 to other stock losses (redo changes because of version confilct)
# 1.96  26.03.2019    Michael Ueding      Rename Attribut discount_id to discount_sid
# 1.97  18.04.2019    Michael Strauch     adjust discount calculation - instead of using v_agg_pos_store_item_day as source
#                                         now v_agg_store_day_item_sfo_asis will be used
#                                          - LEAD-7212 | 20190326_2011_Rab_Logic_Fil_Mobile
#  2.0  15.10.2019    Luca Mancini        20191015_2252_HF_mat0_bo_base_DWHSup
#                     Slavik Taubkin      Cast changed from NUMBER(36,10) to NUMBER(18,5) for better performance
#  2.1  22.10.2019    Luca Mancini        20191022_2261_HF_mat0_bo_base_2DWHSup
#                     Slavik Taubkin      GROUP BY have been added for better performance
#  2.2  08.01.2021    Michael Morris      20210108_2703_v_mat0_bo_base_abs_cy_week_corr (Jira: REP4-8253)
#                                         Handling of the previous year cy_week and cy_week_seq corrected in both sub queries for previous year values.
#                                         Patch includes code standards modifications.
#  2.3  29.01.2021    Michael Morris      Transfer to Snowflake
#  2.4  22.06.2022    Martin Murtenthaler User Story 340475, INC4858373, PCWO_REASON_ID 152 added
#----------------------------------------------------------------------------
*/


/* suche die Landeswaehrung zum Client */
/* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt */
/* break */ /* force majeure */ /* writeoffs for mhd and break of stores */ /* Spenden Filiale */
/* in total store writeoffs */ /* Spenden Filiale */ /* writeoffs for quality of delivery */
/* in total "other stock losses" */ -- writeoffs for quality of delivery
 /* mhd */ /* mhd */
/* SFO fuer aktuelles Jahr */ /* Warenentnahme Filiale */ /* EJR-Werte fuer das aktuelle Jahr */
/* auf das aktuelle Jahr mappen */ /* in total store writeoffs */ /* writeoffs for other stock losses of stores */
/* Warenentnahme Filiale */ /* EJR-Werte fuer das Vorjahr */ /* discount */ /* SFO fuer Vorjahr */
/* auf das aktuelle Jahr mappen */ /* discount */ /* force majeure */ /* break */ /* in total store writeoffs */
/* writeoffs for mhd and break of stores */ /* writeoffs for other stock losses of stores */
/* in total "other stock losses" */ /* suche die Landeswaehrung zum Client */
/* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt */
/* in total "other stock losses" */ CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_bo_base_abs (client_id, store_id,
dat_formdate, cy_week, cy_week_seq, cy_month, currency_iso_cd, sub_item_grp_sid, subitemgroup_id, item_grp_int_sid,
itemgroup_int_id, val_rtl_rl_sfo, val_rtl_rl_net_sfo, val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss,
val_rtl_net_sfo_str_deliv_qlty, val_rtl_rl_sfo_py, val_rtl_rl_net_sfo_py, val_net_sfo_mhd_break_py,
val_net_sfo_other_stc_loss_py, val_net_sfo_str_deliv_qlty_py, val_wrtoff_zero, val_wrtoff_zero_net,
val_wrtoff_zero_net_mhd_break, val_wrtoff_zero_net_other_stc_loss, val_wrtoff_zero_net_str_deliv_qlty, val_discount_ejr
, val_discount_net_ejr, val_rtl_ejr_adj, val_rtl_net_ejr_adj, val_rtl_ejr_adj_py, val_rtl_net_ejr_adj_py) AS SELECT
 client_id,
 store_id,
 dat_formdate,
 cy_week,
 cy_week_seq,
 cy_month,
 currency_iso_cd,
 sub_item_grp_sid,
 subitemgroup_id,
 item_grp_int_sid,
 itemgroup_int_id,
 val_rtl_rl_sfo,
 val_rtl_rl_net_sfo,
 val_rtl_net_sfo_mhd_break,
 val_rtl_net_sfo_other_stc_loss,
 val_rtl_net_sfo_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo_py,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_mhd_break_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_other_stc_loss_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_str_deliv_qlty_py,
 val_wrtoff_zero,
 val_wrtoff_zero_net,
 val_wrtoff_zero_net_mhd_break,
 val_wrtoff_zero_net_other_stc_loss,
 val_wrtoff_zero_net_str_deliv_qlty,
 val_discount_ejr,
 val_discount_net_ejr,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj_py,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj_py
FROM (SELECT SFO.client_id,
   SFO.loc_sid_store AS store_id,
   SFO.booking_dat AS dat_formdate,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   SFO.curr_cd AS currency_iso_cd,
   SIG.sub_item_grp_sid,
   ROUND(CAST(TRIM(SIG.src_subitemgrp_cd) AS BIGNUMERIC), 0) AS subitemgroup_id,
   SIGH.item_grp_int_sid,
   ROUND(CAST(TRIM(SIGH.item_grp_int_cd) AS BIGNUMERIC), 0) AS itemgroup_int_id,
   SUM(SFO.sfo_total_rtl_rl_val_asis) AS val_rtl_rl_sfo,
   SUM(SFO.sfo_total_rtl_rl_net_val_asis) AS val_rtl_rl_net_sfo,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (1, 127, 134, 135 /* mhd */, 2, 128 /* break */)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_rtl_net_sfo_mhd_break,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (3, 136, 137, 152 /* force majeure */, 4, 101, 102, 110, 111, 129
       /* Warenentnahme Filiale */, 7, 130, 131 /* Spenden Filiale */)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_rtl_net_sfo_other_stc_loss,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (8)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_rtl_net_sfo_str_deliv_qlty,
   SUM(SFO.sfo_wrtoff_zero_rtl_rl_val_asis) AS val_wrtoff_zero,
   SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_val_asis) AS val_wrtoff_zero_net,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (1, 127, 134, 135 /* mhd */, 2, 128 /* break */)
     THEN SFO.sfo_wrtoff_zero_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_wrtoff_zero_net_mhd_break,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (3, 136, 137, 152 /* force majeure */, 4, 101, 102, 110, 111, 129
       /* Warenentnahme Filiale */, 7, 130, 131 /* Spenden Filiale */)
     THEN SFO.sfo_wrtoff_zero_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_wrtoff_zero_net_other_stc_loss,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (8)
     THEN SFO.sfo_wrtoff_zero_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_wrtoff_zero_net_str_deliv_qlty,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (5)
     THEN SFO.sfo_total_rtl_rl_val_asis
     ELSE 0
     END) AS val_discount_ejr,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (5)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_discount_net_ejr
  FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis AS SFO
   INNER JOIN ldl_p_lew_process_ac.v_bo_base_abs_cal_actual_year AS CAL ON SFO.booking_dat = CAL.cal_dt
    /* Item-Umschluesselung */
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS IMAP ON SFO.client_id = IMAP.client_id AND SFO.item_sid = IMAP.item_sid
     /* Item-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item bestimmen */
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON IMAP.client_id = IH.client_id AND IMAP.item_sid = IH.item_sid AND
     CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS IFGH ON IH.client_id = IFGH.client_id AND IH.item_fam_grp_sid
       = IFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN IFGH.dwh_valid_from AND IFGH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SIG ON IFGH.client_id = SIG.client_id AND IFGH.sub_item_grp_sid = SIG
     .sub_item_grp_sid
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid =
      SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
     /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
           noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status) vorliegt */
     
  WHERE EXISTS (SELECT 1
    FROM ldl_p_lew_process_ac.v_bo_abs_client_status AS CLIENTS
    WHERE SFO.client_id = client_id)
   AND SFO.sfotype_id IN (137, 147)
  GROUP BY SFO.client_id,
   store_id,
   dat_formdate,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   currency_iso_cd,
   SIG.sub_item_grp_sid,
   subitemgroup_id,
   SIGH.item_grp_int_sid,
   itemgroup_int_id) AS mT
UNION ALL
SELECT client_id,
 store_id,
 dat_formdate,
 cy_week,
 cy_week_seq,
 cy_month,
 currency_iso_cd,
 sub_item_grp_sid,
 subitemgroup_id,
 item_grp_int_sid,
 itemgroup_int_id,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_mhd_break,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
 val_rtl_rl_sfo_py,
 val_rtl_rl_net_sfo_py,
 val_net_sfo_mhd_break_py,
 val_net_sfo_other_stc_loss_py,
 val_net_sfo_str_deliv_qlty_py,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_mhd_break,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_discount_ejr,
 CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj_py,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj_py
FROM (SELECT SFO.client_id,
   SFO.loc_sid_store AS store_id,
   IF(SFO.booking_dat = LAST_DAY(SFO.booking_dat), LAST_DAY(DATE_ADD(SFO.booking_dat, INTERVAL 12 MONTH)), DATE_ADD(SFO
     .booking_dat, INTERVAL 12 MONTH)) AS dat_formdate,
   CY.cy_week,
   CY.cy_week_seq,
   CY.cy_month,
   SFO.curr_cd AS currency_iso_cd,
   SIG.sub_item_grp_sid,
   ROUND(CAST(TRIM(SIG.src_subitemgrp_cd) AS BIGNUMERIC), 0) AS subitemgroup_id,
   SIGH.item_grp_int_sid,
   ROUND(CAST(TRIM(SIGH.item_grp_int_cd) AS BIGNUMERIC), 0) AS itemgroup_int_id,
   SUM(SFO.sfo_total_rtl_rl_val_asis) AS val_rtl_rl_sfo_py,
   SUM(SFO.sfo_total_rtl_rl_net_val_asis) AS val_rtl_rl_net_sfo_py,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (1, 127, 134, 135 /* mhd */, 2, 128 /* break */)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_net_sfo_mhd_break_py,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (3, 136, 137, 152 /* force majeure */, 4, 101, 102, 110, 111, 129
       /* Warenentnahme Filiale */, 7, 130, 131 /* Spenden Filiale */)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_net_sfo_other_stc_loss_py,
   SUM(CASE
     WHEN SFO.pcwo_reason_id IN (8)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END) AS val_net_sfo_str_deliv_qlty_py
  FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis AS SFO
   INNER JOIN (SELECT cal_dt,
     MAX(cy_week) AS cy_week,
     MAX(cy_week_seq) AS cy_week_seq,
     cy_month
    FROM ldl_p_lew_process_ac.v_bo_base_abs_cal_prev_year
    GROUP BY cal_dt,
     cy_month) AS cal ON SFO.booking_dat = cal.cal_dt /* Get the cy_week_seq for the current date of year */
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CY ON IF(SFO.booking_dat = LAST_DAY(SFO.booking_dat), LAST_DAY(DATE_ADD(SFO
       .booking_dat, INTERVAL 12 MONTH)), DATE_ADD(SFO.booking_dat, INTERVAL 12 MONTH)) = CY.cal_dt
    /* Item-Umschluesselung */
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS IMAP ON SFO.client_id = IMAP.client_id AND SFO.item_sid = IMAP.item_sid
     /* Item-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item bestimmen */
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON IMAP.client_id = IH.client_id AND IMAP.item_sid = IH.item_sid AND
     CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS IFGH ON IH.client_id = IFGH.client_id AND IH.item_fam_grp_sid
       = IFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN IFGH.dwh_valid_from AND IFGH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SIG ON IFGH.client_id = SIG.client_id AND IFGH.sub_item_grp_sid = SIG
     .sub_item_grp_sid
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid =
      SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
     /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status) vorliegt */
     
  WHERE EXISTS (SELECT 1
    FROM ldl_p_lew_process_ac.v_bo_abs_client_status AS CLIENTS
    WHERE SFO.client_id = client_id)
   AND SFO.sfotype_id IN (137, 147)
  GROUP BY SFO.client_id,
   store_id,
   dat_formdate,
   CY.cy_week,
   CY.cy_week_seq,
   CY.cy_month,
   currency_iso_cd,
   SIG.sub_item_grp_sid,
   subitemgroup_id,
   SIGH.item_grp_int_sid,
   itemgroup_int_id) AS mT
UNION ALL
SELECT client_id,
 store_id,
 dat_formdate,
 cy_week,
 cy_week_seq,
 cy_month,
 currency_iso_cd,
 sub_item_grp_sid,
 subitemgroup_id,
 item_grp_int_sid,
 itemgroup_int_id,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_mhd_break,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo_py,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_mhd_break_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_other_stc_loss_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_str_deliv_qlty_py,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_mhd_break,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_discount_ejr,
 CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
 val_rtl_ejr_adj,
 val_rtl_net_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj_py,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj_py
FROM (SELECT EJR.client_id,
   EJR.loc_sid_store AS store_id,
   EJR.dwh_cal_dt AS dat_formdate,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   C.curr_cd AS currency_iso_cd,
   SIG.sub_item_grp_sid,
   ROUND(CAST(TRIM(SIG.src_subitemgrp_cd) AS BIGNUMERIC), 0) AS subitemgroup_id,
   SIGH.item_grp_int_sid,
   ROUND(CAST(TRIM(SIGH.item_grp_int_cd) AS BIGNUMERIC), 0) AS itemgroup_int_id,
   SUM(EJR.return_gross_val + EJR.sales_gross_val) AS val_rtl_ejr_adj,
   SUM(EJR.return_net_val + EJR.sales_net_val) AS val_rtl_net_ejr_adj
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS EJR
   INNER JOIN ldl_p_lew_core_ac.v_client AS C ON EJR.client_id
    /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt
               Hierbei wird die DAY-Ebene (CY_WEEK_SEQ between -4 and 0) immer implizit von der MTH-Ebene abgedeckt */
    = C.client_id
   INNER JOIN ldl_p_lew_process_ac.v_bo_base_abs_cal_actual_year AS CAL ON EJR.dwh_cal_dt = CAL.cal_dt
    /* Item-Umschluesselung */
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS IMAP ON EJR.client_id = IMAP.client_id AND EJR.item_sid = IMAP.item_sid
     /* Item-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item bestimmen */
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON IMAP.client_id = IH.client_id AND IMAP.item_sid = IH.item_sid AND
     CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS IFGH ON IH.client_id = IFGH.client_id AND IH.item_fam_grp_sid
       = IFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN IFGH.dwh_valid_from AND IFGH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SIG ON IFGH.client_id = SIG.client_id AND IFGH.sub_item_grp_sid = SIG
     .sub_item_grp_sid
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid =
      SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
     /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status) vorliegt */
     
  WHERE EXISTS (SELECT 1
    FROM ldl_p_lew_process_ac.v_bo_abs_client_status AS CLIENTS
    WHERE EJR.client_id = client_id)
  GROUP BY EJR.client_id,
   store_id,
   dat_formdate,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   currency_iso_cd,
   SIG.sub_item_grp_sid,
   subitemgroup_id,
   SIGH.item_grp_int_sid,
   itemgroup_int_id) AS mT
UNION ALL
SELECT client_id,
 store_id,
 dat_formdate,
 cy_week,
 cy_week_seq,
 cy_month,
 currency_iso_cd,
 sub_item_grp_sid,
 subitemgroup_id,
 item_grp_int_sid,
 itemgroup_int_id,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_mhd_break,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo_py,
 CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_mhd_break_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_other_stc_loss_py,
 CAST(NULL AS NUMERIC) AS val_net_sfo_str_deliv_qlty_py,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_mhd_break,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_other_stc_loss,
 CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_str_deliv_qlty,
 CAST(NULL AS NUMERIC) AS val_discount_ejr,
 CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
 CAST(NULL AS NUMERIC) AS val_rtl_ejr_adj,
 CAST(NULL AS NUMERIC) AS val_rtl_net_ejr_adj,
 val_rtl_ejr_adj_py,
 val_rtl_net_ejr_adj_py
FROM (SELECT EJR.client_id,
   EJR.loc_sid_store AS store_id,
   IF(EJR.dwh_cal_dt = LAST_DAY(EJR.dwh_cal_dt), LAST_DAY(DATE_ADD(EJR.dwh_cal_dt, INTERVAL 12 MONTH)), DATE_ADD(EJR.dwh_cal_dt
     ,INTERVAL 12 MONTH)) AS dat_formdate,
   CY.cy_week,
   CY.cy_week_seq,
   CY.cy_month,
   C.curr_cd AS currency_iso_cd,
   SIG.sub_item_grp_sid,
   ROUND(CAST(TRIM(SIG.src_subitemgrp_cd) AS BIGNUMERIC), 0) AS subitemgroup_id,
   SIGH.item_grp_int_sid,
   ROUND(CAST(TRIM(SIGH.item_grp_int_cd) AS BIGNUMERIC), 0) AS itemgroup_int_id,
   SUM(EJR.return_gross_val + EJR.sales_gross_val) AS val_rtl_ejr_adj_py,
   SUM(EJR.return_net_val + EJR.sales_net_val) AS val_rtl_net_ejr_adj_py
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS EJR
   INNER JOIN ldl_p_lew_core_ac.v_client AS C ON EJR.client_id
    /* maximalen Zeitbereich auswaehlen, der alle Views auf _DAY, _WEEK und  _MTH-Ebene abdeckt */ = C.client_id
   INNER JOIN (SELECT cal_dt,
     MAX(cy_week) AS cy_week,
     MAX(cy_week_seq) AS cy_week_seq,
     cy_month
    FROM ldl_p_lew_process_ac.v_bo_base_abs_cal_prev_year
    GROUP BY cal_dt,
     cy_month) AS cal ON EJR.dwh_cal_dt = cal.cal_dt /* Get the cy_week_seq for the current date of year */
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CY ON IF(EJR.dwh_cal_dt = LAST_DAY(EJR.dwh_cal_dt), LAST_DAY(DATE_ADD(EJR
       .dwh_cal_dt, INTERVAL 12 MONTH)), DATE_ADD(EJR.dwh_cal_dt, INTERVAL 12 MONTH)) = CY.cal_dt
    /* Item-Umschluesselung */
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS IMAP ON EJR.client_id = IMAP.client_id AND EJR.item_sid = IMAP.item_sid
     /* Item-Hierarchie aus ASIS-Sicht ueber umgeschluesseltes Item bestimmen */
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON IMAP.client_id = IH.client_id AND IMAP.item_sid = IH.item_sid AND
     CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS IFGH ON IH.client_id = IFGH.client_id AND IH.item_fam_grp_sid
       = IFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN IFGH.dwh_valid_from AND IFGH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SIG ON IFGH.client_id = SIG.client_id AND IFGH.sub_item_grp_sid = SIG
     .sub_item_grp_sid
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid =
      SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
     /* Wir filtern zur Laufzeit auf einen Vergleich der abzuarbeitenden clients ggue. den bereits abgearbeiteten Clients an. So wird nur das Delta abgearbeitet, welches
               noch nicht im materialisierten Ziel (Tabelle d_lew_mart_msi.t_bo_abs_client_status) vorliegt */
     
  WHERE EXISTS (SELECT 1
    FROM ldl_p_lew_process_ac.v_bo_abs_client_status AS CLIENTS
    WHERE EJR.client_id = client_id)
  GROUP BY EJR.client_id,
   store_id,
   dat_formdate,
   CY.cy_week,
   CY.cy_week_seq,
   CY.cy_month,
   currency_iso_cd,
   SIG.sub_item_grp_sid,
   subitemgroup_id,
   SIGH.item_grp_int_sid,
   itemgroup_int_id) AS mT;