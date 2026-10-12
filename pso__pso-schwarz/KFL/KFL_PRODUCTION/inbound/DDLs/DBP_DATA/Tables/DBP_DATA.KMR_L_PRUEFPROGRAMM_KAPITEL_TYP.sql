--==============================================================
-- Table: kmr_l_pruefprogramm_kapitel_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefprogramm_kapitel_typ
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:51:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFPROGRAMM_KAPITEL_TYP (
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   kapitel_typ_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kapiteltyp-ID. Quellfeld audit_universe_audited_process_id_current_level. Eindeutige ID des Pruefprogrammtyps.',
   kapitel_typ_bez                     VARCHAR(255)     DEFAULT ' ' COMMENT 'Kapiteltyp-Bezeichnung. Quellfeld activity_audit_concept_type_name_current_level. Bezeichnung des Pruefprogrammtyps.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFPROGRAMM_KAPITEL_TYP PRIMARY KEY (kapitel_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the activity type (Kapiteltyp). Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.';
