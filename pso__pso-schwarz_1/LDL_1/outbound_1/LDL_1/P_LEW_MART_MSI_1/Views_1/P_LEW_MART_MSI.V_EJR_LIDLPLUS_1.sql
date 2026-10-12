/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LIDLPLUS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lidlplus_1 (client_id, store_id, pos_terminal_id, time_receipt_ejr,
dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, lidlplus_customer_cd, lidlplus_ident_type_cd, val_retail_ejr) AS
SELECT OW.client_id,
 OW.store_id,
 OW.pos_terminal_id,
 OW.time_receipt_ejr,
 OW.dat_formdate,
 OW.orig_receipt_nr_ejr,
 WH.src_wh_id AS wh_id,
 OW.checker_id,
 OW.lidlplus_customer_cd,
 OW.lidlplus_ident_type_cd,
 OW.val_retail_ejr
FROM ldl_p_lew_mart_msi.t_msi_ejr_rel_lidlplus_1 AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON OW.client_id = WH.client_id AND OW.wh_id = WH.src_wh_id AND WH.dwh_actual_fg
    = 1;