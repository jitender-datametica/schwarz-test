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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_cs_map_client (
client_id BIGNUMERIC(38,0) NOT NULL,
cs_lang_id BIGNUMERIC(38,0) NOT NULL,
cs_client_id BIGNUMERIC(38,0) NOT NULL,
cs_parent_client_id BIGNUMERIC(38,0) NOT NULL,
cs_country_id BIGNUMERIC(38,0) NOT NULL
);