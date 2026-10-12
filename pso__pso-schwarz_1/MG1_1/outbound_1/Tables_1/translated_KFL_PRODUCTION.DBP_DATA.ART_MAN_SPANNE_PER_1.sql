CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_MAN_SPANNE_PER_1 (
ART_ID INTEGER NOT NULL OPTIONS(description='Artikel_1 ID'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
KONDITIONSART_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
DAT_VON DATE NOT NULL OPTIONS(description='gültig-ab aus gm_vld_fr'),
EK_FAKTOR NUMERIC(9,4) OPTIONS(description='Faktor wird aus dem Original-Prozentwert errechnet aus kwert'),
DAT_BIS DATE NOT NULL OPTIONS(description='gültig-bis aus gm_vld_to'),
LOESCH_FG INTEGER NOT NULL OPTIONS(description='Das Flag kennzeichnet die Kondition als gelöscht aus lvorm'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Faktoren zur EK Bewertung auf Ebene Artikel_1 der manuellen Spannenpflege aus a445');