create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_ORGANISATIONSEINHEIT_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	ORGA_EINHEIT_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Organisationseinheit-ID. Quellfelder auditing_audited_org_unit_id, suggestion_responsible_unit_id.',
	ORGA_EINHEIT_IMP_REFERENZ VARCHAR(255) DEFAULT ' ' COMMENT 'Organisationseinheit Importreferenz. Quellfeld auditing_audited_org_unit_imp_reference.',
	ORGA_EINHEIT_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Organisationseinheit-Bezeichnung. Quellfelder auditing_audited_org_unit_name, suggestion_responsible_unit_name.',
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant_2 im DWH.',
	WUP_ID NUMBER(38,0) COMMENT 'Mutter Wup_2 ID, wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) COMMENT 'Nebenbetrieb-ID (Lager, Filiale, ...).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_ORGANISATIONSEINHEIT primary key (ORGA_EINHEIT_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for Kaufland organizational units (Organisationseinheiten) in the context of auditing (Revision). An organizational unit_2 can be audited (gepruefte Organisationseinheiten), \""Who was audited? (Wer wurde geprueft?)\"", or be the one that handles / helps with the improvement suggestions (zuständige Stelle) of the audited unit. Does not include \""Kurzchecks\"". Source views v_dwh_kl_data_auditing, v_dwh_kl_data_suggestion.'
;
