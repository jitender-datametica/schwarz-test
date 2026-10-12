CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_optin_statusgrund_spr_zu_2 (
optin_statusgrund_id INTEGER DEFAULT - 9999 NOT NULL
OPTIONS(description='Statusgrund-ID des Optins (liefert Information darüber, wieso das Optin die entsprechende Status_2-ID hat, bspw. Erlaubnis erteilt, Erlaubnis nicht erteilt, Erlaubnis entzogen)'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
optin_statusgrund_bez STRING(120) OPTIONS(description='Statusgrund-Bezeichnung des Optins'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Sprachtabelle für das Attribut\"Statuscode\" (Entität\"Arvato_optin\", Optin-Statusgrund) aus MS Dynamics CRM');