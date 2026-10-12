/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_rating_bias_type_1
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:10:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_rating_bias_type_1 (
nfpo_rating_bias_type_cd STRING(100) NOT NULL,
nfpo_rating_bias_type_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_rating_bias_type_cd) NOT ENFORCED
)
OPTIONS(description='This table contains bias types of ratings from different sources. If the source is classified as\'neutral\', then\'unbiased\' is used, if the source is a CRM system which mainly is used to handle customer complaints, then\'complaint\' is used.');