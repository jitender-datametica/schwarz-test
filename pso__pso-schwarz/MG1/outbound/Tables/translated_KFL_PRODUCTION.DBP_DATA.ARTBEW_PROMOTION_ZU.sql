CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_PROMOTION_ZU (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT '),
BONUSKAUF_ID STRING(20) NOT NULL OPTIONS(description='In SAP vergebene ID, leider nur wahrscheinlich numerisch'),
KONDITIONSART_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
EAN_KASSE INTEGER DEFAULT 0 NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
BETRAG_PROMO_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsbetrag'),
BETRAG_MWST NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsbetrags'),
UMRECHNUNGSKURS NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs angereichert'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
MENGE_PROMO NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='abverkaufte Menge'),
UMSATZ_PROMO_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsumsatz'),
UMSATZ_MWST NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsumsatzes'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT, BONUSKAUF_ID, EAN_KASSE) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew');