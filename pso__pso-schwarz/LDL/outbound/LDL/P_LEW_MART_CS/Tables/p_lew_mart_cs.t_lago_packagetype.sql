/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_lago_packagetype
#----------------------------------------------------------------------------
# History:
#   1.0            18.06.2021        Ulrich Ross              checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_lago_packagetype (
client_id BIGNUMERIC(38) NOT NULL,
packagetype_skey STRING(20) COLLATE 'und:ci',
language_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
descr STRING(200) COLLATE 'und:ci',
last_refresh DATETIME NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);