--==============================================================
-- Table: kmr_pruefprogramm_pruefprogramm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_pruefprogramm
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:59:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_PRUEFPROGRAMM_PRUEFPROGRAMM (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   pruefprogramm_id                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id.',
   pruefung_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungs-ID. Quellfeld auditing_id. Eindeutige ID des Prüfprogramms.',
   kapitel_nr                          VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitelnummer. Quellfeld activity_sort_order.',
   sort_nr                             INTEGER     COMMENT 'Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.',
   fehlerverdacht_fg                   INTEGER     COMMENT 'Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
   pruefprogramm_bez                   VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitel-Bezeichnung, Ebene Prüfprogramm. Quellfeld activity_name_pp. Bezeichnung des Prüfprogramms.',
   gepr_prozess_id                     INTEGER     DEFAULT -1 COMMENT 'Geprüfter Prozess-ID, Ebene Prüfprogramm. Quellfeld audit_universe_audited_process_id_pp.',
   ergebnis                            INTEGER     COMMENT 'Endergebnis, Ebene Prüfprogramm. Quellfeld numeric_result_pp.',
   ergebnis_berechnet                  INTEGER     COMMENT 'Ergebnis berechnet, Ebene Prüfprogramm. Quellfeld contains_pu_computed_numeric_result_pp.',
   ergebnis_manuell                    INTEGER     COMMENT 'Ergebnis manuell, Ebene Prüfprogramm. Quellfeld contains_pu_manual_numeric_result_pp.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_PRUEFPROGRAMM_PRUEFPROGRAMM PRIMARY KEY (amx_system_id, pruefprogramm_id) NOT ENFORCED
)  COMMENT = 'KMR - Table for the "Prüfprogramm"-hierarchy level of the audit activities (Kapitel, kapitel_id in kmr_l_pruefprogramm_kapitel, hier als pruefprogramm_id). While MSI in frontend needs a complete hierarchy, audit activities unfortunately do not strictly have to follow it, which means that sometimes levels could be missing and are displayed as NULLs. Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.';
