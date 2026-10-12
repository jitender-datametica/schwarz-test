CREATE OR REPLACE TABLE kfl_production_dbp_data.angebot_attribut_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
angebot_attribut_id INTEGER NOT NULL OPTIONS(description='ID des Attributs'),
angebot_attribut_txt STRING(500) NOT NULL
OPTIONS(description='Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_attribut_id, angebot_nr) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem Angebot_2 und dem jeweils verknüpften Attribut um weitere Informationen dem Angebot_2 hinzuzufügen.');