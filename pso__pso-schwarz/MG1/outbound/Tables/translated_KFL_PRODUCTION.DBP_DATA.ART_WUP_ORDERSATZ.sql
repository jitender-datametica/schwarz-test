CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_ORDERSATZ (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Betrieb'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ART_ID INTEGER NOT NULL OPTIONS(description='Artikelnummer'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum gültig ab'),
DAT_BIS DATE OPTIONS(description='Datum gültig bis'),
BEZUGSVORSCHRIFT_KZ STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezugsvorschrift'),
BEZUGSQUELLE_KZ STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezugsquelle'),
STATUS_F_AENDERUNGEN_FG INTEGER NOT NULL OPTIONS(description='Statusfeld F-Änderungen'),
KDIS_ZZSOPOMVKE_FG INTEGER NOT NULL OPTIONS(description='KDIS durch ZZSOPO-MVKE'),
KDIS_AUSLISTUNGSPROZESS_FG INTEGER NOT NULL OPTIONS(description='KDIS aus Auslistungsprozess'),
ARCHIVIERUNGS_KZ STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Archivierungskennzeichen'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, ART_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='FLW - ZEK-Ordersatz - Pflege der Bezugswege auf Artikel-Markt-Ebene - SAP RET - ZEKORDERSATZ01');