--==============================================================
-- Table: kmr_l_pruefprozess
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefprozess
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:55:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFPROZESS (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   gepr_prozess_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.',
   gepr_prozess_imp_referenz           VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Geprüfter Prozess Importreferenz. Quellfeld audit_universe_audited_process_imp_reference_audit_level.',
   gepr_prozess_bez                    VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Geprüfter Prozess-Bezeichnung. Quellfeld audit_universe_audited_process_name_audit_level.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFPROZESS PRIMARY KEY (gepr_prozess_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the audited process (geprüfter Prozess, vom Fachbereich oft auch "Prüfprozess" genannt). Hierarchically comprehensive definition of the audited process. "What was audited? (Was wurde geprüft?)" Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
