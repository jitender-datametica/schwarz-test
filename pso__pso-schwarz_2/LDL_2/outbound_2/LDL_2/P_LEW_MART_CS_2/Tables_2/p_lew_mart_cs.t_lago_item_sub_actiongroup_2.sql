/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_lago_item_sub_actiongroup_2
#----------------------------------------------------------------------------
# History:
#   1.0            18.06.2021        Ulrich Ross              checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_lago_item_sub_actiongroup_2 (
client_id BIGNUMERIC(38) NOT NULL,
item_actiongroup_id BIGNUMERIC(38) NOT NULL,
item_sub_actiongroup_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
item_actiongroup_descr STRING(200) COLLATE 'und:ci',
item_sub_actiongroup_descr STRING(200) COLLATE 'und:ci',
language_id BIGNUMERIC(38) NOT NULL,
last_refresh DATETIME NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);