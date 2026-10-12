CREATE OR REPLACE TABLE kfl_production_dbp_data.kommunikationskanal_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kommunikationskanal_id INTEGER NOT NULL OPTIONS(description='Eindeutige Kennung des Kommunikationskanals'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 ist Deutsch'),
kommunikationskanal_bez STRING(200) NOT NULL
OPTIONS(description='Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kommunikationskanal_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachabhängige Bezeichnungen der Kommunikationskanäle für Marketingkampagnen - manuell versorgt');