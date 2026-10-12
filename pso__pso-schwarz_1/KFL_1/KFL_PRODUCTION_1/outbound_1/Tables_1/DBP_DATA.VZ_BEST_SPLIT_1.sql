--==============================================================
-- Table: vz_best_split_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_best_split_1
   generated from Powerdesigner on Dienstag, 14. Januar 2025 13:26:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vz_best_split_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1           '),
gp_dispo_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Supplier_1 ID   (surrogate key)    '),
best_beleg_dispo_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bestell-ID '),
art_dispo_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird.             Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_1 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
bestellart_id STRING(4) OPTIONS(description='Bestellart   '),
einkaeufer_grp_id STRING(3) OPTIONS(description='Einkäufergruppe'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Nebenbetrieb'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'),
disponent_id STRING(3) OPTIONS(description='Disponent'),
gp_teilsortiment_id STRING(10) OPTIONS(description='Lieferantenteilsortiment       '),
fremd_lagerort_id STRING(4) OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung'),
art_id STRING(18) OPTIONS(description='Artikelnummer       '),
menge_gesamt BIGNUMERIC(38,0) OPTIONS(description='Menge Gesamt  '),
menge_iwt_gesamt BIGNUMERIC(38,0) OPTIONS(description='IWT Menge Gesamt  '),
menge_normal BIGNUMERIC(38,0) OPTIONS(description='Menge Normal     '),
menge_iwt BIGNUMERIC(38,0) OPTIONS(description='Menge IWT'),
menge_werbung_gesamt BIGNUMERIC(38,0) OPTIONS(description='Werbung Menge Gesamt '),
menge_werbung BIGNUMERIC(38,0) OPTIONS(description='Menge Werbung  '),
menge_einh_id STRING(3) OPTIONS(description='Bestellmengenheit'),
dat_lief_wunsch DATE OPTIONS(description='Lieferdatum der Position   '),
kontrakt_beleg_id INTEGER OPTIONS(description='Kontrakt'),
kontrakt_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Kontrakt Pos '),
best_beleg_id INTEGER OPTIONS(description='Belegnummer des Einkaufsbelegs'),
best_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='EinkBeleg Pos.   '),
vz_dispo_status_id BIGNUMERIC(38,0) OPTIONS(description='VZ Dispo Status_1   '),
palettenfaktor BIGNUMERIC(38,0) OPTIONS(description='Palettenfaktor   '),
gewicht_brutto_bme NUMERIC(16,3) OPTIONS(description='Bruttogewicht BME '),
dat_verfuegbarkeit DATE OPTIONS(description='Verfügb.Datum'),
faktor_bestme_bme NUMERIC(11,5) OPTIONS(description='Umrechenfaktor Bestellmengeheit in Basismengeneinheit    '),
gewicht_pal BIGNUMERIC(38,0) OPTIONS(description='Gewicht volle PAL       '),
gewicht_gesamt BIGNUMERIC(38,0) OPTIONS(description='Gesamtgewicht Position'),
anz_plaetze_max BIGNUMERIC(38,0) OPTIONS(description='Anzahl der maximalen Plätze   '),
gewicht_ladung_max BIGNUMERIC(38,0) OPTIONS(description='Maximal zulässiges Ladungsgewicht in KG'),
planlieferzeit BIGNUMERIC(38,0) OPTIONS(description='Planlieferzeit in Tagen '),
autodispo_fg BIGNUMERIC(38,0) OPTIONS(description='Feld zum Ankreuzen    '),
wg_id BIGNUMERIC(38,0) OPTIONS(description='Warengruppe     '),
menge_werbung_gesamt_pal NUMERIC(13,3) OPTIONS(description='Gesamtmenge Werbung PAL '),
menge_best_pal NUMERIC(13,3) OPTIONS(description='Bestellmenge PAL  '),
menge_best_werbung_pal NUMERIC(13,3) OPTIONS(description='Werbe. BestellM PAL  '),
menge_iwt_gesamt_pal NUMERIC(13,3) OPTIONS(description='IWT Gesamtmenge PAL    '),
menge_iwt_pal NUMERIC(13,3) OPTIONS(description='IWT BestellM PAL'),
splitsource_id STRING(1) OPTIONS(description='Splitsource '),
menge_bevorratung BIGNUMERIC(38,0) OPTIONS(description='Menge Bevorratung    '),
bedarfsnummer STRING(10) OPTIONS(description='Bedarfsnummer             '),
ursprungsprozess STRING(1) OPTIONS(description='Ursprungsprozess'),
best_vor_dispo_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_dispo_id, best_beleg_dispo_id, art_dispo_id) NOT ENFORCED
) OPTIONS(description='Order-Split ');