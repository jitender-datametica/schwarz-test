--==============================================================
-- Table: amx_de_pruef_kapitel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_pruef_kapitel_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_DE_PRUEF_KAPITEL_2 (
   pruef_kapitel_id                    NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID des Prüfkapitels',
   pruefung_id                         NUMBER(38,0)     NOT NULL COMMENT 'Die Eindeutige Prüfung zu der dieses Prüfkapitel gehört.',
   pruef_kapitel_bez                   VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüfkapitels aus dem Quellfeld name',
   hauptbereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Hauptbereichs',
   teilbereich_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Teilbereichs',
   kapitel_ergebnis_wert               NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Ergebnisswert aus dem Quellfeld numeric_result',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_DE_PRUEF_KAPITEL PRIMARY KEY (pruef_kapitel_id) NOT ENFORCED
)  COMMENT = 'KMR - Audimex. Enthäl Kapitel der Prüfprogramme für Kurzcheck Daten aus DE';

