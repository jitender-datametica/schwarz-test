--==============================================================
-- Table: ts_ais_de_l_ek_saison
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_l_ek_saison
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 16:09:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view2.ts_ais_de_l_ek_saison (
ek_saison_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Cluster ID des zugehörigen Saisonclusters zum Artikel.'),
ek_saison_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung des Clusters.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ek_saison_id) NOT ENFORCED
)
OPTIONS(description='AIS DE - Lookup-Tabelle für Verkaufssaisons die vom EK für den EK definiert werden. Quelle: Excel und manuelle Pflege über MSTR Transaction Service.             ACHTUNG: Diese Tabelle hier ist als Zischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten geklärt ist.');