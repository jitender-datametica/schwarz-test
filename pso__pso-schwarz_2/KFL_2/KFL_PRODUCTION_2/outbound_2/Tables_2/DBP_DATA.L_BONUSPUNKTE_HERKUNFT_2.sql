--==============================================================
-- Table: l_bonuspunkte_herkunft_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_herkunft_2
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bonuspunkte_herkunft_2 (
bonuspunkte_herkunft_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Code für die Herkunft der Punkte.'),
bonuspunkte_herkunft_bez STRING(200) OPTIONS(description='Bezeichnung für die Herkunft der Punkte.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bonuspunkte_herkunft_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Herkunft der Bonuspunkte-Wie sie vergeben wurden.ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..');