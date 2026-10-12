/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_LIDLPLUS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_lidlplus_1 (client_id, store_id, pos_terminal_id, time_receipt_ejr,
dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, lidlplus_customer_cd, lidlplus_ident_type_cd, val_retail_ejr) AS
SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_lidlplus_1;