--==============================================================
-- Table: lagerbew_det_wwc_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbew_det_wwc_2
   generated from Powerdesigner on Mittwoch, 21. September 2022 16:47:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbew_det_wwc_2 (
lagerbew_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.'),
lagerbew_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile '),
kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benietigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr '),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
dat_buch DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_2 erfasst wird. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance!)'),
menge_bestand_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gesamter bewerteter Bestand vor der Buchung in Basismengeneinheiten aus lbkum'),
wert_bestand NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert des gesamten bewerteten Bestands vor der Buchung. Aus salk3'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
buchungskreis_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
shkum STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Soll/Haben Kennzeichen der Umbewertung_2 aus der Quellspalte shkum'),
kostenstelle_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='ID der Kostenstelle, z.Bsp. 9676-400 aus dem Quellfeld kostl. Hat eine_2 Referenz zur Tabelle kostenstelle_per_2'),
sachkonto_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Alphanumerischer Wert aus dem Quellfeld sakto. Hat KEINE Referenz zur DWH-Tabelle l_sachkonto!'),
art_id_empfaenger BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='sbgebendes/empfangendes Material aus ummat. Referenz zur Tabelle art_2'),
lagerort_id_empfaenger STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='Empfangender/Abgebender Lagerort aus umlgo. Referenz zu l_lagerort_2'),
art_id_bf BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Artikel_2, auf dem der Bestand gefuehrt wird aus matbf. Referenz zu art_2'),
lagerbew_beleg_pos_mutter_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Identifikation der unmittelbar uebergeordneten Zeile aus parent_id'),
line_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='eindeutige Identifikation einer Belegzeile. Quellfeld ist line_id'),
endlief_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob eine_2 Lieferung abgeschlossen ist. Hergeleitet aus dem Endlieferungskennzeichen elikz'),
xruem_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Rueckbuchung in die Vorperiode erlaubt Flag. Abgeleitet aus xruem'),
betrag_exbwr NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Extern eingegebener Buchungsbetrag in Hauswaehrung aus exbwr'),
betrag_bnk NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Bezugsnebenkosten in Hauswaehrung aus bnbtr'),
betrag_umbewertung NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag der Umbewertung_2 beim Rueckbuchen in die Vorperiode aus dmbum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat_buch
OPTIONS(description='WWC - die nur im Produkt WWC benoetigten Spalten aus der Quelltabelle mseg werden in eine_2 eigene Struktur ausgelagert');