/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_sentiment_1
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:12:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_SENTIMENT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sentiment_cd                   VARCHAR(100)     NOT NULL,
   nfpo_sentiment_name                 VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_SENTIMENT PRIMARY KEY (nfpo_sentiment_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the classes of sentiments. Sentiments ''positive'' and ''negative'' are used in this context.';
