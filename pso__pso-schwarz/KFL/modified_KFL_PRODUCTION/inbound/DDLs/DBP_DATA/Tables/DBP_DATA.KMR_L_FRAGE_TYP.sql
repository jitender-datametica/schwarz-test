--==============================================================
-- Table: kmr_l_frage_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_frage_typ
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:28:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_FRAGE_TYP (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   frage_typ_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Fragetyp-ID. Quellfeld guideline_checklist_logic_id.',
   frage_typ_bez                       VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Fragetyp-Bezeichnung. Quellfeld guideline_checklist_logic_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_FRAGE_TYP PRIMARY KEY (frage_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the type of question / guideline. Does not contain "Kurzchecks". Source view v_dwh_kl_data_guideline.';
