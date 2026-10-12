create or replace TABLE KFL_PRODUCTION.DBP_DATA.LAGERBEW_DET_WWC_1 cluster by (
     MANDANT_ID,
     DAT_BUCH 
)(
	LAGERBEW_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.',
	LAGERBEW_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile ',
	KJ NUMBER(38,0) NOT NULL COMMENT 'Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benietigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr ',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	DAT_BUCH DATE NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Das Feld wird aus der Kopftabelle \"vererbt\", um einen PPI darüber bilden zu können (Performance!)',
	MENGE_BESTAND_BME NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Gesamter bewerteter Bestand vor der Buchung in Basismengeneinheiten aus lbkum',
	WERT_BESTAND NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Wert des gesamten bewerteten Bestands vor der Buchung. Aus salk3',
	SYSTEM_ID NUMBER(38,0) COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	BUCHUNGSKREIS_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
	SHKUM VARCHAR(1) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Soll/Haben Kennzeichen der Umbewertung_1 aus der Quellspalte shkum',
	KOSTENSTELLE_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400 aus dem Quellfeld kostl. Hat eine_1 Referenz zur Tabelle kostenstelle_per_1',
	SACHKONTO_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Alphanumerischer Wert aus dem Quellfeld sakto. Hat KEINE Referenz zur DWH-Tabelle l_sachkonto!',
	ART_ID_EMPFAENGER NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'sbgebendes/empfangendes Material aus ummat. Referenz zur Tabelle art_1',
	LAGERORT_ID_EMPFAENGER VARCHAR(4) NOT NULL COLLATE 'en-ci' DEFAULT '    ' COMMENT 'Empfangender/Abgebender Lagerort aus umlgo. Referenz zu l_lagerort_1',
	ART_ID_BF NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Artikel_1, auf dem der Bestand gefuehrt wird aus matbf. Referenz zu art_1',
	LAGERBEW_BELEG_POS_MUTTER_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Identifikation der unmittelbar uebergeordneten Zeile aus parent_id',
	LINE_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'eindeutige Identifikation einer Belegzeile. Quellfeld ist line_id',
	ENDLIEF_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Flag zeigt an, ob eine_1 Lieferung abgeschlossen ist. Hergeleitet aus dem Endlieferungskennzeichen elikz',
	XRUEM_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Rueckbuchung in die Vorperiode erlaubt Flag. Abgeleitet aus xruem',
	BETRAG_EXBWR NUMBER(18,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Extern eingegebener Buchungsbetrag in Hauswaehrung aus exbwr',
	BETRAG_BNK NUMBER(18,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Bezugsnebenkosten in Hauswaehrung aus bnbtr',
	BETRAG_UMBEWERTUNG NUMBER(18,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Betrag der Umbewertung_1 beim Rueckbuchen in die Vorperiode aus dmbum',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	constraint PK_LAGERBEW_DET_WWC primary key (LAGERBEW_BELEG_ID, LAGERBEW_BELEG_POS_ID, KJ, MANDANT_ID)
)COMMENT='WWC - die nur im Produkt WWC benoetigten Spalten aus der Quelltabelle mseg werden in eine_1 eigene Struktur ausgelagert'
;