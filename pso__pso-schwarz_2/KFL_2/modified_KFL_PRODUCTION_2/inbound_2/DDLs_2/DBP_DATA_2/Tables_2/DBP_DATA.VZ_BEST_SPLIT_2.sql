--==============================================================
-- Table: vz_best_split_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_best_split_2
   generated from Powerdesigner on Dienstag, 14. Januar 2025 13:26:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VZ_BEST_SPLIT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2           ',
   gp_dispo_id                         INTEGER     NOT NULL COMMENT 'Supplier_2 ID   (surrogate key)    ',
   best_beleg_dispo_id                 INTEGER     NOT NULL COMMENT 'Bestell-ID ',
   art_dispo_id                        INTEGER     NOT NULL COMMENT 'Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. 
            Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. ',
   bestellart_id                       VARCHAR(4)       COMMENT 'Bestellart   ',
   einkaeufer_grp_id                   VARCHAR(3)       COMMENT 'Einkäufergruppe',
   wup_id                              INTEGER     COMMENT 'Betrieb',
   nb_id                               INTEGER     COMMENT 'Nebenbetrieb',
   gp_id                               INTEGER     COMMENT 'Kontonummer des Lieferanten bzw. Kreditors',
   disponent_id                        VARCHAR(3)       COMMENT 'Disponent',
   gp_teilsortiment_id                 VARCHAR(10)      COMMENT 'Lieferantenteilsortiment       ',
   fremd_lagerort_id                   VARCHAR(4)       COMMENT 'Vorschlagslagerort für Fremdbeschaffung',
   art_id                              VARCHAR(18)      COMMENT 'Artikelnummer       ',
   menge_gesamt                        INTEGER     COMMENT 'Menge Gesamt  ',
   menge_iwt_gesamt                    INTEGER     COMMENT 'IWT Menge Gesamt  ',
   menge_normal                        INTEGER     COMMENT 'Menge Normal     ',
   menge_iwt                           INTEGER     COMMENT 'Menge IWT',
   menge_werbung_gesamt                INTEGER     COMMENT 'Werbung Menge Gesamt ',
   menge_werbung                       INTEGER     COMMENT 'Menge Werbung  ',
   menge_einh_id                       VARCHAR(3)       COMMENT 'Bestellmengenheit',
   dat_lief_wunsch                     DATE             COMMENT 'Lieferdatum der Position   ',
   kontrakt_beleg_id                   INTEGER     COMMENT 'Kontrakt',
   kontrakt_beleg_pos_id               INTEGER     COMMENT 'Kontrakt Pos ',
   best_beleg_id                       INTEGER     COMMENT 'Belegnummer des Einkaufsbelegs',
   best_beleg_pos_id                   INTEGER     COMMENT 'EinkBeleg Pos.   ',
   vz_dispo_status_id                  INTEGER     COMMENT 'VZ Dispo Status_2   ',
   palettenfaktor                      INTEGER     COMMENT 'Palettenfaktor   ',
   gewicht_brutto_bme                  NUMBER(29,3)     COMMENT 'Bruttogewicht BME ',
   dat_verfuegbarkeit                  DATE             COMMENT 'Verfügb.Datum',
   faktor_bestme_bme                   NUMBER(29,5)     COMMENT 'Umrechenfaktor Bestellmengeheit in Basismengeneinheit    ',
   gewicht_pal                         INTEGER     COMMENT 'Gewicht volle PAL       ',
   gewicht_gesamt                      INTEGER     COMMENT 'Gesamtgewicht Position',
   anz_plaetze_max                     INTEGER     COMMENT 'Anzahl der maximalen Plätze   ',
   gewicht_ladung_max                  INTEGER     COMMENT 'Maximal zulässiges Ladungsgewicht in KG',
   planlieferzeit                      INTEGER     COMMENT 'Planlieferzeit in Tagen ',
   autodispo_fg                        INTEGER     COMMENT 'Feld zum Ankreuzen    ',
   wg_id                               INTEGER     COMMENT 'Warengruppe     ',
   menge_werbung_gesamt_pal            NUMBER(29,3)     COMMENT 'Gesamtmenge Werbung PAL ',
   menge_best_pal                      NUMBER(29,3)     COMMENT 'Bestellmenge PAL  ',
   menge_best_werbung_pal              NUMBER(29,3)     COMMENT 'Werbe. BestellM PAL  ',
   menge_iwt_gesamt_pal                NUMBER(29,3)     COMMENT 'IWT Gesamtmenge PAL    ',
   menge_iwt_pal                       NUMBER(29,3)     COMMENT 'IWT BestellM PAL',
   splitsource_id                      VARCHAR(1)       COMMENT 'Splitsource ',
   menge_bevorratung                   INTEGER     COMMENT 'Menge Bevorratung    ',
   bedarfsnummer                       VARCHAR(10)      COMMENT 'Bedarfsnummer             ',
   ursprungsprozess                    VARCHAR(1)       COMMENT 'Ursprungsprozess',
   best_vor_dispo_id                   INTEGER     COMMENT 'ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VZ_BEST_SPLIT PRIMARY KEY (mandant_id, gp_dispo_id, best_beleg_dispo_id, art_dispo_id) NOT ENFORCED
)  COMMENT = 'Order-Split ';
