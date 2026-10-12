--==============================================================
-- Table: amx_filter_benutzeroberflaeche_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_filter_benutzeroberflaeche_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_FILTER_BENUTZEROBERFLAECHE_1 (
   amx_filter_typ_id                   INTEGER     NOT NULL COMMENT 'Typ der IDs zur Unterscheidung der generischen Platzhalter-Spalten (1 - Hauptbereich, 2 - Teilbereich, 3 - Frage) zur Filterung in Berichtsoberflaeche',
   platzhalter_id                      INTEGER     NOT NULL COMMENT 'Generische Spalte mit IDs aus amx_hauptbereich, amx_teilbereich, amx_frage_1(0 als nicht relevant, da Verwendung von platzhalter_string) Tabellen',
   platzhalter_string                  VARCHAR(50)      NOT NULL COMMENT 'Generische Spalte mit Teilstring (Suffix) zu den Fragen aus amx_frage_1 Tabelle zur Selektion aller anzuzeigenden Fragen in der Oberflaeche',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   platzhalter_sort                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Sortierfeld für Platzhalter',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_FILTER_BENUTZEROBERFLAECHE PRIMARY KEY (amx_filter_typ_id, platzhalter_id, platzhalter_string, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - audimex - Tabelle mit generischen Platzhalter-Spalten ..._id aus Teilbereich, Hauptbereich, ..._string (Teilstring als Suffixe der Fragenummer) zur Anzeigesteuerung in KMR Dashboard im Vertriebs-Cockpit';

