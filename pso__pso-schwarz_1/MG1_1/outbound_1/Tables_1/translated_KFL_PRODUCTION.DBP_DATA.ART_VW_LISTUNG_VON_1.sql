CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_VW_LISTUNG_VON_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
VW_ID INTEGER NOT NULL OPTIONS(description='ID des Vertriebsweges'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
DAT_VON DATE NOT NULL
OPTIONS(description='Datum der letzten Listungsänderung. Pro Schlüssel ist nur das letzte Datum gespeichert'),
SM_ID INTEGER DEFAULT - 9 NOT NULL OPTIONS(description='Hier: groesste sm_id mit einer durchgaengigen Listung'),
DAT_ERST_LISTUNG DATE NOT NULL OPTIONS(description='Datum der ersten Listung'),
KSM_ID STRING(4) COLLATE 'und:ci' DEFAULT '-9' NOT NULL
OPTIONS(description='Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, VW_ID, ART_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Pro Artikel_1 und Vertriebsweg wird die Durchgängigkeit der Listung angezeigt');