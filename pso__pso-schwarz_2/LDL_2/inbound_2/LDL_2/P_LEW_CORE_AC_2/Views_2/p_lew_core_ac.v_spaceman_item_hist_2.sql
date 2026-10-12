CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SPACEMAN_ITEM_HIST_2 (
   int_org_sid                              COMMENT 'surrogate key internal organisation'
  ,spaceman_item_sid                        COMMENT 'surrogate key spaceman item_2'
  ,spaceman_item_nr                         COMMENT 'identifier of the spaceman item_2 in the source system together with activer_from_dt
spaceman: UPC'
  ,src_case_size                            COMMENT 'case size of the item_2 in spaceman, this might be different than the casesize in WAWI'
  ,spaceman_item_name                       COMMENT 'name of the item_2 in spaceman
spaceman:tblapproducts:NAME'
  ,spaceman_item_grp_sid                    COMMENT 'surrogate key: item_2 group of the item_2 in the space management
spaceman:tblapproducts:EXTDESC28'
  ,spaceman_item_segment_sid                COMMENT 'surrogate key_ item_2 segment definition in space management
spaceman:tblapproducts:DESCJ'
  ,case_item_orientation_txt                COMMENT 'How the product is viewed (e.g., from front, top, side) in a case. 
spaceman:tblapproducts:EXTDESC27'
  ,case_orientation_side_end_fg             COMMENT 'this flag indicates whether the side-end orientation is allowed for this case/ item_2 in a shelf
spaceman:tblapproducts: EXTMEAS104'
  ,case_orientation_front_end_fg            COMMENT 'this flag indicates whether the front-end orientation is allowed for this case/ item_2 in a shelf
spaceman:tblapproducts:EXTMEAS101'
  ,case_orientation_end_side_fg             COMMENT 'this flag indicates whether the end-side orientation is allowed for this case/ item_2 in a shelf
spaceman:tblapproducts:EXTMEAS106'
  ,case_orientation_end_front_fg            COMMENT 'this flag indicates whether the end-front orientation is allowed for this case/ item_2 in a shelf
spaceman:tblapproducts:EXTMEAS105'
  ,uom_sid_size                             COMMENT 'Surrogate Key UNIT_2 OF MEASUREMENT'
  ,uom_cd_size                              COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
here inch for USA, cm for all other countries
spaceman:tblapproducts:'
  ,item_width_meas                          COMMENT 'PRODUCTWIDTH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:PRODUCTWIDTH'
  ,item_hight_meas                          COMMENT 'PRODUCTHIGH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:PRODUCTHIGH'
  ,item_depth_meas                          COMMENT 'PRODUCTDEPTH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:PRODUCTDEPTH'
  ,case_width_meas                          COMMENT 'CASEWIDTH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:CASEWIDTH'
  ,case_high_meas                           COMMENT 'CASEHIGH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:CASEHIGH'
  ,case_depth_meas                          COMMENT 'CASEDEPTH in the unit_2 given in uom_cd_size
spaceman:tblapproducts:CASEDEPTH
'
  ,case_weight_kg_qty                       COMMENT 'Weight of case in kg
spaceman:tblapproducts:CASEWEIGHT'
  ,deleted_fg                               COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,client_id                                COMMENT 'technical column required by the used ETL framework
static 7 for all rows'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'this table contains the set of items defined in the spaceman database (historised version)'
AS SELECT
   int_org_sid
  ,spaceman_item_sid
  ,spaceman_item_nr
  ,src_case_size
  ,spaceman_item_name
  ,spaceman_item_grp_sid
  ,spaceman_item_segment_sid
  ,case_item_orientation_txt
  ,case_orientation_side_end_fg
  ,case_orientation_front_end_fg
  ,case_orientation_end_side_fg
  ,case_orientation_end_front_fg
  ,uom_sid_size
  ,uom_cd_size
  ,item_width_meas
  ,item_hight_meas
  ,item_depth_meas
  ,case_width_meas
  ,case_high_meas
  ,case_depth_meas
  ,case_weight_kg_qty
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SPACEMAN_ITEM_HIST_2
;