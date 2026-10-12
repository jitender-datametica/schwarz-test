--==============================================================
-- Table: best_belegfluss_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_belegfluss_2
   generated from Powerdesigner on Dienstag, 21. November 2023 17:07:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_BELEGFLUSS_2 CLUSTER BY (
     BEST_ENTW_TYP_ID,
     MANDANT_ID,
     DAT_BUCH 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellbelegposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellbelegpositionen. Aus ebelp',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln',
   kontierung_pos_id                   INTEGER     NOT NULL COMMENT 'Laufende Nummer der Kontierung: Nummer, die die Kontierung einer Bestellposition eindeutig definiert. aus zekkn',
   vorgart_best_entw_id                VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Vorgangsart der Bestellentwicklung. Referenziert die Tabelle l_vorgart_best_entw.Aus vgabe',
   folge_beleg_id                      INTEGER     NOT NULL COMMENT 'Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann  Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr ',
   folge_beleg_pos_id                  INTEGER     NOT NULL COMMENT 'Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei',
   kj                                  INTEGER     NOT NULL COMMENT 'Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr ',
   wup_id                              INTEGER     NOT NULL COMMENT 'Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup_2 eindeutig identifiziert werden. Quelle ist werks',
   nb_id                               INTEGER     NOT NULL COMMENT 'Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).',
   bestaetigung_lfd_nr                 INTEGER     NOT NULL COMMENT 'Laufende Nummer der Bestätigung. Referenz zu der Bestätigung. Aus etens',
   best_entw_typ_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_2 des Folgebeleges aus bewtp:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein',
   menge_anteil                        NUMBER(29,3)     NOT NULL COMMENT 'Mengenanteil der Gesamtbestellmenge, den Sie dieser Kontierungsposition zuordnen möchten. Aus bamng  Die eingegebene Menge bestimmt, welchen Anteil der Kosten Sie auf diese Kontierungsposition verteilen möchten. Aus bamng',
   menge_best                          NUMBER(29,3)     NOT NULL COMMENT 'Menge in Bestellpreismengeneinheit aus bpmng  ',
   lager_bewart_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung aus bwart.',
   dat_buch                            DATE             COMMENT 'Buchungsdatum des Beleges aus budat',
   menge_basis                         NUMBER(29,3)     COMMENT 'Menge in Basismeingeneinheit aus menge',
   betrag_ek_netto                     NUMBER(29,4)     COMMENT 'Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto (Quelle: dmbtr).',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Hauswährung. Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg',
   ref_beleg_id                        INTEGER     COMMENT 'Belegnummer des Referenzbeleges aus lfbnr',
   ref_beleg_pos_id                    INTEGER     COMMENT 'Position des Referenzbeleges aus lfpos',
   ref_gj                              INTEGER     COMMENT 'Geschäftsjahr des Referenzbeleges aus lfgja.',
   system_id                           INTEGER     NOT NULL DEFAULT 7 COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   betrag_wrbtr                        NUMBER(29,4)     COMMENT 'Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten',
   wrg_id_beleg                        VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_BELEGFLUSS PRIMARY KEY (mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id, vorgart_best_entw_id, folge_beleg_id, folge_beleg_pos_id, kj) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Quelle EKBE hinterlegt.';
