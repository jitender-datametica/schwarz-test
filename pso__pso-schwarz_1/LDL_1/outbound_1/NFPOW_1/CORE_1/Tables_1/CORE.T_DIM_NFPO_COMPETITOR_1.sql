/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_competitor_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_competitor_1 (
nfpo_competitor_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate Key COMPETITOR.
            CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SID'''),
nfpo_competitor_cd STRING(100) NOT NULL
OPTIONS(description='''Unified abbreviation of the competitor.
            CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.SRC_COMPETITOR_CD'''),
nfpo_competitor_name STRING(100)
OPTIONS(description='''Competitor name.
            CBX: CTM_CODELIST.CUST_TEXT1 (code list \'LIDL_COMPET\')
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_NAME'''),
nfpo_competitor_abbr_name STRING(100)
OPTIONS(description='''Abbreviated competitor name.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_COMPET\')
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SHORT_NAME'''),
is_competitor_1_fg BOOL OPTIONS(description='Iindicates whether this competitor is used as competitor 1 for any item_1'),
is_competitor_2_fg BOOL OPTIONS(description='Iindicates whether this competitor is used as competitor 2 for any item_1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_COMPETITOR.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_competitor_sid) NOT ENFORCED
)
OPTIONS(description='''List of retail companies regarded as competitors.
             CBX: Codelist LIDL_COMPET
             LDL: P_LEW_CORE.T_MDM_COMPETITOR_1''');