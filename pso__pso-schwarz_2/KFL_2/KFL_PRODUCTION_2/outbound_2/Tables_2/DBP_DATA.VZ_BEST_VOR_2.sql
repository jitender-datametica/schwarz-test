--==============================================================
-- Table: vz_best_vor_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_best_vor_2
   generated from Powerdesigner on Dienstag, 14. Januar 2025 13:26:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vz_best_vor_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2           '),
dat_plan DATE NOT NULL OPTIONS(description='Planungsdatum       '),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'),
gp_teilsortiment_id STRING(10) NOT NULL OPTIONS(description='Lieferantenteilsortiment       '),
lagerort_id STRING(4) NOT NULL OPTIONS(description='Lagerort '),
disponent_id STRING(3) NOT NULL OPTIONS(description='Disponent'),
art_id STRING(18) NOT NULL OPTIONS(description='Artikelnummer       '),
dat_best DATE NOT NULL OPTIONS(description='Bestelltag'),
dat_lief DATE NOT NULL OPTIONS(description='Liefertag  '),
bv_quelle_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='BV-Quelle '),
menge_best_gesamt BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge gesamt BME      '),
menge_best_normal BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge regulär BME  '),
menge_best_bevorratung BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge Bevorratung BME        '),
menge_best_iwt BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge IWT BME        '),
menge_best_werbung BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge Werbung BME       '),
menge_einh_id STRING(3) OPTIONS(description='Bestellmengenheit'),
umrech_faktor_best_bme NUMERIC(11,5) OPTIONS(description='Umrechenfaktor Bestellmengeheit in Basismengeneinheit'),
dat_verfuegbarkeit DATE OPTIONS(description='Verfügbarkeitsdatum '),
dat_bestandsperiode_ende DATE OPTIONS(description='Datum Ende Bestandsperiod'),
bestand BIGNUMERIC(38,0) OPTIONS(description='Gelesener Bestand oder ausgerechnet aus Bestandsprojektion '),
bestand_werbung BIGNUMERIC(38,0) OPTIONS(description='Gelesener PromoBestand o.ausgerechnet aus Bestandsprojektion'),
bestand_iwt BIGNUMERIC(38,0) OPTIONS(description='Gelesener IWBestand oder ausgerechnet aus Bestandsprojektion'),
reichweite NUMERIC(9,1) OPTIONS(description='Reichweite '),
dat_besdarfsperiode_ende DATE OPTIONS(description='Datum Ende Bedarfsperiode'),
bedarf_netto BIGNUMERIC(38,0) OPTIONS(description='Nettobedarf'),
bedarf_erweitert BIGNUMERIC(38,0) OPTIONS(description='Bedarf erweitert'),
bedarf_nach_mbm_art BIGNUMERIC(38,0) OPTIONS(description='nach MBM Artike'),
bedarf_nach_rundung BIGNUMERIC(38,0) OPTIONS(description='nach Rundung '),
bedarf_nach_dyn_rundung BIGNUMERIC(38,0) OPTIONS(description='nach dynamischer Rundung'),
bedarf_nach_mbm_lieferant BIGNUMERIC(38,0) OPTIONS(description='nach MBM Lieferant'),
vz_dispo_status_id BIGNUMERIC(38,0) OPTIONS(description='VZ Dispo Status.'),
art_dispo_id BIGNUMERIC(38,0)
OPTIONS(description='Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird.             Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
gp_dispo_id BIGNUMERIC(38,0)
OPTIONS(description='Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird.             Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
best_vor_dispo_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_plan, wup_id, gp_id, gp_teilsortiment_id, lagerort_id, disponent_id, art_id, dat_best,
 dat_lief, bv_quelle_id) NOT ENFORCED
) OPTIONS(description='Bestellvorschläge VZ-Lieferant [DC-level order proposals]             ');