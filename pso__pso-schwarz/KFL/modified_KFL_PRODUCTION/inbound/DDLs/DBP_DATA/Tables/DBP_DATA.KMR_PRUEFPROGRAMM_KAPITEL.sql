--==============================================================
-- Table: kmr_pruefprogramm_kapitel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_kapitel
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:34:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_PRUEFPROGRAMM_KAPITEL (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   kapitel_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Innerhalb eines AMX-Systems die eindeutige ID eines Bereichs. Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.',
   kapitel_bez                         VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitel-Bezeichnung, Quellfeld activity_name.',
   kapitel_typ_id                      INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapiteltyp-ID. Quellfeld audit_universe_audited_process_id_current_level. Zusammen mit dem AMX-System ist es die eindeutige ID des Pruefprogrammtyps: Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.',
   pruefung_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungs-ID. Verweist auf kmr_pruefung. Quellfeld auditing_id.',
   kapitel_nr                          VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitelnummer. Quellfeld activity_sort_order.',
   sort_nr                             INTEGER     COMMENT 'Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.',
   fehlerverdacht_fg                   INTEGER     COMMENT 'Flag: Identifizierung fehlerhafter Prüfkapitel  in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
   gepr_prozess_id                     INTEGER     DEFAULT -1 COMMENT 'Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_current_level.',
   ergebnis                            INTEGER     COMMENT 'Endergebnis, Quellfeld numeric_result_current_level.',
   ergebnis_berechnet                  INTEGER     COMMENT 'Ergebnis berechnet. Quellfeld contains_pu_computed_numeric_result_current_level.',
   ergebnis_manuell                    INTEGER     COMMENT 'Ergebnis manuell. Quellfeld contains_pu_manual_numeric_result_current_level.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_PRUEFPROGRAMM_KAPITEL PRIMARY KEY (kapitel_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Table for all audit activities (Kapitel der Prüfungen). It contains all "Prüfprogramme" (Feld pruefprogramm_id in Tabelle kmr_pruefprogramm_pruefprogramm), "Hauptbereiche" (Feld hauptbereich_id in Tabelle kmr_pruefprogramm_hauptbereich), "Teilbereiche" (Feld teilbereich_id in Tabelle kmr_pruefprogramm_teilbereich) and "Unterbereiche" (Feld unterbereich_id in Tabelle kmr_pruefprogramm_unterbereich). Does not contain "Kurzchecks". Source view v_dwh_kl_data_audit_program.';
