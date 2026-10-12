--==============================================================
-- Table: besch_rech_det_kont
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_det_kont
   generated from Powerdesigner on Mittwoch, 10. August 2022 13:57:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_RECH_DET_KONT (
   rech_beleg_id                       INTEGER    NOT NULL COMMENT 'Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaeftsjahr kann eine Rechnung eindeutig identifiziert werden.',
   rech_beleg_kont_pos_id              INTEGER    NOT NULL COMMENT 'Fortlaufende Positionnummer pro Eingangsrechnung. Die Positionsnummer ist mit der Rehnungsnummer und dem Geschaeftsjahr in dieser Tabelle eindeutig.',
   gj                                  INTEGER    NOT NULL COMMENT 'Geschaeftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine Rechnung eindeutig identifiziert werden.',
   system_id                           INTEGER    NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER    NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   kontierungsblock_nr                 INTEGER    NOT NULL COMMENT 'Nummer der Kontierungsblocks.',
   row_grund_id                        VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die ROW Gruende (Rechnung ohne Wareneingang).',
   dat_row                             DATE            COMMENT 'Datum der Rechnugsposition ohne Wareneingang.',
   menge                               NUMBER(29,3)    COMMENT 'Anzahl der Einheiten dieser Position.',
   basismenge_einh_id                  VARCHAR(3)      COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.',
   sap_mwst_id                         VARCHAR(2)      COMMENT 'Schluessel der Mehrwertsteuer. Referenz zu der Tabelle mwst_per.',
   art_id                              INTEGER    COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   betrag_beleg                        NUMBER(29,4)    COMMENT 'Netto Betrag der Position aus wrbtr.',
   dat_bezug                           DATE            COMMENT 'Bezugsdatum dieser Position;',
   buch_grund_int_id                   VARCHAR(3)      COMMENT 'Eindeutiger Schluessel fuer die internen Buchungsgruende der Rechnungen auf Kopf- und Positionsebene.',
   buch_grund_ext_id                   VARCHAR(3)      COMMENT 'Eindeutiger Schluessel fuer die externe Buchungsgruende der Rechnungen auf Kopf- und Positionsebene.',
   menge_gp_best                       NUMBER(29,3)    COMMENT 'Menge nach Angabe des Lieferanten (aus Rechnung)',
   betrag_gp_best                      NUMBER(29,4)    COMMENT 'Betrag nach Angabe des Lieferanten (aus Rechnung) aus  zzrpbwwr_co.',
   gp_fehlerart_id                     VARCHAR(1)      COMMENT 'Eindeutiger Schluessel für die Fehlerarten eines Lieferanten z. B. Preis- oder Konditionsfehler.',
   korrekturart_id                     VARCHAR(1)      COMMENT 'Eindeutiger Fachschluessel für Korrekturarten bei Mengen- oder Konditionsfehler eines Lieferanten.',
   betrag_gp_fehler_netto              NUMBER(29,2)    COMMENT 'Nettobetrag des Lieferantenfehlers.',
   rech_kontoart_id                    VARCHAR(1)      COMMENT 'Eindeutiger Fachschluessel für die Kontoart der Rechnungspositionen ohne Bezug zu einer Bestellung.',
   sperrgrund_betrag_fg                INTEGER    COMMENT 'Dieses Flag kennzeichnet, dass der Sperrgrund aus der Betragshoehe resultiert. 1 = ja, 0 = nein',
   wup_id                              INTEGER    COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   betrag_netto                        NUMBER(29,4)    COMMENT 'Nettopreis, der sich aus dem Nettowert dividiert durch die Auftragsmenge ergibt.Der Nettopreis bezieht sich immer auf die Konditionsmengeneinheit und die Konditionspreiseinheit der betreffenden Kondition aus zzrpnetpr.',
   retourenpos_fg                      INTEGER    COMMENT 'Das Flag gibt an, ob die Position eine Retourenposition ist. ',
   wg_id                               INTEGER    COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER    COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   sachkonto_id                        VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Nummer des Sachkontos aus der Spalte saknr. Zur Zeit kene Referenz auf eine Stammtabelle',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_RECH_DET_KONT PRIMARY KEY (rech_beleg_id, rech_beleg_kont_pos_id, gj, system_id, mandant_id, kontierungsblock_nr) NOT ENFORCED
)  COMMENT = 'RPW - Faktentabelle der Postionen der Eingangsrechnung ohne Bezug zu einer Bestellung (z. B. ungeplante Bezugskosten). Quelle fuer diese Daten ist die SAP Tabelle RBCO.';