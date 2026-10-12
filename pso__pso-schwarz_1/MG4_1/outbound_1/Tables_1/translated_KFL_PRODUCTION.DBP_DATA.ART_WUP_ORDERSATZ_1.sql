CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wup_ordersatz_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Betrieb'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer'),
dat_von DATE NOT NULL OPTIONS(description='Datum gültig ab'),
dat_bis DATE OPTIONS(description='Datum gültig bis'),
bezugsvorschrift_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezugsvorschrift'),
bezugsquelle_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezugsquelle'),
status_f_aenderungen_fg INTEGER NOT NULL OPTIONS(description='Statusfeld F-Änderungen'),
kdis_zzsopomvke_fg INTEGER NOT NULL OPTIONS(description='KDIS durch ZZSOPO-MVKE_1'),
kdis_auslistungsprozess_fg INTEGER NOT NULL OPTIONS(description='KDIS aus Auslistungsprozess'),
archivierungs_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Archivierungskennzeichen'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von) NOT ENFORCED
) OPTIONS(description='FLW - ZEK_1-Ordersatz - Pflege der Bezugswege auf Artikel_1-Markt-Ebene - SAP RET - ZEKORDERSATZ01_1');