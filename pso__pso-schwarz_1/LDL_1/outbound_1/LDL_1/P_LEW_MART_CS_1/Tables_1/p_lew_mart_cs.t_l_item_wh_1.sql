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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_l_item_wh_1 (
client_id INTEGER NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
itemstatus_cd BIGNUMERIC(38),
case_factor_dd INTEGER,
case_factor_euro INTEGER,
case_factor_layer INTEGER,
min_case_dd_wh INTEGER,
min_case_euro_wh INTEGER,
min_case_layer_wh INTEGER,
min_case_wh INTEGER,
min_orderunit INTEGER,
order_area_cd STRING(10) COLLATE 'und:ci',
last_refresh DATETIME,
src_id BIGNUMERIC(38),
load_id BIGNUMERIC(38)
);