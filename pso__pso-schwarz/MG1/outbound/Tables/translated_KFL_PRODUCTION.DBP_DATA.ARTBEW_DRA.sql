CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_DRA (
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
DAT DATE NOT NULL OPTIONS(description='Tagesdatum in der Form JJJJ-MM-TT'),
AKTION_ID STRING(10) NOT NULL OPTIONS(description='Eindeutige Kennung einer Aktion. Kommt aus der Kassenschnittstelle'),
PROMO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)'),
EAN_KASSE INTEGER NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN'),
MENGE NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
WRG STRING(3) NOT NULL OPTIONS(description='Währung, in der der Umsatz erzielt wurde'),
UMSATZ_NETTO NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
UMSATZ_MWST_BETRAG NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (WUP_ID, MANDANT_ID, BEWART_ID, GP_ID, NB_ID, ART_ID, DAT, AKTION_ID, PROMO_FG, EAN_KASSE) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Hier sind die Umsätze von ca. 10 Märkten zu\"Deutschland rundet auf\" hinterlegt');