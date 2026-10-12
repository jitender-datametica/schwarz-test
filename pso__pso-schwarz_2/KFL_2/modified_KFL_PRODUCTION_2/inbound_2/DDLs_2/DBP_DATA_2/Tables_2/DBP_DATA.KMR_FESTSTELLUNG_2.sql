--==============================================================
-- Table: kmr_feststellung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_feststellung_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:26:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_FESTSTELLUNG_2 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   feststellung_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Feststellung-ID. Quellfeld issue_id.',
   frage_id                            INTEGER     NOT NULL DEFAULT -1 COMMENT 'Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.',
   feststellung_bez                    VARCHAR(255)     DEFAULT ' ' COMMENT 'Feststellung-Bezeichnung. Quellfeld issue_title.',
   feststellung_text                   VARCHAR(50000)   COMMENT 'Feststellungsbeobachtung Text. Formfrei, somit sind Länge und Inhalt dem Reviewer überlassen. Quellfeld issue_observation.',
   feststellung_gewichtung_id          INTEGER     DEFAULT -1 COMMENT 'Gewichtung-ID. Quellfeld issue_weight_id.',
   compliance_fg                       INTEGER     COMMENT 'Flag: Ist Compliance-Feststellung. Quellfeld issue_is_compliance.',
   berichtsrelevant_fg                 INTEGER     COMMENT 'Flag: Ist berichtsrelevante Feststellung. Quellfeld issue_is_report_relevant.',
   effizienz_fg                        INTEGER     COMMENT 'Flag: Ist Effizienz-Feststellung. Quellfeld issue_is_efficiency.',
   wiederkehrend_fg                    INTEGER     COMMENT 'Flag: Ist wiederholte Feststellung. Quellfeld issue_is_repeat_issue.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_FESTSTELLUNG PRIMARY KEY (amx_system_id, feststellung_id) NOT ENFORCED
)  COMMENT = 'KMR - This table contains all issues (feststellung_id) that were observed with the guideline (frage_id) that was audited. Does not contain "Kurzchecks". Source view v_dwh_kl_data_issue.';
