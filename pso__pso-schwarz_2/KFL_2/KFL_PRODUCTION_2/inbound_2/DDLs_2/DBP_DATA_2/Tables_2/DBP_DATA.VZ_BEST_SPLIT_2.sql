--==============================================================
-- Table: vz_best_split_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_best_split_2
   generated from Powerdesigner on Dienstag, 14. Januar 2025 13:26:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VZ_BEST_SPLIT_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2           ',
   gp_dispo_id                         NUMBER(38,0)     NOT NULL COMMENT 'Supplier_2 ID   (surrogate key)    ',
   best_beleg_dispo_id                 NUMBER(38,0)     NOT NULL COMMENT 'Bestell-ID ',
   art_dispo_id                        NUMBER(15,0)     NOT NULL COMMENT 'Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. 
            Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. ',
   bestellart_id                       VARCHAR(4)       COMMENT 'Bestellart   ',
   einkaeufer_grp_id                   VARCHAR(3)       COMMENT 'Einkäufergruppe',
   wup_id                              NUMBER(38,0)     COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)     COMMENT 'Nebenbetrieb',
   gp_id                               NUMBER(38,0)     COMMENT 'Kontonummer des Lieferanten bzw. Kreditors',
   disponent_id                        VARCHAR(3)       COMMENT 'Disponent',
   gp_teilsortiment_id                 VARCHAR(10)      COMMENT 'Lieferantenteilsortiment       ',
   fremd_lagerort_id                   VARCHAR(4)       COMMENT 'Vorschlagslagerort für Fremdbeschaffung',
   art_id                              VARCHAR(18)      COMMENT 'Artikelnummer       ',
   menge_gesamt                        NUMBER(38,0)     COMMENT 'Menge Gesamt  ',
   menge_iwt_gesamt                    NUMBER(38,0)     COMMENT 'IWT Menge Gesamt  ',
   menge_normal                        NUMBER(38,0)     COMMENT 'Menge Normal     ',
   menge_iwt                           NUMBER(38,0)     COMMENT 'Menge IWT',
   menge_werbung_gesamt                NUMBER(38,0)     COMMENT 'Werbung Menge Gesamt ',
   menge_werbung                       NUMBER(38,0)     COMMENT 'Menge Werbung  ',
   menge_einh_id                       VARCHAR(3)       COMMENT 'Bestellmengenheit',
   dat_lief_wunsch                     DATE             COMMENT 'Lieferdatum der Position   ',
   kontrakt_beleg_id                   NUMBER(18,0)     COMMENT 'Kontrakt',
   kontrakt_beleg_pos_id               NUMBER(38,0)     COMMENT 'Kontrakt Pos ',
   best_beleg_id                       NUMBER(18,0)     COMMENT 'Belegnummer des Einkaufsbelegs',
   best_beleg_pos_id                   NUMBER(38,0)     COMMENT 'EinkBeleg Pos.   ',
   vz_dispo_status_id                  NUMBER(38,0)     COMMENT 'VZ Dispo Status_2   ',
   palettenfaktor                      NUMBER(38,0)     COMMENT 'Palettenfaktor   ',
   gewicht_brutto_bme                  NUMBER(16,3)     COMMENT 'Bruttogewicht BME ',
   dat_verfuegbarkeit                  DATE             COMMENT 'Verfügb.Datum',
   faktor_bestme_bme                   NUMBER(11,5)     COMMENT 'Umrechenfaktor Bestellmengeheit in Basismengeneinheit    ',
   gewicht_pal                         NUMBER(38,0)     COMMENT 'Gewicht volle PAL       ',
   gewicht_gesamt                      NUMBER(38,0)     COMMENT 'Gesamtgewicht Position',
   anz_plaetze_max                     NUMBER(38,0)     COMMENT 'Anzahl der maximalen Plätze   ',
   gewicht_ladung_max                  NUMBER(38,0)     COMMENT 'Maximal zulässiges Ladungsgewicht in KG',
   planlieferzeit                      NUMBER(38,0)     COMMENT 'Planlieferzeit in Tagen ',
   autodispo_fg                        NUMBER(38,0)     COMMENT 'Feld zum Ankreuzen    ',
   wg_id                               NUMBER(38,0)     COMMENT 'Warengruppe     ',
   menge_werbung_gesamt_pal            NUMBER(13,3)     COMMENT 'Gesamtmenge Werbung PAL ',
   menge_best_pal                      NUMBER(13,3)     COMMENT 'Bestellmenge PAL  ',
   menge_best_werbung_pal              NUMBER(13,3)     COMMENT 'Werbe. BestellM PAL  ',
   menge_iwt_gesamt_pal                NUMBER(13,3)     COMMENT 'IWT Gesamtmenge PAL    ',
   menge_iwt_pal                       NUMBER(13,3)     COMMENT 'IWT BestellM PAL',
   splitsource_id                      VARCHAR(1)       COMMENT 'Splitsource ',
   menge_bevorratung                   NUMBER(38,0)     COMMENT 'Menge Bevorratung    ',
   bedarfsnummer                       VARCHAR(10)      COMMENT 'Bedarfsnummer             ',
   ursprungsprozess                    VARCHAR(1)       COMMENT 'Ursprungsprozess',
   best_vor_dispo_id                   NUMBER(38,0)     COMMENT 'ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VZ_BEST_SPLIT PRIMARY KEY (mandant_id, gp_dispo_id, best_beleg_dispo_id, art_dispo_id) NOT ENFORCED
)  COMMENT = 'Order-Split ';
