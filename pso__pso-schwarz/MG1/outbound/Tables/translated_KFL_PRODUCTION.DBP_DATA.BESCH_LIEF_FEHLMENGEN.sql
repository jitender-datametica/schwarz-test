DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_FEHLMENGEN;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_FEHLMENGEN (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL OPTIONS(description='Artikel aus BESCH_LIEF_DET oder angereichert aus BESCH_BEST_DET(EKKO)'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Verteilzentrum aus BESCH_LIEF bzw. BESCH_BEST'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
EMPFAENGER_WUP_ID INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Empfangende Filiale aus BESCH_LIEF bzw. BESCH_BEST'),
EMPFAENGER_NB_ID INTEGER NOT NULL
OPTIONS(description='Nebenbetriebs-ID des empfangenden Marktes. In der Tabelle nur deswegen enthalten, weil FrontEnd ein bestehendes Attribut aus mandant, wup, nb verwendet'),
MANDANT_ID_EMPFAENGER INTEGER NOT NULL
OPTIONS(description='Der Empfaenger kann zu einem anderen Mandanten als der liefernde WUP gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
LAGERORT_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagerort_id'),
DAT_LIEF_SOLL DATE NOT NULL OPTIONS(description='Soll Lieferdatum'),
BESTELLART_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Angereichert aus BESCH_BEST(EKKO)'),
DIFF_ID STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Wenn Eintrag in BESCH_LIEF_DET vorhanden dann diff_id aus BESCH_LIEF_DET ansonsten leer'),
KUERZUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Wenn entsprechenden Eintrag in besch_lief_kuerzung vorhanden dann 1 ansonsten 0'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
MENGE_LIEF_SOLL_KOLLI NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='bestellte Menge in Kolli umgerechnet'),
MENGE_LIEF_IST_KOLLI NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='tatsächlich gelieferte Menge in Kolli'),
EK_NETTO_BNK_SOLL NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.'),
EK_NETTO_BNK_IST NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gelieferte Menge.'),
VK_NETTO_IST NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gelieferte Menge'),
VK_NETTO_SOLL NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge'),
UMRECHNUNGSKURS NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs angereichert'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
KUERZ_MENGE_LIEF_SOLL_KOLLI NUMERIC(18,3) NOT NULL OPTIONS(description='Gekürzte Soll-Liefermenge in Kolli'),
KUERZ_MENGE_LIEF_IST_KOLLI NUMERIC(18,3) NOT NULL OPTIONS(description='Gekürzte Ist-Liefermenge in Kolli'),
KUERZ_EK_NETTO_BNK_SOLL NUMERIC(18,4) NOT NULL
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'),
KUERZ_EK_NETTO_BNK_IST NUMERIC(18,4) NOT NULL
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Ist-Menge'),
KUERZ_VK_NETTO_SOLL NUMERIC(18,4) NOT NULL
OPTIONS(description='Verkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'),
KUERZ_VK_NETTO_IST NUMERIC(18,4) NOT NULL OPTIONS(description='Verkaufspreis  bezogen auf die gekürzte Ist-Menge'),
BEST_BELEG_ID INTEGER
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
BEST_BELEG_POS_ID INTEGER
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, WUP_ID, NB_ID, EMPFAENGER_WUP_ID, EMPFAENGER_NB_ID, MANDANT_ID_EMPFAENGER,
 DAT_LIEF_SOLL, KUERZUNG_FG) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT_LIEF_SOLL
OPTIONS(description='AIS KMO - Aggregat für nicht gelieferte Ware in KMO. Wird aus besch_lief_det und besch_lief_kuerzung versorgt und mit Preisen angereichert ');