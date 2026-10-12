--==============================================================
-- Table: art_man_spanne_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_man_spanne_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_man_spanne_per_1 (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
dat_von DATE NOT NULL OPTIONS(description='gültig-ab aus gm_vld_fr'),
ek_faktor NUMERIC(9,4) OPTIONS(description='Faktor wird aus dem Original-Prozentwert errechnet aus kwert'),
dat_bis DATE NOT NULL OPTIONS(description='gültig-bis aus gm_vld_to'),
loesch_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Das Flag kennzeichnet die Kondition als gelöscht aus lvorm'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Faktoren zur EK Bewertung auf Ebene Artikel_1 der manuellen Spannenpflege aus a445');