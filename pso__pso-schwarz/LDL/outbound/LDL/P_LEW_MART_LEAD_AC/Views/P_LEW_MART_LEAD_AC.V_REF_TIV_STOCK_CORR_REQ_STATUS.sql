/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_STOCK_CORR_REQ_STATUS
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_tiv_stock_corr_req_status (stock_corr_req_status_id
OPTIONS(description='ID DES STATUS DER KORREKTURANFORDERUNG'), stock_corr_req_status_descr
OPTIONS(description='STATUS BESCHREIBUNG'), stock_corr_req_status_descr_en
OPTIONS(description='STATUS BESCHREIBUNG - ENGLISCH'))
OPTIONS(DESCRIPTION = `TIV - STOCK KORREKTURANFORDERUNGEN STATUS`) AS SELECT stock_corr_req_status_id,
 stock_corr_req_status_descr,
 stock_corr_req_status_descr_en
FROM ldl_p_lew_core.t_ref_stock_corr_req_status;