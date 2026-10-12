create or replace TABLE KFL_PRODUCTION.DBP_DATA.KMR_L_PRUEFPROZESS (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	GEPR_PROZESS_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.',
	GEPR_PROZESS_IMP_REFERENZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Geprüfter Prozess Importreferenz. Quellfeld audit_universe_audited_process_imp_reference_audit_level.',
	GEPR_PROZESS_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Geprüfter Prozess-Bezeichnung. Quellfeld audit_universe_audited_process_name_audit_level.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_PRUEFPROZESS primary key (GEPR_PROZESS_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the audited process (geprüfter Prozess, vom Fachbereich oft auch \"Prüfprozess\" genannt). Hierarchically comprehensive definition of the audited process. \"What was audited? (Was wurde geprüft?)\" Does not include \"Kurzchecks\". Source view v_dwh_kl_data_auditing.'
;