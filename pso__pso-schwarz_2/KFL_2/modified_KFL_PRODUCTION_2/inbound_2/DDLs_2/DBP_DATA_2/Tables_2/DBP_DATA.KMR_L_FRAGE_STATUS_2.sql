--==============================================================
-- Table: kmr_l_frage_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_frage_status_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:29:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_FRAGE_STATUS_2 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   frage_status_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Status_2-ID. Quellfeld guideline_state_id.',
   frage_status_bez                    VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Status_2-Bezeichnung. Quellfeld guideline_state_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_FRAGE_STATUS PRIMARY KEY (frage_status_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the status_2 of a question / guideline check during the audit process. Does not contain "Kurzchecks". Source view v_dwh_kl_data_guideline.';
