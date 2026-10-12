/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_sentiment
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:12:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_sentiment (
nfpo_sentiment_cd STRING(100) NOT NULL,
nfpo_sentiment_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_sentiment_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the classes of sentiments. Sentiments\'positive\' and\'negative\' are used in this context.');