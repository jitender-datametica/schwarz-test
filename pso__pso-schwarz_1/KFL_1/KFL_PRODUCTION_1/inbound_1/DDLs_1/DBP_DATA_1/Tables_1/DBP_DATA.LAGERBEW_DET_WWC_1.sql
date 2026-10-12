--==============================================================
-- Table: lagerbew_det_wwc_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbew_det_wwc_1
   generated from Powerdesigner on Mittwoch, 21. September 2022 16:47:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERBEW_DET_WWC_1 CLUSTER BY (
     MANDANT_ID,
     DAT_BUCH 
)(
   lagerbew_beleg_id                   NUMBER(18,0)    NOT NULL COMMENT 'Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.',
   lagerbew_beleg_pos_id               NUMBER(38,0)    NOT NULL COMMENT 'Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile ',
   kj                                  NUMBER(38,0)    NOT NULL COMMENT 'Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benietigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr ',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   dat_buch                            DATE            NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance!)',
   menge_bestand_bme                   NUMBER(18,3)    DEFAULT 0 NOT NULL COMMENT 'Gesamter bewerteter Bestand vor der Buchung in Basismengeneinheiten aus lbkum',
   wert_bestand                        NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Wert des gesamten bewerteten Bestands vor der Buchung. Aus salk3',
   system_id                           NUMBER(38,0)    COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   buchungskreis_id                    NUMBER(38,0)    DEFAULT -1 NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   shkum                               VARCHAR(1)      COLLATE 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Soll/Haben Kennzeichen der Umbewertung_1 aus der Quellspalte shkum',
   kostenstelle_id                     VARCHAR(10)     COLLATE 'en-ci' DEFAULT '          ' NOT NULL COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400 aus dem Quellfeld kostl. Hat eine_1 Referenz zur Tabelle kostenstelle_per_1',
   sachkonto_id                        VARCHAR(10)     COLLATE 'en-ci' DEFAULT '          ' NOT NULL COMMENT 'Alphanumerischer Wert aus dem Quellfeld sakto. Hat KEINE Referenz zur DWH-Tabelle l_sachkonto!',
   art_id_empfaenger                   NUMBER(38,0)    DEFAULT -1 NOT NULL COMMENT 'sbgebendes/empfangendes Material aus ummat. Referenz zur Tabelle art_1',
   lagerort_id_empfaenger              VARCHAR(4)      COLLATE 'en-ci' DEFAULT '    ' NOT NULL COMMENT 'Empfangender/Abgebender Lagerort aus umlgo. Referenz zu l_lagerort_1',
   art_id_bf                           NUMBER(38,0)    DEFAULT -1 NOT NULL COMMENT 'Artikel_1, auf dem der Bestand gefuehrt wird aus matbf. Referenz zu art_1',
   lagerbew_beleg_pos_mutter_id        NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Identifikation der unmittelbar uebergeordneten Zeile aus parent_id',
   line_id                             NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'eindeutige Identifikation einer Belegzeile. Quellfeld ist line_id',
   endlief_fg                          NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Flag zeigt an, ob eine_1 Lieferung abgeschlossen ist. Hergeleitet aus dem Endlieferungskennzeichen elikz',
   xruem_fg                            NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Rueckbuchung in die Vorperiode erlaubt Flag. Abgeleitet aus xruem',
   betrag_exbwr                        NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Extern eingegebener Buchungsbetrag in Hauswaehrung aus exbwr',
   betrag_bnk                          NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Bezugsnebenkosten in Hauswaehrung aus bnbtr',
   betrag_umbewertung                  NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Betrag der Umbewertung_1 beim Rueckbuchen in die Vorperiode aus dmbum',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LAGERBEW_DET_WWC PRIMARY KEY (lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, mandant_id) NOT ENFORCED
)  COMMENT = 'WWC - die nur im Produkt WWC benoetigten Spalten aus der Quelltabelle mseg werden in eine_1 eigene Struktur ausgelagert';
