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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_gen_item_hist (
client_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
item_sid_config BIGNUMERIC(38,0),
orig_item_nr INTEGER,
orig_item_nr_int INTEGER,
item_familygroup_id BIGNUMERIC(38,0),
subitemgroup_id BIGNUMERIC(38,0),
int_subitemgroup_id BIGNUMERIC(38,0),
item_actiongroup_id BIGNUMERIC(38,0),
item_sub_actiongroup_id BIGNUMERIC(38,0),
case_size BIGNUMERIC(38,0),
src_country_lidl_cd STRING(20),
language_iso_cd STRING(20),
valid_from DATE,
valid_until DATE,
buying_employee_skey BIGNUMERIC(38,0),
buying_employee_name STRING(100) COLLATE 'und:ci',
brand_name STRING(100) COLLATE 'und:ci',
itemstatus_cd BIGNUMERIC(38,0),
packagetype_desc STRING(35) COLLATE 'und:ci',
case_euro NUMERIC(18,5),
case_plu_fg BIGNUMERIC(38,0),
plu_nr BIGNUMERIC(38,0),
buying_list_type_id BIGNUMERIC(38,0),
buying_list_type_desc STRING(100) COLLATE 'und:ci',
unitsize STRING(100) COLLATE 'und:ci',
vat_id BIGNUMERIC(38,0),
smallest_unit STRING(10) COLLATE 'und:ci',
weight_fg INTEGER,
dangerous_goods_fg BIGNUMERIC(38,0),
deleted_fg BIGNUMERIC(38,0),
dwh_updated DATETIME,
dwh_created DATETIME,
dwh_load_id BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0),
src_id BIGNUMERIC(38,0)
);