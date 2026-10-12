CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_item_hist (
int_org_sid BIGNUMERIC(38,0) OPTIONS(description='surrogate key internal organisation'),
spaceman_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key spaceman item'),
spaceman_item_nr STRING(100)
OPTIONS(description='identifier of the spaceman item in the source system together with activer_from_dt            spaceman: UPC'),
src_case_size BIGNUMERIC(38,5)
OPTIONS(description='case size of the item in spaceman, this might be different than the casesize in WAWI'),
spaceman_item_name STRING(100)
OPTIONS(description='name of the item in spaceman            spaceman:tblapproducts:NAME'),
spaceman_item_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key: item group of the item in the space management            spaceman:tblapproducts:EXTDESC28'),
spaceman_item_segment_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key_ item segment definition in space management            spaceman:tblapproducts:DESCJ'),
case_item_orientation_txt STRING(1000)
OPTIONS(description='How the product is viewed (e.g., from front, top, side) in a case.             spaceman:tblapproducts:EXTDESC27'),
case_orientation_side_end_fg BIGNUMERIC(38,0)
OPTIONS(description='this flag indicates whether the side-end orientation is allowed for this case/ item in a shelf            spaceman:tblapproducts: EXTMEAS104'),
case_orientation_front_end_fg BIGNUMERIC(38,0)
OPTIONS(description='this flag indicates whether the front-end orientation is allowed for this case/ item in a shelf            spaceman:tblapproducts:EXTMEAS101'),
case_orientation_end_side_fg BIGNUMERIC(38,0)
OPTIONS(description='this flag indicates whether the end-side orientation is allowed for this case/ item in a shelf            spaceman:tblapproducts:EXTMEAS106'),
case_orientation_end_front_fg BIGNUMERIC(38,0)
OPTIONS(description='this flag indicates whether the end-front orientation is allowed for this case/ item in a shelf            spaceman:tblapproducts:EXTMEAS105'),
uom_sid_size BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key UNIT OF MEASUREMENT'),
uom_cd_size STRING(20)
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode            here inch for USA, cm for all other countries            spaceman:tblapproducts:'),
item_width_meas BIGNUMERIC(38,5)
OPTIONS(description='PRODUCTWIDTH in the unit given in uom_cd_size            spaceman:tblapproducts:PRODUCTWIDTH'),
item_hight_meas BIGNUMERIC(38,5)
OPTIONS(description='PRODUCTHIGH in the unit given in uom_cd_size            spaceman:tblapproducts:PRODUCTHIGH'),
item_depth_meas BIGNUMERIC(38,5)
OPTIONS(description='PRODUCTDEPTH in the unit given in uom_cd_size            spaceman:tblapproducts:PRODUCTDEPTH'),
case_width_meas BIGNUMERIC(38,5)
OPTIONS(description='CASEWIDTH in the unit given in uom_cd_size            spaceman:tblapproducts:CASEWIDTH'),
case_high_meas BIGNUMERIC(38,5)
OPTIONS(description='CASEHIGH in the unit given in uom_cd_size            spaceman:tblapproducts:CASEHIGH'),
case_depth_meas BIGNUMERIC(38,5)
OPTIONS(description='CASEDEPTH in the unit given in uom_cd_size            spaceman:tblapproducts:CASEDEPTH            '),
case_weight_kg_qty BIGNUMERIC(38,5)
OPTIONS(description='Weight of case in kg            spaceman:tblapproducts:CASEWEIGHT'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (spaceman_item_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='this table contains the set of items defined in the spaceman database (historised version)');