--==============================================================
-- Table: flw_datenpool_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_datenpool_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_datenpool_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
verteilprozess_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Satzes aus dist_pr_data_id'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
datenpool_satzart_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wertevorrat: PN = Plannummer, DP = Disponentprognose, FP = Filialeprognose auf Zeitpunkt, AM = Produktionsauftrag (MyMeat), KA = Kommissionieraufträge, KP = Kommissionierpositionen, LI = Lieferpositionen aus zdps_satzart '),
dat_produktion DATE NOT NULL OPTIONS(description='Produktionsdatum aus zdps_prod_date'),
objekt_id INTEGER OPTIONS(description='enthält zum Beispiel die Beleg Id vbeln. Quelle ist object_number'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_lief DATE NOT NULL OPTIONS(description='Lieferdatum aus lieferdatum'),
dat_mat_bereitstllg DATE NOT NULL OPTIONS(description='Datum der Materialbereitstellung aus mbdat'),
zeit_mat_bereitstllg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zeitpunkt der Materialbereitstellung aus mbuhr'),
flw_tourart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Tourart, z.Bsp. PRG aus zdps_tour'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsmengeneinheit, z.Bsp. E1 aus vrkme'),
anz_kolli_produzier NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl produzierte Kolli aus zdps_bestmg_produziert'),
komm_auftrag_status_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommissionier-Auftrags-Status_1 aus zdps_kauf_status.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci' OPTIONS(description='externe Handing Unit_1 ID aus exidv. Compress'),
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Lagernummer aus lgnum'),
lief_beleg_id INTEGER NOT NULL OPTIONS(description='Nummer, die die Lieferung eindeutig identifiziert. Quelle vbeln'),
flw_art_id_verpackung BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 ID des Ladungsträgers = Verpackungsmaterial aus zdps_verp_matnr'),
verp_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Internationalen Maßeinheit aus msehi'),
menge_produziert NUMERIC(18,3) NOT NULL OPTIONS(description='Produzierte Menge aus menge_produziert'),
menge_prognose NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Prognosemenge aus bestmg_fil'),
kolli_vol BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Volumen des Kollis aus zdps_kolli_volum'),
kolli_vol_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der alternativen Mengeneinheit aus meinh'),
menge_absolut NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Absolute Menge aus zdps_am_absolut'),
menge_bestand NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Bestandsmenge aus atp_quantity_d'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (verteilprozess_id) NOT ENFORCED
) CLUSTER BY dat_lief
OPTIONS(description='FLW - Datenpool aus spdps_idp222010');