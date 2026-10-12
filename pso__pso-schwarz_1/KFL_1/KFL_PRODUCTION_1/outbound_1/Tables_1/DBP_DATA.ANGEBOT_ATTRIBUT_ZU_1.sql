--==============================================================
-- Table: angebot_attribut_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_attribut_zu_1
   generated from Powerdesigner on Donnerstag, 27. Februar 2025 11:24:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_attribut_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
angebot_attribut_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Attributs'),
angebot_attribut_txt STRING(500) NOT NULL
OPTIONS(description='Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_attribut_id, angebot_nr) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem Angebot_1 und dem jeweils verknüpften Attribut um weitere Informationen dem Angebot_1 hinzuzufügen.');