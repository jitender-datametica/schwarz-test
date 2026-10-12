--==============================================================
-- Table: els_leergut_kopf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: els_leergut_kopf
   generated from Powerdesigner on Freitag, 23. September 2022 16:03:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.els_leergut_kopf (
barcode_leergut STRING(100) NOT NULL OPTIONS(description='Barcode des Leergut-Bons'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
bon_dat DATE NOT NULL OPTIONS(description='Datum des Pfandbons (End-Datum bei Bon-Erstellung)'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
bon_tmsp DATETIME OPTIONS(description='Zeitstempel des Pfandbons (End-Zeitstempel bei Bon-Erstellung)'),
bon_nr BIGNUMERIC(38,0) OPTIONS(description='Bon Nummer'),
system_bez STRING(100) OPTIONS(description='System Software, mit welcher der Pfandbon erstellt wurde'),
system_typ_bez STRING(100) OPTIONS(description='Technischer Typ-Name des Systems'),
system_hersteller_bez STRING(100) OPTIONS(description='Hersteller des Pfandautomaten, z.Bsp.: Tomra'),
bon_wert BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Wert des gesamten Bons'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (barcode_leergut, mandant_id) NOT ENFORCED
)
OPTIONS(description='ELS - Kopfdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.');