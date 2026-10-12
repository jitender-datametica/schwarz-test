--==============================================================
-- Table: gp_fehlerart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_fehlerart_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_FEHLERART_SPR_ZU (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   gp_fehlerart_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schlüssel für die Fehlerarten eines Lieferanten z. B. Prieis- oder Konditionsfehler.',
   gp_fehlerart_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung der Lieferanten-Fehlerarten. Jeder Eintrag wird pro DWH Sprache = 1 hinterlegt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_FEHLERART_SPR_ZU PRIMARY KEY (system_id, mandant_id, spr_id, gp_fehlerart_id) NOT ENFORCED
)  COMMENT = 'RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen der Fehlerarten eines Lieferanten. Pro DWH Sprache = 1 wird ein Eintrag hinterlegt.';
