--==============================================================
-- Table: kmr_pruefprogramm_unterbereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_unterbereich
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:56:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_PRUEFPROGRAMM_UNTERBEREICH (
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   unterbereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Unterbereichs.',
   pruefung_id                         NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Prüfungs-ID. Quellfeld auditing_id.',
   teilbereich_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID, höheres Hierarchielevel Teilbereich. Quellfeld activity_id_tb.',
   hauptbereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID, höheres Hierarchielevel Hauptbereich. Quellfeld activity_id_hb.',
   pruefprogramm_id                    NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID, höheres Hierarchielevel Prüfprogramm. Quellfeld activity_id_pp.',
   kapitel_nr                          VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitelnummer. Quellfeld activity_sort_order.',
   sort_nr                             NUMBER(38,0)     COMMENT 'Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.',
   fehlerverdacht_fg                   NUMBER(38,0)     COMMENT 'Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
   unterbereich_bez                    VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapitel-Bezeichnung, Ebene Unterbereich. Quellfeld activity_name_ub. Bezeichnung des Unterbereichs.',
   gepr_prozess_id                     NUMBER(38,0)     DEFAULT -1 COMMENT 'Geprüfter Prozess-ID, Ebene Unterbereich. Quellfeld audit_universe_audited_process_id_ub.',
   ergebnis                            NUMBER(38,0)     COMMENT 'Endergebnis, Ebene Unterbereich. Quellfeld numeric_result_ub.',
   ergebnis_berechnet                  NUMBER(38,0)     COMMENT 'Ergebnis berechnet, Ebene Unterbereich. Quellfeld contains_pu_computed_numeric_result_ub.',
   ergebnis_manuell                    NUMBER(38,0)     COMMENT 'Ergebnis manuell, Ebene Unterbereich. Quellfeld contains_pu_manual_numeric_result_ub.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_PRUEFPROGRAMM_UNTERBEREICH PRIMARY KEY (amx_system_id, unterbereich_id) NOT ENFORCED
)  COMMENT = 'KMR - Table for the "Unterbereich"-hierarchy level of the audit activities (Kapitel, kapitel_id in kmr_l_pruefprogramm_kapitel, hier als unterbereich_id und höher). While MSI in frontend needs a complete hierarchy, audit activities unfortunately do not strictly have to follow it, which means that sometimes levels could be missing and are displayed as NULLs. Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.';
