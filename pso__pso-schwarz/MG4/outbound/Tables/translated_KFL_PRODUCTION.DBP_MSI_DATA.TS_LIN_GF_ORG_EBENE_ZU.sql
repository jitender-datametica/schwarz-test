CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_lin_gf_org_ebene_zu (
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='LDAP / Benutzerkennung'),
hr_objekt_ebene2_id INTEGER OPTIONS(description='ID zur Organisationseinheit auf Ebene 2'),
hr_objekt_ebene3_id INTEGER OPTIONS(description='ID zur Organisationseinheit auf Ebene 3'),
hr_objekt_ebene4_id INTEGER OPTIONS(description='ID zur Organisationseinheit auf Ebene 4'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Tabelle fuer Transaction-Service: Zuordnung GF zu Organisationshierarchie-Ebene');