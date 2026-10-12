--==============================================================
-- Table: l_bonuspunkte_kanal
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_kanal
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bonuspunkte_kanal (
bonuspunkte_kanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'),
bonuspunkte_kanal_bez STRING(200)
OPTIONS(description='Bezeichnung der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bonuspunkte_kanal_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Plattform wo die Bonuspunkte erworben oder ausgegeben wurden.ZB: Markplatz, Filiale.');