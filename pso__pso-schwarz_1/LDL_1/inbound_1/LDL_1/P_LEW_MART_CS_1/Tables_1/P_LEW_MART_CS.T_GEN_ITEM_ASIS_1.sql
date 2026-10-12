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


CREATE TABLE P_LEW_MART_CS.T_GEN_ITEM_ASIS_1 (
	client_id NUMBER(38,0),
	item_sid NUMBER(38,0),
	item_sid_config NUMBER(38,0),
	orig_item_nr NUMBER(18,0),
	orig_item_nr_int NUMBER(9,0),
	item_familygroup_id NUMBER(38,0),
	item_familygroup_id_lago NUMBER(38,0),
	subitemgroup_id NUMBER(38,0),
	int_subitemgroup_id NUMBER(38,0),
	item_actiongroup_id NUMBER(38,0),
	item_sub_actiongroup_id NUMBER(38,0),
	case_size NUMBER(38,0),
	case_size_lago NUMBER(38,0),
	src_country_lidl_cd VARCHAR(20),
	valid_from DATE,
	valid_until DATE,
	buying_employee_skey NUMBER(38,0),
	buying_employee_name VARCHAR(100) COLLATE 'en-ci',
	brand_name VARCHAR(100) COLLATE 'en-ci',
	itemstatus_cd NUMBER(38,0),
	packagetype_desc VARCHAR(35) COLLATE 'en-ci',
	case_euro NUMBER(18,5),
	case_plu_fg NUMBER(38,0),
	plu_nr NUMBER(38,0),
	buying_list_type_id NUMBER(38,0),
	unitsize VARCHAR(100) COLLATE 'en-ci',
	vat_id NUMBER(38,0),
	smallest_unit VARCHAR(10) COLLATE 'en-ci',
	weight_fg NUMBER(10,0),
	dangerous_goods_fg NUMBER(38,0),
	dwh_updated TIMESTAMP_NTZ(6),
	dwh_created TIMESTAMP_NTZ(6),
	dwh_load_id NUMBER(38,0)
);