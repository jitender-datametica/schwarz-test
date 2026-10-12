/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            23.09.2021        Ulrich Roß               checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_l_store_wh_wawi_2 (
client_id INTEGER NOT NULL,
store_id BIGNUMERIC(38) NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
dwh_type_constant INTEGER NOT NULL,
last_refresh DATETIME,
src_id BIGNUMERIC(38),
load_id BIGNUMERIC(38)
);