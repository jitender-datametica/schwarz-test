/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_msi_sys_revision_request
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_sys_revision_request (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0),
requesting_user STRING(100) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_user STRING(100) COLLATE 'und:ci',
approval_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
timestamp_approval DATETIME,
dat_formdate_from DATE NOT NULL,
dat_formdate_until DATE NOT NULL,
void_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
deposit_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
return_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
aborted_suspended_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
discount_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
other_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
revision_test_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
);