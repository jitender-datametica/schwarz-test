--==============================================================
-- Table: kmr_frage
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_frage
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:05:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_FRAGE (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   frage_id                            INTEGER     NOT NULL DEFAULT -1 COMMENT 'Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.',
   kapitel_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Prüfbereichs.',
   sort_nr                             VARCHAR(255)     COMMENT 'Fragennummer. Quellfeld guideline_sort_order. Es ist eine Art ID der Frage im Fragenkatalog einer Landes. Wird diese Frage wieder gestellt / überprüft, hat sie die gleiche sort_nr und frage_text aber eine neue guideline_id.',
   frage_text                          VARCHAR(50000)   COMMENT 'Fragetext. Quellfeld guideline_description_text. Der Text beschreibt den tatsächlichen Gegenstand der Frage, oft in deutscher und Landessprache.',
   anmerkung                           VARCHAR(50000)   COMMENT 'Anmerkung zur Frage. Quellfeld guideline_work_description.',
   frage_status_id                     INTEGER     DEFAULT -1 COMMENT 'Status-ID. Quellfeld guideline_state_id.',
   frage_typ_id                        INTEGER     DEFAULT -1 COMMENT 'Fragetyp-ID. Quellfeld guideline_checklist_logic_id.',
   stichprobe_umfang                   INTEGER     COMMENT 'Stichprobenumfang. Quellfeld guideline_audited_amount.',
   ergebnis_num                        INTEGER     COMMENT 'Ergebnis numerisch. Quellfeld guideline_numeric_result.',
   ergebnis_text                       VARCHAR(255)     DEFAULT ' ' COMMENT 'Ergebnis textuell. Quellfeld guideline_textual_result.',
   ergebnis_man                        VARCHAR(1000)    COMMENT 'Ergebnis manuell. Quellfeld guideline_enter_result.',
   aufgedeckte_fehler_anz              INTEGER     COMMENT 'Anzahl n.i.O. / aufgedeckter Fehler. Quellfeld guideline_count_errors.',
   feststellungen_anz                  INTEGER     COMMENT 'Anzahl der Feststellungen. Quellfeld cnt_issues.',
   massnahmen_anz                      INTEGER     COMMENT 'Anzahl der Massnahmen. Quellfeld cnt_actions.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_FRAGE PRIMARY KEY (amx_system_id, frage_id) NOT ENFORCED
)  COMMENT = 'KMR - This table contains details on the questions / guidelines (frage_id) that are being audited for an activity (kapitel_id). The frage_id is linked to the kapitel_id (activity) and in consequence to the hierarchy of the "Prüfprogramm". Does not contain "Kurzchecks". Source view v_dwh_kl_data_guideline.';
