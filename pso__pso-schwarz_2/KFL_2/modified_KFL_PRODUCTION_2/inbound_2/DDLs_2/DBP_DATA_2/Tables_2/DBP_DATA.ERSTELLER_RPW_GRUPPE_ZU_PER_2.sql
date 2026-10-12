--==============================================================
-- Table: ersteller_rpw_gruppe_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ersteller_rpw_gruppe_zu_per_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ERSTELLER_RPW_GRUPPE_ZU_PER_2 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   ersteller_id                        INTEGER     NOT NULL COMMENT 'Eindeutiger Schluessel fuer einen RPW User/Verursacher.',
   gruppe_id                           VARCHAR(20)      NOT NULL COMMENT 'Schluessel fuer eine_2 Gruppe_2 von RPW Usern. Zusammen mit einer Abteilung kann die Gruppe_2  eindeutig identifiziert werden.  ',
   abteilung_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutiger Schluessel zur Indentifikaltion einer RPW Abteilung.',
   dat_von                             DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn der Zuordnung User zu Abteilung/Gruppe_2;',
   dat_bis                             DATE             COMMENT 'Gueltigkeitsende der Zuordnung User zu Abteilung/Gruppe_2;',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ERSTELLER_RPW_GRUPPE_ZU_PER PRIMARY KEY (system_id, mandant_id, ersteller_id, gruppe_id, abteilung_id, dat_von) NOT ENFORCED
)  COMMENT = 'RPW - Zeitabhaengige Zuordnung der RPW User/Verursacher zu einer Gruppe_2/Abteilung.';

