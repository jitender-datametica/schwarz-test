--==============================================================
-- Table: l_bonuspunkte_grund_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_grund_1
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bonuspunkte_grund_1 (
bonuspunkte_grund_cd STRING(100) NOT NULL OPTIONS(description='Code des Grunds der Bonuspunktevergabe.'),
bonuspunkte_grund_bez STRING(200) OPTIONS(description='Bezeichnung des Grunds der Bonuspunktevergabe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bonuspunkte_grund_cd) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für den Grund der Bonuspunktevergabe.Zb:checkout, cancellation, Registrierung von PDP.Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.');