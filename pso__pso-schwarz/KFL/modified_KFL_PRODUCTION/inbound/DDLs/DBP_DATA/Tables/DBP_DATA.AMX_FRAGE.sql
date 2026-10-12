--==============================================================
-- Table: amx_frage
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_FRAGE (
   amx_frage_id                        INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruef_kapitel_id                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Pruef-Kapitels. Aus dem Quellfeld id',
   antwort_wert                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Beantwortung der Frage aus Quellfeld numeric_result',
   amx_frage_katalog_id                INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle guideline.abstract_guideline_id.',
   anmerkung                           VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Anmerkung aus dem Quellfeld work_description',
   eingabe                             VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Eingabe aus dem Quellfeld enter_result',
   anz_fehler_amx                      INTEGER     COMMENT 'Anzahl Fehler aus dem Quellfeld count_errors',
   stichprobe_umfang                   INTEGER     COMMENT 'Stichprobenumfang aus dem Quellfeld audited_amount',
   frage_gewichtung                    INTEGER     COMMENT 'Gewichtung der Fragen für die Berechnung des Endergebnisses',
   antwort_wert_text                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Textuelle Darstellung des nummerischen Feldes antwort_wert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_FRAGE PRIMARY KEY (amx_frage_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Die Tabelle amx_frage enthält die Fragen (Handlungen) der Prüfprogramme. Aus der Quelle audimex.guideline';

