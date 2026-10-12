/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_order_month_list_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ORDER_MONTH_LIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_order_month_list_txt           VARCHAR(1000)    NOT NULL,
   nfpo_order_month_name_list_txt      VARCHAR(1000),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ORDER_MONTH_LIST PRIMARY KEY (nfpo_order_month_list_txt) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';

