CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_QUOTATION (
   mdm_item_quotation_sid                   COMMENT 'Surrogate key of the item quotation.
CBX: CNT_VQ.REF_NO'
  ,src_item_quotation_nr                    COMMENT 'Identifier of the item quotation in the source system.
CBX: CNT_VQ.REF_NO'
  ,mdm_item_sid                             COMMENT 'Surrogate key NFPO item instance.
CBX: CNT_VQ.ITEM_REF'
  ,mdm_sup_sid                              COMMENT 'Surrogate key NFPO supplier.
CBX: CNT_VQ.VENDOR_REF'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains information about quotations for items provided by suppliers.
CBX: CNT_VQ'
AS SELECT
   mdm_item_quotation_sid
  ,src_item_quotation_nr
  ,mdm_item_sid
  ,mdm_sup_sid
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_QUOTATION
;