--==============================================================
-- Table: ts_nfmd_markdown_decision_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_markdown_decision_2
   generated from Powerdesigner on Dienstag, 26. April 2022 20:00:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
markdown_decision_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of price reduction (markdown) decision'),
markdown_decision_descr STRING(255) OPTIONS(description='Decision description in DE'),
markdown_decision_descr_bg STRING(255) OPTIONS(description='Decision description in  BG'),
markdown_decision_descr_cz STRING(255) OPTIONS(description='Decision description in  CZ'),
markdown_decision_descr_en STRING(255) OPTIONS(description='Decision description in EN'),
markdown_decision_descr_hr STRING(255) OPTIONS(description='Decision description in HR'),
markdown_decision_descr_pl STRING(255) OPTIONS(description='Decision description in PL'),
markdown_decision_descr_ro STRING(255) OPTIONS(description='Decision description in  RO'),
markdown_decision_descr_sk STRING(255) OPTIONS(description='Decision description in SK'),
markdown_decision_descr_native STRING(255)
OPTIONS(description='Decision description in native language (based on mandant_2 id)'),
active_fg BIGNUMERIC(38,0) OPTIONS(description='Flag indicating if the decision is active'),
retoure_fg BIGNUMERIC(38,0) OPTIONS(description='Flag indicating if the decision is a retoure'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, markdown_decision_id) NOT ENFORCED
) OPTIONS(description='This table defines the decisions for price reduction that exist - data is populated by Frontend');