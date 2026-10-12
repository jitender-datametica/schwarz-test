CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_sku_hist (mdm_item_sku_sid
OPTIONS(description='''Foreign key NFPO stock keeping unit.
CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE'''),
mdm_item_sku_weight_kg_meas
OPTIONS(description='''Defined weight in kilogramm for the stock keeping unit.
CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT'''),
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
OPTIONS(DESCRIPTION = '''NFPO item sales variants defined by styles, sizes and LSVs.
CBX: LDL_ITEM_ARTICLE_EAN, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE''')
AS SELECT mdm_item_sku_sid,
 mdm_item_sku_weight_kg_meas,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_sku_hist;