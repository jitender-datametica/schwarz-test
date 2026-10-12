--==============================================================
-- Table: ts_aad_request_receipt_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_aad_request_receipt_zu_1
   generated from Powerdesigner on Montag, 5. Juni 2023 07:05:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_AAD_REQUEST_RECEIPT_ZU_1 (
   bon_id                              VARCHAR(25)      NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   aad_request_id                      INTEGER     NOT NULL COMMENT 'Unique Identifier of the Request (Sequence)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AAD_REQUEST_RECEIPT_ZU PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id, aad_request_id) NOT ENFORCED
)  COMMENT = 'Contains the receipt associated to a request made in frontend';
