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


/* CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE)) */
/* WARNING: PERFORMANCE REVIEW - CLUSTER BY *** */ CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_apt_item_remainterms_2 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
item_nr_nat BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
case_size BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE,
dat_rec_end DATE,
remain_period_cd_wh STRING(10) COLLATE 'und:ci',
remain_term_value_wh NUMERIC(18,5),
remain_period_cd_store STRING(10) COLLATE 'und:ci',
remain_term_value_store NUMERIC(18,5),
remain_period_cd_customer STRING(10) COLLATE 'und:ci',
remain_term_value_customer NUMERIC(18,5),
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);