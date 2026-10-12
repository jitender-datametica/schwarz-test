/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_country
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_COUNTRY (
   market_research_country_cd          VARCHAR(2)       NOT NULL COMMENT 'The code which identifies a country (as defined by a provider of market research data)',
   market_research_country_name        VARCHAR(100)     NOT NULL COMMENT 'The name for the country (as defined by a provider of market research data)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_COUNTRY PRIMARY KEY (market_research_country_cd) NOT ENFORCED 
)  COMMENT = 'A country, as defined by a provider of market research data. E.g. Germany, Belgium, etc.';
