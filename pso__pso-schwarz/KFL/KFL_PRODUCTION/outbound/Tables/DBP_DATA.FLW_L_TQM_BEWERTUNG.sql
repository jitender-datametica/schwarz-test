--==============================================================
-- Table: flw_l_tqm_bewertung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_tqm_bewertung
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_tqm_bewertung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
fehler_prozent_bis NUMERIC(9,2) NOT NULL OPTIONS(description='oberer Wert des Prozentbereichs'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
fehler_prozent_von NUMERIC(9,2) NOT NULL OPTIONS(description='unterer Wert des Prozentbereichs'),
punkte_sap_kf BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Punkte für kritische Fehler'),
punkte_sap_vk BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Punkte für VK-Fehler'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, fehler_prozent_bis) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle zur Umrechnung von Fehlerprozentwerten in Fehlerpunkte');