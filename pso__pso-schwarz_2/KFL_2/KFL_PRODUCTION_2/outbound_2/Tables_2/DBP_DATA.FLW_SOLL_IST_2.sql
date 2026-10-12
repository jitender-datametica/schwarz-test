--==============================================================
-- Table: flw_soll_ist_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_soll_ist_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_soll_ist_2 (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
charge_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Charge aus charg'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_soll_ist DATE NOT NULL OPTIONS(description='Datum'),
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr. Compress blank'),
wechsel_id INTEGER NOT NULL
OPTIONS(description='Die Wechsel ID wird als fortlaufende Nummer vonMyMeat erzeugt, z.Bsp. bei Wechsel der Tierart oder des Lieferanten im WE'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
menge_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Menge in Basismengeneinheiten aus menge'),
menge_dme NUMERIC(18,3) NOT NULL OPTIONS(description='Menge in doppelter Mengeneinheit aus dmeng'),
dme_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='doppelte Mengeneinheit aus dmein'),
basismenge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='ID der Internationalen Maßeinheit aus msehi'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Bestellbeleg aus ebeln'),
betrag_soll_ist NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Vorschlagswert aus price'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
trennprozess_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL'),
schnittliste_id INTEGER NOT NULL OPTIONS(description='ID der Schnittliste aus ctlnr. Referenz zu flw_schnittliste_2'),
input_material_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des inputmaterials aus itypm. Z.Bsp. I = Input (Zukauf), A = Eingang (Vorstufe), N = Gesamt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, werk_id, dat_soll_ist, wechsel_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Z-Tabelle zur Soll/ Istermittlung im Fleischwerk aus zfw_soll_ist');