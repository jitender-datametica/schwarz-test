--==============================================================
-- Table: aad_cashier_id_mapping
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_cashier_id_mapping
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:38:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_CASHIER_ID_MAPPING (
   hashed_cashier_id                   VARCHAR(255)     NOT NULL COMMENT 'Encrypted (hashed) CashierID',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   kassierer_nr                        VARCHAR(4)       NOT NULL COMMENT 'Nummer des Kassierers.',
   hash_generation_dt                  DATE             COMMENT 'Last date of the generation of the hashed CashierID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_CASHIER_ID_MAPPING PRIMARY KEY (hashed_cashier_id) NOT ENFORCED
)  COMMENT = ' Contains pseudonymise cashier number';
