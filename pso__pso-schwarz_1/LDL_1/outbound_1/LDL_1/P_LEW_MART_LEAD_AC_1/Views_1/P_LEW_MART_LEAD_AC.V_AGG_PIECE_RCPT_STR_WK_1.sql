/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.V_AGG_PIECE_RCPT_STR_WK_1
#----------------------------------------------------------------------------
# History:
#  1.0    2021-07-19         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_piece_rcpt_str_wk_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_store_move_to OPTIONS(description='S-Key der Location_1, hier der Filiale'), currency_iso_cd
OPTIONS(description='Währung ISO Code'), busyear OPTIONS(description='Käufer'), cy_month
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche_1'), piece_rcpt_wd1_val
OPTIONS(description='KPI Stuckbon für Tag_1 1 der Teilwoche'), piece_rcpt_wd2_val
OPTIONS(description='KPI Stuckbon für Tag_1 2 der Teilwoche'), piece_rcpt_wd3_val
OPTIONS(description='KPI Stuckbon für Tag_1 3 der Teilwoche'), piece_rcpt_wd4_val
OPTIONS(description='KPI Stuckbon für Tag_1 4 der Teilwoche'), piece_rcpt_wd5_val
OPTIONS(description='KPI Stuckbon für Tag_1 5 der Teilwoche'), piece_rcpt_wd6_val
OPTIONS(description='KPI Stuckbon für Tag_1 6 der Teilwoche'), piece_rcpt_wd7_val
OPTIONS(description='KPI Stuckbon für Tag_1 7 der Teilwoche'), piece_rcpt_wktd_val OPTIONS(description='KPI Stuckbon WTD'),
piece_rcpt_mtd_val OPTIONS(description='Kumulative Summe KPI Stuckbon MTD'), piece_rcpt_bytd_val
OPTIONS(description='Kumulative Summe KPI Stuckbon YTD'), prev1y_piece_rcpt_wktd_val
OPTIONS(description='KPI Stuckbon PYWTD'), prev1y_piece_rcpt_mtd_val
OPTIONS(description='Kumulative Summe KPI Stuckbon Vorjahr MTD'), prev1y_piece_rcpt_bytd_val
OPTIONS(description='Kumulative Summe KPI Stuckbon Vorjahr YTD'))
OPTIONS(DESCRIPTION = `STUECKBON (AVG PIECE RECEIPT) FOR FILIALE COCKPIT`) AS SELECT client_id,
 loc_sid_store_move_to,
 currency_iso_cd,
 busyear,
 cy_month,
 cy_week_partial_week_id,
 piece_rcpt_wd1_val,
 piece_rcpt_wd2_val,
 piece_rcpt_wd3_val,
 piece_rcpt_wd4_val,
 piece_rcpt_wd5_val,
 piece_rcpt_wd6_val,
 piece_rcpt_wd7_val,
 piece_rcpt_wktd_val,
 piece_rcpt_mtd_val,
 piece_rcpt_bytd_val,
 prev1y_piece_rcpt_wktd_val,
 prev1y_piece_rcpt_mtd_val,
 prev1y_piece_rcpt_bytd_val
FROM ldl_p_lew_mart_lead.t_agg_piece_rcpt_str_wk_1;