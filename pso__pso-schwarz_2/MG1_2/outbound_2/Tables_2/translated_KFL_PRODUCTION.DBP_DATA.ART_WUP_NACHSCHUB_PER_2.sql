CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_NACHSCHUB_PER_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum gültig ab -  im Format JJJJ-MM_2-TT'),
DAT_BIS DATE OPTIONS(description='Datum gültig bis - m Format JJJJ-MM_2-TT'),
MENGE_BESTAND_SOLL_MAX NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Maximaler Sollbestand (PRWOG)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='LIS - Nachschub: Mengen pro Kunde/Artikel_2 (tagesaktuell) - SAP RET - Tabelle WRPL');