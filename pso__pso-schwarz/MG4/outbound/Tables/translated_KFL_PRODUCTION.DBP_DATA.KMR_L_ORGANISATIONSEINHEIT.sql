CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_l_organisationseinheit (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
orga_einheit_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Organisationseinheit-ID. Quellfelder auditing_audited_org_unit_id, suggestion_responsible_unit_id.'),
orga_einheit_imp_referenz STRING(255) DEFAULT ' '
OPTIONS(description='Organisationseinheit Importreferenz. Quellfeld auditing_audited_org_unit_imp_reference.'),
orga_einheit_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Organisationseinheit-Bezeichnung. Quellfelder auditing_audited_org_unit_name, suggestion_responsible_unit_name.'),
mandant_id INTEGER OPTIONS(description='Mandant im DWH.'),
wup_id INTEGER OPTIONS(description='Mutter Wup ID, wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER OPTIONS(description='Nebenbetrieb-ID (Lager, Filiale, ...).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (orga_einheit_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for Kaufland organizational units (Organisationseinheiten) in the context of auditing (Revision). An organizational unit can be audited (gepruefte Organisationseinheiten),\"Who was audited? (Wer wurde geprueft?)\", or be the one that handles / helps with the improvement suggestions (zuständige Stelle) of the audited unit. Does not include\"Kurzchecks\". Source views v_dwh_kl_data_auditing, v_dwh_kl_data_suggestion.');