/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.t_msi_ejr_show_price_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder: is_kleinstbon_man & is_abmeld_man
#  1.8  08.02.2022    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PR_SHOW_ORIG_RECEIPT_NR_EJR: receipt number of show price operation. For price series it marks end of series, otherwise equal to orig_receipt_nr_ejr
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_show_price_1 (
orig_receipt_nr_ejr BIGNUMERIC(38,0),
pr_show_orig_receipt_nr_ejr BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
dat_formdate DATE,
pos_terminal_id BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
checker_id BIGNUMERIC(38,0),
next_val_retail_ejr NUMERIC(18,4),
val_retail_ejr NUMERIC(18,4),
next_orig_receipt_nr_ejr BIGNUMERIC(38,0),
next_time_receipt_ejr TIME,
transactiontype_id STRING(3) COLLATE 'und:ci',
next_transactiontype_id STRING(3) COLLATE 'und:ci',
rank_login_nr BIGNUMERIC(38,0),
is_kleinstbon BIGNUMERIC(38,0),
is_abmeldung BIGNUMERIC(38,0),
is_show_price_series BIGNUMERIC(38,0),
cnt_same_transactiontype BIGNUMERIC(38,0),
is_kleinstbon_man BIGNUMERIC(38,0),
is_abmeld_man BIGNUMERIC(38,0)
);