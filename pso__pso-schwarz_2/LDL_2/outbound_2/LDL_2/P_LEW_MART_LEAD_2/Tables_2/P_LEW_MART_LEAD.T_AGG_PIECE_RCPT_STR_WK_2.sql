/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_piece_rcpt_str_wk_2
#-------------------------------------------------------------------------------
# History:
#  1.0    2021-07-16         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_piece_rcpt_str_wk_2 (
client_id BIGNUMERIC NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store_move_to BIGNUMERIC NOT NULL OPTIONS(description='S-Key der Location_2, hier der Filiale'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Währung ISO Code'),
busyear BIGNUMERIC NOT NULL OPTIONS(description='Käufer'),
cy_month BIGNUMERIC NOT NULL OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'),
cy_week_partial_week_id BIGNUMERIC NOT NULL
OPTIONS(description='Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche_2'),
piece_rcpt_wd1_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 1 der Teilwoche'),
piece_rcpt_wd2_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 2 der Teilwoche'),
piece_rcpt_wd3_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 3 der Teilwoche'),
piece_rcpt_wd4_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 4 der Teilwoche'),
piece_rcpt_wd5_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 5 der Teilwoche'),
piece_rcpt_wd6_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 6 der Teilwoche'),
piece_rcpt_wd7_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon für Tag_2 7 der Teilwoche'),
piece_rcpt_wktd_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon WTD'),
piece_rcpt_mtd_val BIGNUMERIC(38,8) OPTIONS(description='Kumulative Summe KPI Stuckbon MTD'),
piece_rcpt_bytd_val BIGNUMERIC(38,8) OPTIONS(description='Kumulative Summe KPI Stuckbon YTD'),
prev1y_piece_rcpt_wktd_val BIGNUMERIC(38,8) OPTIONS(description='KPI Stuckbon PYWTD'),
prev1y_piece_rcpt_mtd_val BIGNUMERIC(38,8) OPTIONS(description='Kumulative Summe KPI Stuckbon Vorjahr MTD'),
prev1y_piece_rcpt_bytd_val BIGNUMERIC(38,8) OPTIONS(description='Kumulative Summe KPI Stuckbon Vorjahr YTD')
) CLUSTER BY client_id, cy_month
OPTIONS(description='Stueckbon (Avg Piece Receipt) for Filiale Cockpit');