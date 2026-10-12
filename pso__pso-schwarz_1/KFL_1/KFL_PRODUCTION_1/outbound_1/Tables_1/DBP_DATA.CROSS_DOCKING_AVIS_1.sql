--==============================================================
-- Table: cross_docking_avis_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cross_docking_avis_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cross_docking_avis_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
cd_beleg_id INTEGER NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
cd_typ_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des CD-Belegs, z.Bsp. 2 ist CD Fleischwerk. Quelle ist zzlvcd'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
kunde_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Warenempfaenger (entspricht einer Marktnummermit führenden Nullen) Quelle ist zzlvcdwenum'),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll.Quelle ist lfdat'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Original Nummer der Versandeinheit (NVE) Quelle ist zzlvcdnve'),
lief_beleg_ext_id STRING(40) COLLATE 'und:ci' OPTIONS(description='Externe Identifikation des Lieferscheins aus lifex'),
cd_status_id BIGNUMERIC(38,0)
OPTIONS(description='CD Status_1 aus zzlvcdstatv- in den Daten kommt 1 oder 2 vor. Bedeutung nicht klar'),
mandant_id_kunde BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als der WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, cd_beleg_id, wup_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Cross Docking Belege aus der Quelle zlvcdavis');