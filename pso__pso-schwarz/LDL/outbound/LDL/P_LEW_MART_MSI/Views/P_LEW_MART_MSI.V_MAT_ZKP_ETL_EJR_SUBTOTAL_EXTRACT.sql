/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_SUBTOTAL_EXTRACT
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  27.07.2023    Wandtke,Andrzej          AP0177530: add column timestamp_begin_ejr
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_subtotal_extract AS SELECT STTL.store_id,
 STTL.client_id,
 STTL.pos_terminal_id,
 STTL.dat_formdate,
 STTL.time_receipt_ejr,
 STTL.orig_receipt_nr_ejr,
 STTL.orig_receipt_serial_nr_ejr,
 STTL.timezone_cd,
 STTL.dat_dayend,
 STTL.checker_id,
 STTL.transactiontype_id,
 STTL.authority_id,
 STTL.load_id,
 STTL.timestamp_begin_ejr
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal AS STTL
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS SST ON STTL.client_id = SST.client_id AND
    STTL.store_id = SST.store_id AND STTL.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON STTL.dat_formdate = REVDAY.dat_calendar;