/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_organization_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:55:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ORGANIZATION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   nfpo_org_nr                         VARCHAR(100)     NOT NULL COMMENT 'Identifier of the internal organization in the source system.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NR',
   nfpo_org_name                       VARCHAR(100)     COMMENT 'Name of the internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NAME',
   nfpo_org_descr                      VARCHAR(250)     COMMENT 'Description of the internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_DESCR',
   nfpo_map_country_name               VARCHAR(100)     NOT NULL COMMENT 'derived from nfpo_org_name in a case statement to visualize data on a map',
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Code of the line of business, so far LDL and KFL are used for Lidl and Kaufland.',
   lob_name                            VARCHAR(100)     NOT NULL COMMENT 'Name of the line of business.',
   sales_channel_cd                    VARCHAR(100)     NOT NULL COMMENT 'Numeric code ID for the sales_1 channel.',
   sales_channel_name                  VARCHAR(100)     NOT NULL COMMENT 'Name of the sales_1 channel, like retail store or online shop.',
   display_seq                         NUMBER(38,0)     COMMENT 'Defines the order of NFPO''s in reports.
            CBX: CNT_CODELIST.seq_no (code list ''LIDL_COUNTRY'')
            LDL: P_LEW_CORE.T_NFPO_ORGANISATION_HIST.DISPLAY_SEQ',
   active_fg                           BOOLEAN          COMMENT 'Indicates whether an NFPO is no longer usable in the system.
            CBX: CNT_CODELIST.disabled (code list ''LIDL_COUNTRY'')
            LDL: P_LEW_CORE.T_NFPO_ORGANISATION_HIST.ACTIVE_FG',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ORGANIZATION PRIMARY KEY (nfpo_org_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organizational units like client, store or warehouse. It contains organization types on a level comparable to country_1 or client, but having different business backgrounds and therefore different details.
             LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION_1';
