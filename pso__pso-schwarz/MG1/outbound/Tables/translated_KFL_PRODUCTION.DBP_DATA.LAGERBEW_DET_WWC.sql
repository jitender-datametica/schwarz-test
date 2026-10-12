DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.LAGERBEW_DET_WWC;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.LAGERBEW_DET_WWC (
LAGERBEW_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.'),
LAGERBEW_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile '),
KJ INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benietigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr '),
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
DAT_BUCH DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung erfasst wird. Das Feld wird aus der Kopftabelle\"vererbt\", um einen PPI darüber bilden zu können (Performance!)'),
MENGE_BESTAND_BME NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gesamter bewerteter Bestand vor der Buchung in Basismengeneinheiten aus lbkum'),
WERT_BESTAND NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert des gesamten bewerteten Bestands vor der Buchung. Aus salk3'),
SYSTEM_ID INTEGER OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
BUCHUNGSKREIS_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
SHKUM STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Soll/Haben Kennzeichen der Umbewertung aus der Quellspalte shkum'),
KOSTENSTELLE_ID STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='ID der Kostenstelle, z.Bsp. 9676-400 aus dem Quellfeld kostl. Hat eine Referenz zur Tabelle kostenstelle_per'),
SACHKONTO_ID STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Alphanumerischer Wert aus dem Quellfeld sakto. Hat KEINE Referenz zur DWH-Tabelle l_sachkonto!'),
ART_ID_EMPFAENGER INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='sbgebendes/empfangendes Material aus ummat. Referenz zur Tabelle art'),
LAGERORT_ID_EMPFAENGER STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='Empfangender/Abgebender Lagerort aus umlgo. Referenz zu l_lagerort'),
ART_ID_BF INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Artikel, auf dem der Bestand gefuehrt wird aus matbf. Referenz zu art'),
LAGERBEW_BELEG_POS_MUTTER_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Identifikation der unmittelbar uebergeordneten Zeile aus parent_id'),
LINE_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='eindeutige Identifikation einer Belegzeile. Quellfeld ist line_id'),
ENDLIEF_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob eine Lieferung abgeschlossen ist. Hergeleitet aus dem Endlieferungskennzeichen elikz'),
XRUEM_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Rueckbuchung in die Vorperiode erlaubt Flag. Abgeleitet aus xruem'),
BETRAG_EXBWR NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Extern eingegebener Buchungsbetrag in Hauswaehrung aus exbwr'),
BETRAG_BNK NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Bezugsnebenkosten in Hauswaehrung aus bnbtr'),
BETRAG_UMBEWERTUNG NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag der Umbewertung beim Rueckbuchen in die Vorperiode aus dmbum'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (LAGERBEW_BELEG_ID, LAGERBEW_BELEG_POS_ID, KJ, MANDANT_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT_BUCH
OPTIONS(description='WWC - die nur im Produkt WWC benoetigten Spalten aus der Quelltabelle mseg werden in eine eigene Struktur ausgelagert');