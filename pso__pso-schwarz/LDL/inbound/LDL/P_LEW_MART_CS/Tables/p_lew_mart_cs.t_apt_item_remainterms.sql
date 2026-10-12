/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            15.03.2021        Oguzhan Gunes            checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_cs.t_apt_item_remainterms
     (
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
item_nr_nat NUMBER(38) NOT NULL,
valid_from DATE NOT NULL,
case_size NUMBER(38) NOT NULL,
dat_rec_start DATE,
dat_rec_end DATE,
remain_period_cd_wh VARCHAR(10) COLLATE 'en-ci',
remain_term_value_wh NUMBER(18,5),
remain_period_cd_store VARCHAR(10) COLLATE 'en-ci',
remain_term_value_store NUMBER(18,5),
remain_period_cd_customer VARCHAR(10) COLLATE 'en-ci',
remain_term_value_customer NUMBER(18,5),
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;


