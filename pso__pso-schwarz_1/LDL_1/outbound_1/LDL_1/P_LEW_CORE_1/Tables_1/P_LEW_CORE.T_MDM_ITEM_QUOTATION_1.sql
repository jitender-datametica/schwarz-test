/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_quotation_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:39:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_quotation_1 (
mdm_item_quotation_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the item_1 quotation.            CBX: CNT_VQ.REF_NO'),
src_item_quotation_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_1 quotation in the source system.            CBX: CNT_VQ.REF_NO'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key NFPO item_1 instance.            CBX: CNT_VQ.ITEM_REF'),
mdm_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key NFPO supplier.            CBX: CNT_VQ.VENDOR_REF'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_quotation_sid) NOT ENFORCED
)
OPTIONS(description='This table contains information about quotations for items provided by suppliers.             CBX: CNT_VQ');