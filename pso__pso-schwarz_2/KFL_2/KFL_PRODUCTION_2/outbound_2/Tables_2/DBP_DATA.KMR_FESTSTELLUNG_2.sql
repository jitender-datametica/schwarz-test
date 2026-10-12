--==============================================================
-- Table: kmr_feststellung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_feststellung_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:26:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_feststellung_2 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
feststellung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Feststellung-ID. Quellfeld issue_id.'),
frage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.'),
feststellung_bez STRING(255) DEFAULT ' ' OPTIONS(description='Feststellung-Bezeichnung. Quellfeld issue_title.'),
feststellung_text STRING(50000)
OPTIONS(description='Feststellungsbeobachtung Text. Formfrei, somit sind Länge und Inhalt dem Reviewer überlassen. Quellfeld issue_observation.'),
feststellung_gewichtung_id BIGNUMERIC(38,0) DEFAULT - 1 OPTIONS(description='Gewichtung-ID. Quellfeld issue_weight_id.'),
compliance_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Ist Compliance-Feststellung. Quellfeld issue_is_compliance.'),
berichtsrelevant_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Ist berichtsrelevante Feststellung. Quellfeld issue_is_report_relevant.'),
effizienz_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Ist Effizienz-Feststellung. Quellfeld issue_is_efficiency.'),
wiederkehrend_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Ist wiederholte Feststellung. Quellfeld issue_is_repeat_issue.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, feststellung_id) NOT ENFORCED
)
OPTIONS(description='KMR - This table contains all issues (feststellung_id) that were observed with the guideline (frage_id) that was audited. Does not contain "Kurzchecks". Source view v_dwh_kl_data_issue.');