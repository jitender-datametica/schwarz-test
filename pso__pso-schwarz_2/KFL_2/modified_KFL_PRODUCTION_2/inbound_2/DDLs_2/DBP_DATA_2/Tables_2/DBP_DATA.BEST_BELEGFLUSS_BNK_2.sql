--==============================================================
-- Table: best_belegfluss_bnk_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_belegfluss_bnk_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_BELEGFLUSS_BNK_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege aus ebeln',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung aus ebelp',
   folge_beleg_id                      INTEGER     NOT NULL COMMENT 'Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung. aus ekbz.belnr',
   folge_beleg_pos_id                  INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. aus ekbz.buzei ',
   kj                                  INTEGER     NOT NULL COMMENT 'Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. aus ekbz.gjahr ',
   kond_stufe_id                       INTEGER     NOT NULL COMMENT 'Konditionsstufe aus stunr',
   kond_zaehl_id                       INTEGER     NOT NULL COMMENT 'Laufende Nummer der Kondition innerhalb der Stufe aus zaehk',
   vorgart_best_entw_id                VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Vorgangsart der Bestellentwicklung aus vgabe',
   best_entw_typ_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_2 des Folgebeleges:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein aus bewtp',
   betrag_kondition                    NUMBER(29,4)     NOT NULL COMMENT 'Konditionsbetrag aus dmbtr',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. aus shkzg',
   ref_lagerbew_beleg_id               VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Die Referenzbelegnummer kann die Belegnummer beim Geschäftspartner enthalten. aus xblnr',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   dat_erfasst                         DATE             NOT NULL COMMENT 'Erfassdatum aus cpudt',
   konditionsart_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart. aus kschl',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae',
   dat_buch                            DATE             NOT NULL COMMENT 'Buchungsdatum im Beleg aus budat.',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   betrag_wrbtr                        NUMBER(29,4)     NOT NULL COMMENT 'Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten',
   zeit_erfasst                        INTEGER     NOT NULL COMMENT 'Zeitpunkt der Datenerfassung aus cputm',
   soll_haben_kko                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Soll/Haben Kennzeichen korrespondierend zu bseg shkzg aus shkko',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_BELEGFLUSS_BNK PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, folge_beleg_id, folge_beleg_pos_id, kj, kond_stufe_id, kond_zaehl_id, vorgart_best_entw_id) NOT ENFORCED
)  COMMENT = 'RPW - Bezugsnebenkosten zur Bestellung (für IWT-Prozess) aus ekbz - MULTISET';

