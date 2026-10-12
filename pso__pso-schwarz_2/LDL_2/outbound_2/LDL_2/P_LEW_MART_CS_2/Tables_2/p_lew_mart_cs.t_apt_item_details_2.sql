/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_apt_item_details_2
#----------------------------------------------------------------------------
# History:
#   1.0            15.03.2021        Oguzhan Guenes            checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#   1.4            16.08.2022        Ross, Uli                User Story 363377
#                                                             Add column weight_fg
#   1.5            11.06.2024        Ross, Uli                User Story 635594
#                                                             Add column brand_type_desc
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_apt_item_details_2 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
org_item_nr BIGNUMERIC(38) NOT NULL,
valid_from_item DATE NOT NULL,
case_size BIGNUMERIC(38) NOT NULL,
buying_emp_nat_name STRING(200) COLLATE 'und:ci',
dat_rec_start DATE,
dat_rec_end DATE,
brand_name STRING(200) COLLATE 'und:ci',
itemlistingtype_cd BIGNUMERIC(38),
vat_no BIGNUMERIC(38),
packageunit_size STRING(100) COLLATE 'und:ci',
packageunit_type STRING(100) COLLATE 'und:ci',
packagetype_descr STRING(100) COLLATE 'und:ci',
palletfactor_euro NUMERIC(18,5),
int_item_nr INTEGER,
itemstatus_cd BIGNUMERIC(38),
weight_fg INTEGER NOT NULL,
brand_type_desc STRING(10) COLLATE 'und:ci',
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);