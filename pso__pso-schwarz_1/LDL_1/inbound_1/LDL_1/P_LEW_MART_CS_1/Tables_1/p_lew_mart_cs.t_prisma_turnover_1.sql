/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_turnover_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/
CREATE TABLE p_lew_mart_cs.t_prisma_turnover_1
(
client_id NUMBER(38) NOT NULL,
orig_store_nr NUMBER(38) NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd VARCHAR(20) COLLATE 'en-ci',
val_retail_asis DECIMAL(25,11) NOT NULL,
val_retail_net_asis DECIMAL(25,11) NOT NULL,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL
);
