--==============================================================
-- Table: vz_best_vor_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_best_vor_1
   generated from Powerdesigner on Dienstag, 14. Januar 2025 13:26:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VZ_BEST_VOR_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1           ',
   dat_plan                            DATE             NOT NULL COMMENT 'Planungsdatum       ',
   wup_id                              INTEGER     NOT NULL COMMENT 'Betrieb',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetrieb',
   gp_id                               INTEGER     NOT NULL COMMENT 'Kontonummer des Lieferanten bzw. Kreditors',
   gp_teilsortiment_id                 VARCHAR(10)      NOT NULL COMMENT 'Lieferantenteilsortiment       ',
   lagerort_id                         VARCHAR(4)       NOT NULL COMMENT 'Lagerort ',
   disponent_id                        VARCHAR(3)       NOT NULL COMMENT 'Disponent',
   art_id                              VARCHAR(18)      NOT NULL COMMENT 'Artikelnummer       ',
   dat_best                            DATE             NOT NULL COMMENT 'Bestelltag',
   dat_lief                            DATE             NOT NULL COMMENT 'Liefertag  ',
   bv_quelle_id                        INTEGER     NOT NULL COMMENT 'BV-Quelle ',
   menge_best_gesamt                   INTEGER     COMMENT 'Bestellmenge gesamt BME      ',
   menge_best_normal                   INTEGER     COMMENT 'Bestellmenge regulär BME  ',
   menge_best_bevorratung              INTEGER     COMMENT 'Bestellmenge Bevorratung BME        ',
   menge_best_iwt                      INTEGER     COMMENT 'Bestellmenge IWT BME        ',
   menge_best_werbung                  INTEGER     COMMENT 'Bestellmenge Werbung BME       ',
   menge_einh_id                       VARCHAR(3)       COMMENT 'Bestellmengenheit',
   umrech_faktor_best_bme              NUMBER(29,5)     COMMENT 'Umrechenfaktor Bestellmengeheit in Basismengeneinheit',
   dat_verfuegbarkeit                  DATE             COMMENT 'Verfügbarkeitsdatum ',
   dat_bestandsperiode_ende            DATE             COMMENT 'Datum Ende Bestandsperiod',
   bestand                             INTEGER     COMMENT 'Gelesener Bestand oder ausgerechnet aus Bestandsprojektion ',
   bestand_werbung                     INTEGER     COMMENT 'Gelesener PromoBestand o.ausgerechnet aus Bestandsprojektion',
   bestand_iwt                         INTEGER     COMMENT 'Gelesener IWBestand oder ausgerechnet aus Bestandsprojektion',
   reichweite                          NUMBER(29,1)      COMMENT 'Reichweite ',
   dat_besdarfsperiode_ende            DATE             COMMENT 'Datum Ende Bedarfsperiode',
   bedarf_netto                        INTEGER     COMMENT 'Nettobedarf',
   bedarf_erweitert                    INTEGER     COMMENT 'Bedarf erweitert',
   bedarf_nach_mbm_art                 INTEGER     COMMENT 'nach MBM Artike',
   bedarf_nach_rundung                 INTEGER     COMMENT 'nach Rundung ',
   bedarf_nach_dyn_rundung             INTEGER     COMMENT 'nach dynamischer Rundung',
   bedarf_nach_mbm_lieferant           INTEGER     COMMENT 'nach MBM Lieferant',
   vz_dispo_status_id                  INTEGER     COMMENT 'VZ Dispo Status.',
   art_dispo_id                        INTEGER     COMMENT 'Artikel_1 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. 
            Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_1 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. ',
   gp_dispo_id                         INTEGER     COMMENT 'Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird. 
            Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_1 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. ',
   best_vor_dispo_id                   INTEGER     COMMENT 'ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VZ_BEST_VOR PRIMARY KEY (mandant_id, dat_plan, wup_id, gp_id, gp_teilsortiment_id, lagerort_id, disponent_id, art_id, dat_best, dat_lief, bv_quelle_id) NOT ENFORCED
)  COMMENT = 'Bestellvorschläge VZ-Lieferant [DC-level order proposals]
             ';
