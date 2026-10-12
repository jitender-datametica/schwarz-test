--==============================================================
-- Table: besch_best_lief_lbs_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_best_lief_lbs_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_best_lief_lbs_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp'),
dat_buch DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_2 erfasst wird.            Aus der Tabelle lagerbew_2'),
endlief_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ist KEIN Flag. Gibt an, ob diese Position abgeschlossen, d. h. ob die dazugehörige Faktura beglichen ist. Aus der Tabelle besch_best_det. -1,wenn Liefermenge < Bestellmenge, =1, wenn  Liefermenge= Bestellmenge, 2, wenn  Liefermenge> Bestellmenge            '),
best_menge_orig_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet den Satz mit der originalen Bestellmenge, da mehrere Teillieferungen mit Teilmengen vorhanden sein können'),
annahmeverweigerung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Attribut enthält die Gründe für die Annahmeverweigerung. Referenz zu der Tabelle l_annahmeverweigerung_2 bei Lägern. Bei Märkten enthält die Spalte den Wert -1'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 ID'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
dat_best_beleg DATE NOT NULL OPTIONS(description='Dieses Feld enthält das Belegdatum der Bestellung.'),
dat_lief_wunsch DATE NOT NULL
OPTIONS(description='Datum, an dem die Ware geliefert bzw. die Dienstleistung erbracht werden soll. Aus lief_einteilung_2'),
dat_lief_bewertung DATE OPTIONS(description='Statistikrelevantes Lieferdatum aus lief_einteilung_2'),
menge_lief NUMERIC(18,3) NOT NULL
OPTIONS(description='Gibt die gelieferte Menge in Bestellpreismengeneinheit an. Aus lagerbew_det_2'),
betrag_lagerbew_ek_n NUMERIC(18,4)
OPTIONS(description='Betrag der Belegposition in der Hauswährung des Buchungskreises auf Basis lder Menge aus lagerbew_det. Entspricht dem eknetto.'),
betrag_best_ek_n NUMERIC(18,4)
OPTIONS(description='redundanter Wert zur Performancesteigerung im frontend, erspart den CROSS JOIN zur art_gp_wup_zu_per_2, Berechnung menge_best_bme*eknetto*komponentenmenge.'),
menge_best_bme NUMERIC(18,3) NOT NULL
OPTIONS(description='bestellte Menge des Artikel_2 dieser Position in Bestellmengeneinheit'),
fehllieferung_kz BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zeigt Status_2 der Fehllieferung auf Belegebene, nicht Positionsebene an.0=keine Fehlmenge, -1=Fehlmenge in  einer Pos innerhalb spaet_lief_tage, -2=Fehlmenge in  einer Pos außerhalb spaet_lief_tage,1=mind 1 Position mit Fehlmenge außerh. Lieferlimit, 2=mind. 1 Position mit Fehlmenge innerhalb Lieferlimit'),
menge_lief_ist_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Liefermenge in Kolli'),
menge_lief_soll_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Bestellmenge in Kolli'),
betrag_fehlmenge_vk_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Fehlwert (Bestellmenge - WE-Menge) zum VK_2 brutto der Preiskategorie 1'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
lagerort_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
loesch_fg_ekko BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Lösch-Flag bezogen auf den Bestellkopf besch_best_2'),
loesch_fg_ekpo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Lösch-Flag bezogen auf die Bestellposition besch_best_det_2'),
selbstabhol_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Das Flag kennzeichnet die Selbstabholung dieser Position, Wert 1 entspricht selbstabgeholt Wird aus Tabelle besch_best_det_2 übernommen'),
anzahl_lief BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Lieferungen mit Bewegungsart 101, 905 aus der Tabelle lagerbew_2'),
anzahl_lief_pos BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Lieferpositionen mit Bewegungsart 101, 905 aus der Tabelle lagerbew_det_2'),
lager_bewart_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung.'),
vk_netto_lief_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
vk_netto_lief_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
zeit_endlief_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag : zeit_endlief'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, dat_buch) NOT ENFORCED
) CLUSTER BY fehllieferung_kz, mandant_id, dat_best_beleg
OPTIONS(description='TP2_AIS - Denormalisierte Tabelle fuer LBS Logistikqualitaet auf Basis besch_best_det. Enthaelt Elemente aus lagerbew_det_2, besch_best_2, lief_einteilung_2');