/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_unit_of_measure_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_UNIT_OF_MEASURE_2 (
   market_research_uom_cd              VARCHAR(100)     NOT NULL COMMENT 'The code which identifies the way, how a metric is measured.',
   market_research_uom_descr           VARCHAR(250)     COMMENT 'A textual description for the way, how a metric is measured.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_UNIT_OF_MEASURE PRIMARY KEY (market_research_uom_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the way, how a metric is measured, i.e. as an amount in a given currency, as a count or as a quantity';
