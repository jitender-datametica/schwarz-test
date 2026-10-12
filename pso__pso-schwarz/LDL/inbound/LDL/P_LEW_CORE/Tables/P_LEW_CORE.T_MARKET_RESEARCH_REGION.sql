/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_region
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_REGION (
   market_research_region_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a geographical region that has been defined by a provider of market research data.',
   market_research_data_provider_name  VARCHAR(100)     COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       COMMENT 'The code which identifies a country (as defined by a provider of market research data)',
   market_research_region_name         VARCHAR(100)     NOT NULL COMMENT 'The name of the geographical region, as it has been defined by a provider of market research data.',
   market_research_region_type_cd      VARCHAR(100)     COMMENT 'The code identifying the kind of geographical region which has been defined by a provider of market research data.',
   loc_sid_wh                          NUMBER(38,0)     COMMENT 'The unique identifier for the sales company (VGES) which is represented by this market research region.',
   display_seq                         NUMBER(38,0)     COMMENT 'The sort order in which the region will be displayed in reports.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_REGION PRIMARY KEY (market_research_region_sid) NOT ENFORCED 
)  COMMENT = 'A geographical region, as defined by providers of market research data. This may include countries, provinces of a country or smaller geographical areas. These regions do not necessarily need to match the standard geographical regions. However, regions which have been customized in order to match Lidl defined regions, may also be present.';
