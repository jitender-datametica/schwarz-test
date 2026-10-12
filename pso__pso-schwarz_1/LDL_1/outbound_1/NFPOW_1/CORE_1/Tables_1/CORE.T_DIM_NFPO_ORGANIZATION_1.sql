/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_organization_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:55:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_organization_1 (
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'''),
nfpo_org_nr STRING(100) NOT NULL
OPTIONS(description='''Identifier of the internal organization in the source system.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NR'''),
nfpo_org_name STRING(100)
OPTIONS(description='''Name of the internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NAME'''),
nfpo_org_descr STRING(250)
OPTIONS(description='''Description of the internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_DESCR'''),
nfpo_map_country_name STRING(100) NOT NULL
OPTIONS(description='derived from nfpo_org_name in a case statement to visualize data on a map'),
lob_cd STRING(100) NOT NULL
OPTIONS(description='Code of the line of business, so far LDL and KFL are used for Lidl and Kaufland.'),
lob_name STRING(100) NOT NULL OPTIONS(description='Name of the line of business.'),
sales_channel_cd STRING(100) NOT NULL OPTIONS(description='Numeric code ID for the sales_1 channel.'),
sales_channel_name STRING(100) NOT NULL
OPTIONS(description='Name of the sales_1 channel, like retail store or online shop.'),
display_seq BIGNUMERIC(38,0)
OPTIONS(description='''Defines the order of NFPO\'s in reports.
            CBX: CNT_CODELIST.seq_no (code list \'LIDL_COUNTRY\')
            LDL: P_LEW_CORE.T_NFPO_ORGANISATION_HIST.DISPLAY_SEQ'''),
active_fg BOOL
OPTIONS(description='''Indicates whether an NFPO is no longer usable in the system.
            CBX: CNT_CODELIST.disabled (code list \'LIDL_COUNTRY\')
            LDL: P_LEW_CORE.T_NFPO_ORGANISATION_HIST.ACTIVE_FG'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_sid) NOT ENFORCED
)
OPTIONS(description='''This table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organizational units like client, store or warehouse. It contains organization types on a level comparable to country_1 or client, but having different business backgrounds and therefore different details.
             LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION_1''');