--==============================================================
-- Table: transfer_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transfer_status_spr_zu
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:52:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transfer_status_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
transfer_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'),
transfer_status_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Transferstatus'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, transfer_status_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen des Transferstatus.');