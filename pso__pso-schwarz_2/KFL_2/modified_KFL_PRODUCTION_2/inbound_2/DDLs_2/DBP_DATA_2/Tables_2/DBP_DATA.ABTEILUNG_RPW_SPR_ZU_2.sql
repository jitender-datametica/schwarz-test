--==============================================================
-- Table: abteilung_rpw_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abteilung_rpw_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABTEILUNG_RPW_SPR_ZU_2 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   abteilung_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutiger Fachschluessel zur Referenzierung einer Abteilung aus der DWH Tabelle l_abteilung_rpw.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1;',
   abteilung_rpw_bez                   VARCHAR(40)      COMMENT 'Sprachabhaengige Bezeichnung fuer die RPW Abteillung. Es wird fuer jede DWH Sprache = 1 ein Eintrag erstellt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABTEILUNG_RPW_SPR_ZU PRIMARY KEY (system_id, mandant_id, abteilung_id, spr_id) NOT ENFORCED
)  COMMENT = 'RPW - Sprachabhaengige Bezeichnung der RPW Abteilungen. Es wird fuer jede DWH Sprache = 1 ein Eintrag hinterlegt. Defaultwert ist die deutsche Bezeichnung.';

