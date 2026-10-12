--==============================================================
-- Table: besch_best_lief_lbs_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_best_lief_lbs_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_BEST_LIEF_LBS_1 CLUSTER BY (
     FEHLLIEFERUNG_KZ,
     MANDANT_ID,
     DAT_BEST_BELEG 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp',
   dat_buch                            DATE             NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird.
            Aus der Tabelle lagerbew_1',
   endlief_fg                          INTEGER     NOT NULL COMMENT 'Ist KEIN Flag. Gibt an, ob diese Position abgeschlossen, d. h. ob die dazugehörige Faktura beglichen ist. Aus der Tabelle besch_best_det. -1,wenn Liefermenge < Bestellmenge, =1, wenn  Liefermenge= Bestellmenge, 2, wenn  Liefermenge> Bestellmenge
            ',
   best_menge_orig_fg                  INTEGER     NOT NULL COMMENT 'Kennzeichnet den Satz mit der originalen Bestellmenge, da mehrere Teillieferungen mit Teilmengen vorhanden sein können',
   annahmeverweigerung_id              INTEGER     NOT NULL COMMENT 'Dieses Attribut enthält die Gründe für die Annahmeverweigerung. Referenz zu der Tabelle l_annahmeverweigerung_1 bei Lägern. Bei Märkten enthält die Spalte den Wert -1',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikel_1 ID',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   dat_best_beleg                      DATE             NOT NULL COMMENT 'Dieses Feld enthält das Belegdatum der Bestellung.',
   dat_lief_wunsch                     DATE             NOT NULL COMMENT 'Datum, an dem die Ware geliefert bzw. die Dienstleistung erbracht werden soll. Aus lief_einteilung_1',
   dat_lief_bewertung                  DATE             COMMENT 'Statistikrelevantes Lieferdatum aus lief_einteilung_1',
   menge_lief                          NUMBER(29,3)     NOT NULL COMMENT 'Gibt die gelieferte Menge in Bestellpreismengeneinheit an. Aus lagerbew_det_1',
   betrag_lagerbew_ek_n                NUMBER(29,4)     COMMENT 'Betrag der Belegposition in der Hauswährung des Buchungskreises auf Basis lder Menge aus lagerbew_det. Entspricht dem eknetto.',
   betrag_best_ek_n                    NUMBER(29,4)     COMMENT 'redundanter Wert zur Performancesteigerung im frontend, erspart den join zur art_gp_wup_zu_per_1, Berechnung menge_best_bme*eknetto*komponentenmenge.',
   menge_best_bme                      NUMBER(29,3)     NOT NULL COMMENT 'bestellte Menge des Artikel_1 dieser Position in Bestellmengeneinheit',
   fehllieferung_kz                    INTEGER     NOT NULL DEFAULT 0 COMMENT 'Zeigt Status_1 der Fehllieferung auf Belegebene, nicht Positionsebene an.0=keine Fehlmenge, -1=Fehlmenge in  einer Pos innerhalb spaet_lief_tage, -2=Fehlmenge in  einer Pos außerhalb spaet_lief_tage,1=mind 1 Position mit Fehlmenge außerh. Lieferlimit, 2=mind. 1 Position mit Fehlmenge innerhalb Lieferlimit',
   menge_lief_ist_kolli                NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Liefermenge in Kolli',
   menge_lief_soll_kolli               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Bestellmenge in Kolli',
   betrag_fehlmenge_vk_brutto          NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Fehlwert (Bestellmenge - WE-Menge) zum VK_1 brutto der Preiskategorie 1',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   lagerort_id                         VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort',
   loesch_fg_ekko                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Lösch-Flag bezogen auf den Bestellkopf besch_best_1',
   loesch_fg_ekpo                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Lösch-Flag bezogen auf die Bestellposition besch_best_det_1',
   selbstabhol_fg                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Das Flag kennzeichnet die Selbstabholung dieser Position, Wert 1 entspricht selbstabgeholt Wird aus Tabelle besch_best_det_1 übernommen',
   anzahl_lief                         INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Lieferungen mit Bewegungsart 101, 905 aus der Tabelle lagerbew_1',
   anzahl_lief_pos                     INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Lieferpositionen mit Bewegungsart 101, 905 aus der Tabelle lagerbew_det_1',
   lager_bewart_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung.',
   vk_netto_lief_soll                  NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung',
   vk_netto_lief_ist                   NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung',
   zeit_endlief_fg                     INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag : zeit_endlief',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_BEST_LIEF_LBS PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, dat_buch) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Denormalisierte Tabelle fuer LBS Logistikqualitaet auf Basis besch_best_det. Enthaelt Elemente aus lagerbew_det_1, besch_best_1, lief_einteilung_1';

