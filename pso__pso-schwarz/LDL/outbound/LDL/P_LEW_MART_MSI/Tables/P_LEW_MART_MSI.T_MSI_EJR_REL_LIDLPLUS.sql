/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_REL_LIDLPLUS
#----------------------------------------------------------------------------
# History:
#  1.0  27.03.2024    Szewczyk,Milosz		AP0188368: ZKP Lidlplus
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_rel_lidlplus (
client_id BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
dat_formdate DATE,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
lidlplus_customer_cd STRING(32),
lidlplus_ident_type_cd STRING(3),
val_retail_ejr BIGNUMERIC(38,4)
);