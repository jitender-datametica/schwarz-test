--==============================================================
-- Table: kmr_pruefprogramm_teilbereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_teilbereich_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:58:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_PRUEFPROGRAMM_TEILBEREICH_2 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   teilbereich_id                      INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Teilbereichs.',
   pruefung_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungs-ID. Quellfeld auditing_id.',
   hauptbereich_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID, höheres Hierarchielevel Hauptbereich. Quellfeld activity_id_hb.',
   pruefprogramm_id                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID, höheres Hierarchielevel Prüfprogramm. Quellfeld activity_id_pp.',
   kapitel_nr                          VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitelnummer. Quellfeld activity_sort_order.',
   sort_nr                             INTEGER     COMMENT 'Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.',
   fehlerverdacht_fg                   INTEGER     COMMENT 'Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
   teilbereich_bez                     VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitel-Bezeichung, Ebene Teilbereich. Quellfeld activity_name_tb. Bezeichnung des Teilbereichs.',
   gepr_prozess_id                     INTEGER     DEFAULT -1 COMMENT 'Geprüfter Prozess-ID, Ebene Teilbereich. Quellfeld audit_universe_audited_process_id_tb.',
   ergebnis                            INTEGER     COMMENT 'Endergebnis, Ebene Teilbereich. Quellfeld numeric_result_tb.',
   ergebnis_berechnet                  INTEGER     COMMENT 'Ergebnis berechnet, Ebene Teilbereich. Quellfeld contains_pu_computed_numeric_result_tb.',
   ergebnis_manuell                    INTEGER     COMMENT 'Ergebnis manuell, Ebene Teilbereich. Quellfeld contains_pu_manual_numeric_result_tb.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_PRUEFPROGRAMM_TEILBEREICH PRIMARY KEY (amx_system_id, teilbereich_id) NOT ENFORCED
)  COMMENT = 'KMR - Table for the "Teilbereich"-hierarchy_2 level of the audit activities (Kapitel, kapitel_id in kmr_l_pruefprogramm_kapitel, hier teilbereich_id und höher). While MSI in frontend needs a complete hierarchy_2, audit activities unfortunately do not strictly have to follow it, which means that sometimes levels could be missing and are displayed as NULLs. Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.';
