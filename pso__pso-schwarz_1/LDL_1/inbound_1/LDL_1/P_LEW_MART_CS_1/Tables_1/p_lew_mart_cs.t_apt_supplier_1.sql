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


CREATE TABLE p_lew_mart_cs.t_apt_supplier_1
     (
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
orig_supplier_nr NUMBER(38) NOT NULL,
valid_from DATE,
valid_until DATE,
sup_name VARCHAR(200) COLLATE 'en-ci',
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;


