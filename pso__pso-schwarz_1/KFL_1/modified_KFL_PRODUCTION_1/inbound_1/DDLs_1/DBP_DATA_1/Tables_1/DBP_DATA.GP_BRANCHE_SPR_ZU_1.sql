--==============================================================
-- Table: gp_branche_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_branche_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_BRANCHE_SPR_ZU_1 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   gp_branche_id                       VARCHAR(4)       NOT NULL COMMENT 'Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). Referenz zu der Tabelle l_gp_branche_1',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   gp_branche_bez                      VARCHAR(40)      COMMENT 'Sprachabhaengige Kurzbezeichnung der Banchen der Lieferanten.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_BRANCHE_SPR_ZU PRIMARY KEY (system_id, mandant_id, gp_branche_id, spr_id) NOT ENFORCED
)  COMMENT = 'RPW - Sprachabhaengige Bezeichnung der Lieferantenbranchen aus der Tabelle T016T des Quellsystems SAP. Es wird fuer jede DWH Sprache ein Eintrag hinterlegt. Standardbezeichnung ist die deusche Bezeichnung.';
