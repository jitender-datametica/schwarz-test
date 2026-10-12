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

CREATE TABLE P_LEW_MART_CS.T_APT_ITEM_FAMILYGRP_ITEM_REL
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
org_item_nr NUMBER(38) NOT NULL,
valid_from DATE NOT NULL,
case_size NUMBER(38) NOT NULL,
dat_rec_start DATE,
dat_rec_end DATE,
item_familygroup_id NUMBER(38),
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/*** MSC-WARNING - MSCEWI2008 - PERFORMANCE REVIEW - CLUSTER BY ***/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 ,
NO RANGE))*/;

