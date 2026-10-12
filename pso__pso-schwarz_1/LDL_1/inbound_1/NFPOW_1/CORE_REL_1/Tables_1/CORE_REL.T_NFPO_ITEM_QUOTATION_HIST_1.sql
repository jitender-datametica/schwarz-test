/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_quotation_hist_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_QUOTATION_HIST_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_quotation_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the item_1 quotation.
            CBX: CNT_VQ.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.MDM_ITEM_QUOTATION_SID',
   nfpo_item_quotation_workflow_status_cd VARCHAR(100)     COMMENT 'Code for the steps of the workflow for item_1 quotations.
            CBX: CNT_VQ.STATUS_1
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.MDM_ITEM_QUOTATION_WORKFLOW_STATUS_CD',
   nfpo_item_quotation_status_cd       VARCHAR(100)     COMMENT 'Status_1 code to describe the general situation of the entity instance in the source system: Values are active, inactive and canceled.
            CBX: CNT_VQ.DOC_STATUS
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.CBX_ITEM_QUOTATION_DOC_STATUS_CD',
   nfpo_shipping_container_20ft_qty    NUMBER(38,5)     COMMENT 'Quantity of standard 20 foot shipping containers to be used to deliver the items.
            CBX: CNT_VQ.FT20_QTY
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_20FT_QTY',
   nfpo_shipping_container_40ft_qty    NUMBER(38,5)     COMMENT 'Quantity of standard 40 foot shipping containers to be used to deliver the items.
            CBX: CNT_VQ.FT40_QTY
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_40FT_QTY',
   nfpo_shipping_container_40ft_hc_qty NUMBER(38,5)     COMMENT 'Quantity of standard 40 foot high cube shipping containers to be used to deliver the items.
            CBX: CNT_VQ.FT40_HC_QTY
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_40FT_HC_QTY',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_QUOTATION_HIST PRIMARY KEY (nfpo_item_quotation_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This table contains information about quotations for items provided by suppliers.
             CBX: CNT_VQ
             LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST_1';

