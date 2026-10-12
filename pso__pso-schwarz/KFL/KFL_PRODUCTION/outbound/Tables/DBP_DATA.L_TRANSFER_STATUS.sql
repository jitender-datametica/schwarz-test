--==============================================================
-- Table: l_transfer_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_transfer_status
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:51:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_transfer_status (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
transfer_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transfer_status_id) NOT ENFORCED
)
OPTIONS(description='Lookuptabelle der möglichen Status des Transfers. Der Transferstatus gibt den Aktuellen Stand der Übertragung an SAP Retail an.');