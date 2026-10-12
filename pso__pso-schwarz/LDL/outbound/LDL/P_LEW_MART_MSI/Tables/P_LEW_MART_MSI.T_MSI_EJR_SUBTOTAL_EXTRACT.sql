/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_SUBTOTAL_EXTRACT 
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  27.07.2023    Wandtke,Andrzej          AP0177530: add column timestamp_begin_ejr
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_subtotal_extract (
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
pos_terminal_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
time_receipt_ejr TIME NOT NULL,
orig_receipt_nr_ejr BIGNUMERIC(38,0) NOT NULL,
orig_receipt_serial_nr_ejr BIGNUMERIC(38,0) NOT NULL,
timezone_cd BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
checker_id BIGNUMERIC(38,0) NOT NULL,
transactiontype_id STRING(3) COLLATE 'und:ci' NOT NULL,
authority_id STRING(40) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL,
timestamp_begin_ejr DATETIME
) CLUSTER BY st_loc_sid;