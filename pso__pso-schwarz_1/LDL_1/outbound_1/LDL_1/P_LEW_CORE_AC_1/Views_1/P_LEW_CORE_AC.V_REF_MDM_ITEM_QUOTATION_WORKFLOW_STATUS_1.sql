CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_quotation_workflow_status_1 (mdm_item_quotation_workflow_status_cd
OPTIONS(description='''Code for the steps of the workflow for item_1 quotations.
CBX: CNT_VQ.STATUS_1'''),
mdm_item_quotation_workflow_status_descr
OPTIONS(description='Description for the steps of the workflow for item_1 quotations.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''NFPO supplier_1 related quotation workflow steps.
Manually filled values derived from: CBX: CNT_VQ.STATUS_1''')
AS SELECT mdm_item_quotation_workflow_status_cd,
 mdm_item_quotation_workflow_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_quotation_workflow_status_1;