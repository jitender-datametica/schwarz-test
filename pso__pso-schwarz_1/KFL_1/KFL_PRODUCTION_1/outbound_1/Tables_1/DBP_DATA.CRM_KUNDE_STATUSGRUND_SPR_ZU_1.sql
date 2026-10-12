CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kunde_statusgrund_spr_zu_1 (
kunde_statusgrund_id BIGNUMERIC(38,0) DEFAULT - 9999 NOT NULL
OPTIONS(description='Statusgrund-ID des Kunden (liefert Information darüber, wieso der Kunde die entsprechende Status_1-ID hat)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kunde_statusgrund_bez STRING(120) OPTIONS(description='Bezeichnung des Kundenstatusgrunds'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Sprachtabelle für das Attribut\"Statuscode\" (Entität\"Contact_1\", Kundenstatus) aus MS Dynamics CRM');