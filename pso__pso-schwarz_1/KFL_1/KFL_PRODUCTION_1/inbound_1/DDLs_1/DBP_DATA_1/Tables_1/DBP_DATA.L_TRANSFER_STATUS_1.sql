--==============================================================
-- Table: l_transfer_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_transfer_status_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:51:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TRANSFER_STATUS_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   transfer_status_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TRANSFER_STATUS PRIMARY KEY (mandant_id, transfer_status_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle der möglichen Status_1 des Transfers. Der Transferstatus gibt den Aktuellen Stand der Übertragung an SAP Retail an.';
