CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_MAN_SPANNE_PER_1 (
ART_ID INTEGER NOT NULL OPTIONS(description='Artikel_1 ID'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
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
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Daten der manuellen Spannenpflege auf Marktebene aus a406');