CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_standard_property_item_hist (mdm_item_sid
OPTIONS(description='''foreign key NFPO item instance
CBX: LDL_ITEM_CERTIFICATION.ITEM_ID'''),
mdm_item_standard_property_cd
OPTIONS(description='''Code of the standardized item properties.
CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'''),
mdm_item_standard_property_class_cd
OPTIONS(description='''Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties.
CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
"HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'''),
deleted_fg
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''The table contains information about standardized additional properties of NFPO items.
CBX: LDL_ITEM_CERTIFICATION''')
AS SELECT mdm_item_sid,
 mdm_item_standard_property_cd,
 mdm_item_standard_property_class_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_standard_property_item_hist;