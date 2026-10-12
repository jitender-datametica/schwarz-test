--==============================================================
-- Table: besch_lief_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_det_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 16:34:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.besch_lief_det_1  CLUSTER BY (
      mandant_id,
      dat_lief_soll
 )(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   lief_beleg_id                       INTEGER    NOT NULL COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.',
   lief_beleg_pos_id                   INTEGER    NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.',
   kj                                  INTEGER    NOT NULL COMMENT 'Kalenderjahr, Format JJJJ',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   menge_lief_ist_bme                  NUMBER(29,3)    COMMENT 'Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.',
   vorlage_beleg_id                    INTEGER    NOT NULL COMMENT 'Dieses Feld enthält die Nummer des Vorlagebeleges. (referenzierte Belegart noch unbekannt).',
   vorlage_beleg_pos_id                INTEGER    NOT NULL COMMENT 'Dieses Feld  enthält die Nummer der Position des Vorlagebeleges. (referenzierte Belegart noch unbekannt)',
   diff_id                             VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.',
   menge_lief_soll_kolli               NUMBER(29,3)    NOT NULL COMMENT 'Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  ',
   bruttogew                           NUMBER(29,3)    NOT NULL COMMENT 'Bruttogesamtgewicht aller Positionen der Lieferung. Das Bruttogewicht setzt sich aus dem Nettogewicht und dem Gewicht der Verpackung zusammen.',
   verk_menge_einh_id                  VARCHAR(3)      collate 'en-ci' NOT NULL COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_1 und Artikel_1 eine_1 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
   lagerort_id                         VARCHAR(4)      collate 'en-ci' NOT NULL COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
   menge_kolli                         NUMBER(29,3)    NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_1 ermittelt.',
   menge_lief_palette                  NUMBER(29,3)    COMMENT 'Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_1 und art_umrechnung_faktor_per_1 ermittelt.',
   annahmeverweigerung_id              INTEGER    NOT NULL COMMENT 'Dieses Attribut enthält die Gründe für die Annahmeverweigerung. Referenz zu der DWH Tabelle l_annahmeverweigerung_1',
   dat_haltbarkeit                     DATE            COMMENT 'Dieses Feld enthält das Mindesthaltbarkeitsdatum.',
   dat_aenderung                       DATE            NOT NULL COMMENT 'Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.',
   best_beleg_id                       INTEGER    NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)',
   best_beleg_pos_id                   INTEGER    NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellpositionen. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen) ',
   dat_lief_soll                       DATE            NOT NULL COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance',
   menge_lief_soll_bme                 NUMBER(29,3)    COMMENT 'Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.',
   menge_lief_ist_kolli                NUMBER(29,3)    COMMENT 'Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung',
   betrag_lief_ist                     NUMBER(29,4)    COMMENT 'redundantes Feld, um den join zur art_gp_wup_zu_per_1 zu sparen, berechnet anzahl_kolli*ek_netto_bnk*komponentenmenge.',
   betrag_lief_soll                    NUMBER(29,4)    COMMENT 'redundantes Feld, um den join zur art_gp_wup_zu_per_1 zu sparen, berechnet menge_lief_soll*ek_netto_bnk*komponentenmenge.',
   menge_lief_ist_lme                  NUMBER(29,3)    DEFAULT 0.000 NOT NULL COMMENT 'tatsächlich gelieferte Menge in Lagermengeneinheiten.',
   system_id                           INTEGER    NOT NULL DEFAULT 7 COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   aktions_pos_kz                      VARCHAR(1)      collate 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Kennzeichen Aktionsposition. Aktionspositionen sind mit X gekennzeichnet. Aus zzlvaktpos',
   besch_palette_fg                    INTEGER    COMMENT 'Ist gleich 1, wenn die Bestellung in Paletten erfolgte. Denormalisierung von besch_best_det.best_baismenge_einh_id',
   wrg_id                              VARCHAR(3)      collate 'en-ci' DEFAULT 'EUR' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   vk_netto_lief_soll                  NUMBER(29,4)    DEFAULT 0.0000 NOT NULL COMMENT 'Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung',
   vk_netto_lief_ist                   NUMBER(29,4)    DEFAULT 0.0000 NOT NULL COMMENT 'Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung',
   bestellart_id                       VARCHAR(4)      collate 'en-ci' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   CHARGE_ID                           VARCHAR(10)     collate 'en-ci' COMMENT 'Charge',
   uebg_chargensplit_pos               INTEGER    COMMENT 'Übergeordnete Position der Chargensplitposition',
   menge_lief_soll_orig                NUMBER(29,3)    COMMENT 'Originale Soll-Liefermenge',
   ausnahmecode_mengendiff             VARCHAR(4)      COMMENT 'Ausnahmecode Lager fuer Mengendifferenz',
   dat_art_bereitstellung              DATE            COMMENT 'Artikelbereitstellungsdatum',
   lief_pos_typ_id                     VARCHAR(4)      COMMENT 'Positionstyp Lieferung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'TP408 LVS - In dieser Tabelle sind die Belegpositionen der Lieferscheine aus der SAP Tabelle LIPS enthalten - MULTISET. Die dazugehörigen Kopfdaten befinden sich in der DWH Tabelle besch_lief_1 - MULTISET';
