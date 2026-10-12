/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_order_sales_status_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:20:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_ORDER_SALES_STATUS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_order_sales_status_id     NUMBER(38,0)     NOT NULL,
   nfpo_item_order_sales_status_descr  VARCHAR(250),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_ORDER_SALES_STATUS PRIMARY KEY (nfpo_item_order_sales_status_id) NOT ENFORCED 
)  COMMENT = 'Comment 2Do
             States:
             1 - not ordered, not in sales_1
             2 - ordered, not in sales_1
             3 - ordered, in sales_1
             4 - not ordered, in sales_1';
