CREATE TABLE P_LEW_CORE.T_SPACEMAN_ITEM_HIST (
   int_org_sid                         NUMBER(38,0)     COMMENT 'surrogate key internal organisation',
   spaceman_item_sid                   NUMBER(38,0)     NOT NULL COMMENT 'surrogate key spaceman item',
   spaceman_item_nr                    VARCHAR(100)     COMMENT 'identifier of the spaceman item in the source system together with activer_from_dt
            spaceman: UPC',
   src_case_size                       NUMBER(38,5)     COMMENT 'case size of the item in spaceman, this might be different than the casesize in WAWI',
   spaceman_item_name                  VARCHAR(100)     COMMENT 'name of the item in spaceman
            spaceman:tblapproducts:NAME',
   spaceman_item_grp_sid               NUMBER(38,0)     COMMENT 'surrogate key: item group of the item in the space management
            spaceman:tblapproducts:EXTDESC28',
   spaceman_item_segment_sid           NUMBER(38,0)     COMMENT 'surrogate key_ item segment definition in space management
            spaceman:tblapproducts:DESCJ',
   case_item_orientation_txt           VARCHAR(1000)    COMMENT 'How the product is viewed (e.g., from front, top, side) in a case. 
            spaceman:tblapproducts:EXTDESC27',
   case_orientation_side_end_fg        NUMBER(38,0)     COMMENT 'this flag indicates whether the side-end orientation is allowed for this case/ item in a shelf
            spaceman:tblapproducts: EXTMEAS104',
   case_orientation_front_end_fg       NUMBER(38,0)     COMMENT 'this flag indicates whether the front-end orientation is allowed for this case/ item in a shelf
            spaceman:tblapproducts:EXTMEAS101',
   case_orientation_end_side_fg        NUMBER(38,0)     COMMENT 'this flag indicates whether the end-side orientation is allowed for this case/ item in a shelf
            spaceman:tblapproducts:EXTMEAS106',
   case_orientation_end_front_fg       NUMBER(38,0)     COMMENT 'this flag indicates whether the end-front orientation is allowed for this case/ item in a shelf
            spaceman:tblapproducts:EXTMEAS105',
   uom_sid_size                        NUMBER(38,0)     COMMENT 'Surrogate Key UNIT OF MEASUREMENT',
   uom_cd_size                         VARCHAR(20)      COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
            here inch for USA, cm for all other countries
            spaceman:tblapproducts:',
   item_width_meas                     NUMBER(38,5)     COMMENT 'PRODUCTWIDTH in the unit given in uom_cd_size
            spaceman:tblapproducts:PRODUCTWIDTH',
   item_hight_meas                     NUMBER(38,5)     COMMENT 'PRODUCTHIGH in the unit given in uom_cd_size
            spaceman:tblapproducts:PRODUCTHIGH',
   item_depth_meas                     NUMBER(38,5)     COMMENT 'PRODUCTDEPTH in the unit given in uom_cd_size
            spaceman:tblapproducts:PRODUCTDEPTH',
   case_width_meas                     NUMBER(38,5)     COMMENT 'CASEWIDTH in the unit given in uom_cd_size
            spaceman:tblapproducts:CASEWIDTH',
   case_high_meas                      NUMBER(38,5)     COMMENT 'CASEHIGH in the unit given in uom_cd_size
            spaceman:tblapproducts:CASEHIGH',
   case_depth_meas                     NUMBER(38,5)     COMMENT 'CASEDEPTH in the unit given in uom_cd_size
            spaceman:tblapproducts:CASEDEPTH
            ',
   case_weight_kg_qty                  NUMBER(38,5)     COMMENT 'Weight of case in kg
            spaceman:tblapproducts:CASEWEIGHT',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SPACEMAN_ITEM_HIST PRIMARY KEY (spaceman_item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'this table contains the set of items defined in the spaceman database (historised version)';