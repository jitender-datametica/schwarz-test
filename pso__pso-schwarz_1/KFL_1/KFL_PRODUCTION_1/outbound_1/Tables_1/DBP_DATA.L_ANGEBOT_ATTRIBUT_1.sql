--==============================================================
-- Table: l_angebot_attribut_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_attribut_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:31:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_angebot_attribut_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
angebot_attribut_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Attributs.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_attribut_id) NOT ENFORCED
)
OPTIONS(description='Enthält mögliche Attribute / Charakteristiken die einem Angebot_1 zusätzlich noch hinzugefügt werden können. Diese zusätzlichen Attribute können dabei sehr unterscheidlich sein und beispielsweise Informationen zu den Bestellmengen, Platzierung in der Filiale, Darstellung im Werbemittel, etc. enthalten.');