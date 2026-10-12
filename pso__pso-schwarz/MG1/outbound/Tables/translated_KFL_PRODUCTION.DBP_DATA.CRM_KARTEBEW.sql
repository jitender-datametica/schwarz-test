CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.CRM_KARTEBEW (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet fur Beziehung Lager zu Verteilzentrum.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
KUNDENKARTE_ID STRING(255) NOT NULL
OPTIONS(description='Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT.'),
LOYALTY_BERECHTIGT_FG INTEGER NOT NULL
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf berechnet. (Logik für alte Daten folgt)'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
UMSATZ_NETTO_SA NUMERIC(29,4) OPTIONS(description='SA Umsatz vermindert um den Mehrwertsteuerbetrag.'),
UMSATZ_NETTO_AF NUMERIC(29,4) OPTIONS(description='AF Umsatz vermindert um den Mehrwertsteuerbetrag.'),
UMSATZ_BRUTTO_SA NUMERIC(29,4) OPTIONS(description='SA Umsatz.'),
UMSATZ_BRUTTO_AF NUMERIC(29,4) OPTIONS(description='AF Umsatz.'),
ANZ_BONS INTEGER OPTIONS(description='Bons, die eine Kundenkarte generiert.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, KUNDENKARTE_ID, DAT, LOYALTY_BERECHTIGT_FG) NOT ENFORCED
)
OPTIONS(description='EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).');