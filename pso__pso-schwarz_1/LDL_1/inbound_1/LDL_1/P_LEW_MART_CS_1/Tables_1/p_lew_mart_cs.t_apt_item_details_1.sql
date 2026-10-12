/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_apt_item_details_1
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

CREATE TABLE p_lew_mart_cs.t_apt_item_details_1 (
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
org_item_nr NUMBER(38) NOT NULL,
valid_from_item DATE NOT NULL,
case_size NUMBER(38) NOT NULL,
buying_emp_nat_name VARCHAR(200) COLLATE 'en-ci',
dat_rec_start DATE,
dat_rec_end DATE,
brand_name VARCHAR(200) COLLATE 'en-ci',
itemlistingtype_cd NUMBER(38),
vat_no NUMBER(38),
packageunit_size VARCHAR(100) COLLATE 'en-ci',
packageunit_type VARCHAR(100) COLLATE 'en-ci',
packagetype_descr VARCHAR(100) COLLATE 'en-ci',
palletfactor_euro DECIMAL(18,5),
int_item_nr BIGINT,
itemstatus_cd NUMBER(38),
weight_fg NUMBER(1,0) NOT NULL,
brand_type_desc VARCHAR(10) COLLATE 'en-ci',
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
;