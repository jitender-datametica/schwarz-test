--==============================================================
-- Table: ts_nfmd_markdown_decision
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_markdown_decision
   generated from Powerdesigner on Dienstag, 26. April 2022 20:00:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_MARKDOWN_DECISION (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   markdown_decision_id                INTEGER    NOT NULL COMMENT 'Unique identifier of price reduction (markdown) decision',
   markdown_decision_descr             VARCHAR(255)    COMMENT 'Decision description in DE',
   markdown_decision_descr_bg          VARCHAR(255)    COMMENT 'Decision description in  BG',
   markdown_decision_descr_cz          VARCHAR(255)    COMMENT 'Decision description in  CZ',
   markdown_decision_descr_en          VARCHAR(255)    COMMENT 'Decision description in EN',
   markdown_decision_descr_hr          VARCHAR(255)    COMMENT 'Decision description in HR',
   markdown_decision_descr_pl          VARCHAR(255)    COMMENT 'Decision description in PL',
   markdown_decision_descr_ro          VARCHAR(255)    COMMENT 'Decision description in  RO',
   markdown_decision_descr_sk          VARCHAR(255)    COMMENT 'Decision description in SK',
   markdown_decision_descr_native      VARCHAR(255)    COMMENT 'Decision description in native language (based on mandant id)',
   active_fg                           INTEGER    COMMENT 'Flag indicating if the decision is active',
   retoure_fg                          INTEGER    COMMENT 'Flag indicating if the decision is a retoure',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_MARKDOWN_DECISION PRIMARY KEY (mandant_id, markdown_decision_id) NOT ENFORCED
)  COMMENT = 'This table defines the decisions for price reduction that exist - data is populated by Frontend';