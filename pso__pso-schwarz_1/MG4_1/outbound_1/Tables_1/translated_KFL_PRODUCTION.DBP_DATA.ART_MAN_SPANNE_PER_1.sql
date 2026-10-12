CREATE OR REPLACE TABLE kfl_production_dbp_data.art_man_spanne_per_1 (
art_id INTEGER NOT NULL OPTIONS(description='Artikel_1 ID'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
dat_von DATE NOT NULL OPTIONS(description='gültig-ab aus gm_vld_fr'),
ek_faktor NUMERIC(9,4) OPTIONS(description='Faktor wird aus dem Original-Prozentwert errechnet aus kwert'),
dat_bis DATE NOT NULL OPTIONS(description='gültig-bis aus gm_vld_to'),
loesch_fg INTEGER NOT NULL OPTIONS(description='Das Flag kennzeichnet die Kondition als gelöscht aus lvorm'),
system_id INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Faktoren zur EK Bewertung auf Ebene Artikel_1 der manuellen Spannenpflege aus a445');