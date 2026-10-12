/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_unit_of_measure
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_unit_of_measure (
market_research_uom_cd STRING(100) NOT NULL
OPTIONS(description='The code which identifies the way, how a metric is measured.'),
market_research_uom_descr STRING(250)
OPTIONS(description='A textual description for the way, how a metric is measured.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_uom_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the way, how a metric is measured, i.e. as an amount in a given currency, as a count or as a quantity');