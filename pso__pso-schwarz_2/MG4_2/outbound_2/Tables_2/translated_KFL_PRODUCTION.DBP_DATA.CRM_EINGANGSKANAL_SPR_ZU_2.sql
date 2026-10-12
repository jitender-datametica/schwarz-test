CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_eingangskanal_spr_zu_2 (
crm_eingangskanal_id INTEGER NOT NULL OPTIONS(description='Eingangskanal ID - z.B. Telefon, Email, etc.'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_eingangskanal_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Eingangskanal Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_eingangskanal_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Eingangskanal - MS Dynamics CRM');