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
#   1.1            07.01.2022        Lin, Ao            	  Adding new column item_familygroup_id_lago
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_gen_item_asis_2 (
client_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
item_sid_config BIGNUMERIC(38,0),
orig_item_nr INTEGER,
orig_item_nr_int INTEGER,
item_familygroup_id BIGNUMERIC(38,0),
item_familygroup_id_lago BIGNUMERIC(38,0),
subitemgroup_id BIGNUMERIC(38,0),
int_subitemgroup_id BIGNUMERIC(38,0),
item_actiongroup_id BIGNUMERIC(38,0),
item_sub_actiongroup_id BIGNUMERIC(38,0),
case_size BIGNUMERIC(38,0),
case_size_lago BIGNUMERIC(38,0),
src_country_lidl_cd STRING(20),
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
unitsize STRING(100) COLLATE 'und:ci',
vat_id BIGNUMERIC(38,0),
smallest_unit STRING(10) COLLATE 'und:ci',
weight_fg INTEGER,
dangerous_goods_fg BIGNUMERIC(38,0),
dwh_updated DATETIME,
dwh_created DATETIME,
dwh_load_id BIGNUMERIC(38,0)
);