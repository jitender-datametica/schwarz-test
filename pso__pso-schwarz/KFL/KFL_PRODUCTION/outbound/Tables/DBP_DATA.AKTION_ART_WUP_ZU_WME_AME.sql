--==============================================================

-- Table: aktion_art_wup_zu_wme_ame
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_wup_zu_wme_ame
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_art_wup_zu_wme_ame (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktionsnummer'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id) NOT ENFORCED
)
OPTIONS(description='VIS - Artikel-Filiale Zuordnung zu einer Aktion  nur für WME (Werbemenegeneinholung) und AME (Allg. Menegeneinholung) - die Aktionen liegen in der Zukunft und überschneiden sich nicht mit den Aktionen in Tabelle Aktion- SAP RET - WALE');