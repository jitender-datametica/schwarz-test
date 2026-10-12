/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_turnover
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_prisma_turnover (
client_id BIGNUMERIC(38) NOT NULL,
orig_store_nr BIGNUMERIC(38) NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd STRING(20) COLLATE 'und:ci',
val_retail_asis BIGNUMERIC(25,11) NOT NULL,
val_retail_net_asis BIGNUMERIC(25,11) NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);