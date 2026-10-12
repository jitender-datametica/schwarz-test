CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_VW_WUP_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
VW_ID INTEGER NOT NULL OPTIONS(description='ID des Vertriebsweges'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
RABATT_ZUL_FG INTEGER NOT NULL
OPTIONS(description='Flag zeigt an, ob ein Rabatt zulässig ist. Aus rbzul. Zulääsig = 1, sonst 0'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, VW_ID, ART_ID) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Artikel-Markt_Vertriebsweg Tabelle aus der Quelle wlk2');