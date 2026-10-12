--==============================================================
-- Table: transfer_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transfer_status_spr_zu_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:52:53
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSFER_STATUS_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   transfer_status_id                  INTEGER     NOT NULL COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.',
   transfer_status_bez                 VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Transferstatus',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSFER_STATUS_SPR_ZU PRIMARY KEY (mandant_id, spr_id, transfer_status_id) NOT ENFORCED
)  COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Transferstatus.';
