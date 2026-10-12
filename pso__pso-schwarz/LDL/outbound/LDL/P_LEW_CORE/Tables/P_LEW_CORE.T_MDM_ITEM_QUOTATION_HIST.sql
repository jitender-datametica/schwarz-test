/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_quotation_hist
   generated from Powerdesigner on Montag, 1. Dezember 2025 11:43:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_quotation_hist (
mdm_item_quotation_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the item quotation.            CBX: CNT_VQ.REF_NO'),
mdm_item_quotation_workflow_status_cd STRING(100)
OPTIONS(description='Code for the steps of the workflow for item quotations.            CBX: CNT_VQ.STATUS'),
cbx_item_quotation_doc_status_cd STRING(100)
OPTIONS(description='Status code to describe the general situation of the entity instance in the source system: Values are active, inactive and canceled.            CBX: CNT_VQ.DOC_STATUS'),
shipping_container_20ft_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of standard 20 foot shipping containers to be used to deliver the items.            CBX: CNT_VQ.FT20_QTY'),
shipping_container_40ft_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of standard 40 foot shipping containers to be used to deliver the items.            CBX: CNT_VQ.FT40_QTY'),
shipping_container_40ft_hc_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of standard 40 foot high cube shipping containers to be used to deliver the items.            CBX: CNT_VQ.FT40_HC_QTY'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_quotation_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='This table contains information about quotations for items provided by suppliers.             CBX: CNT_VQ');