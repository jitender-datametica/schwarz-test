/* --------------------------------------------------------------------------------
   DDL for table: t_dim_sales_channel_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SALES_CHANNEL_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   sales_channel_cd                    VARCHAR(100)     NOT NULL COMMENT 'Code for the sales_2 channel.',
   sales_channel_name                  VARCHAR(100)     NOT NULL COMMENT 'Name of the sales_2 channel, like retail store or online shop.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_SALES_CHANNEL PRIMARY KEY (sales_channel_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the different sales_2 channels like retail and online shop.
             NFPOW: CORE_REL.T_SALES_CHANNEL_2';

