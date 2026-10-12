--==============================================================
-- Table: amx_de_frage
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_frage
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_DE_FRAGE (
   amx_frage_id                        INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id',
   pruef_kapitel_id                    INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Prüf Kapitels',
   antwort_wert                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Beantwortung der Frage aus dem Quellfeld numeric_result',
   amx_frage_katalog_id                INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer Frage aus dem Fragenkatalog',
   anmerkung                           VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Anmerkung aus dem Quellfeld work_description',
   eingabe                             VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Eingabe aus dem Quellfeld enter_result',
   anz_fehler_amx                      INTEGER     COMMENT 'Anzahl Fehler',
   stichprobe_umfang                   INTEGER     COMMENT 'Stichprobenumfang',
   frage_gewichtung                    INTEGER     COMMENT 'Gewichtung der Frage für die Berechnung des Endergebnisses',
   antwort_wert_text                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Textuelle Darstellung des Felder antwort_wert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_DE_FRAGE PRIMARY KEY (amx_frage_id) NOT ENFORCED
)  COMMENT = 'KMR - Audimex. Enthält die Fragen der Prüfprogramme für Kurzcheck DE Daten';

