CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_quotation (mdm_item_quotation_sid
OPTIONS(description='''Surrogate key of the item quotation.
CBX: CNT_VQ.REF_NO'''), src_item_quotation_nr
OPTIONS(description='''Identifier of the item quotation in the source system.
CBX: CNT_VQ.REF_NO'''), mdm_item_sid
OPTIONS(description='''Surrogate key NFPO item instance.
CBX: CNT_VQ.ITEM_REF'''), mdm_sup_sid
OPTIONS(description='''Surrogate key NFPO supplier.
CBX: CNT_VQ.VENDOR_REF'''), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''This table contains information about quotations for items provided by suppliers.
CBX: CNT_VQ''')
AS SELECT mdm_item_quotation_sid,
 src_item_quotation_nr,
 mdm_item_sid,
 mdm_sup_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_quotation;