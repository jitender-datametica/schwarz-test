CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_gender_spr_zu_1 (
gender_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='ID für das Geschlecht des Kunden'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
gender_bez STRING(50) DEFAULT 'system generated' OPTIONS(description='Bezeichnugn für das Geschlecht des Kunden'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Sprachtabelle für das Attribut\"Gendercode\" (Entität\"Contact_1\", Kundengeschlecht) aus MS Dynamics CRM');