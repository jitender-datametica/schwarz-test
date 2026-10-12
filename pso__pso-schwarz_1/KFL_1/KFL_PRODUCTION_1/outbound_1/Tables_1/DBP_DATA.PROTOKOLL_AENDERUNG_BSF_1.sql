--==============================================================
-- Table: protokoll_aenderung_bsf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_aenderung_bsf_1
   generated from Powerdesigner on Dienstag, 28. September 2021 15:00:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.protokoll_aenderung_bsf_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_aenderung DATE NOT NULL
OPTIONS(description='Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.'),
datzeit_aenderung_utc TIMESTAMP NOT NULL OPTIONS(description='Änderungszeit in Lagerzeitzone'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
bereitstellungsflaeche STRING(4) NOT NULL OPTIONS(description='Bereitstellungsfläche'),
doppelbelegung_kz STRING(1) NOT NULL OPTIONS(description='Kennzeichen Doppelbelegung'),
index_nano BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nanosekunden für Index'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
transaktion_code STRING(20) OPTIONS(description='Transaktionscode aus tcode'),
vorgangstyp_id STRING(1) OPTIONS(description='Vorgangstyp bei Aktualisierung Bereitstellflächen'),
abbruchbedingung STRING(40) OPTIONS(description='Abbruchbedingung bei Verarbeitung in Fu-bausteinen'),
kunde_id STRING(10) OPTIONS(description='Warenempfänger'),
wgvgrp_id BIGNUMERIC(38,0)
OPTIONS(description='Warengruppenverkettungsgruppe - wird benutzt, um die verschiedenen Gebäude an einem VZ zu identifizieren.'),
zlv_bsf_status STRING(1) OPTIONS(description='Systemstatus einer Bereitstellfläche'),
referenznummer STRING(10) OPTIONS(description='Referenznummer'),
bestandart_id STRING(1) OPTIONS(description='Bestandart (Werbung oder Normalware)'),
status_verplant_fg BIGNUMERIC(38,0) OPTIONS(description='Status_1\'verplant\''),
fixe_einplanung_fg BIGNUMERIC(38,0) OPTIONS(description='Status_1\'fixe Einplanung\''),
status_verplan_ign_fg BIGNUMERIC(38,0) OPTIONS(description='Status_1\'verplant\' bei Kapazitätsprüfung ignorieren'),
max_kap_bsf NUMERIC(10,2) OPTIONS(description='Maximale eingeplante Kapazität der BSF mit gleicher Referenz'),
anz_pal_bsf NUMERIC(10,2) OPTIONS(description='Anzahl Paletten pro Bereitstellungsfläche'),
verplante_kap NUMERIC(10,2) OPTIONS(description='verplante Kapazität (Summe verpl. Stellplatz)'),
bestand_bsf BIGNUMERIC(38,0) OPTIONS(description='aktueller Bestand Bereitstellungsfläche'),
zlv_stp_ist NUMERIC(10,2) OPTIONS(description='Ist-Stellplatz BSF (belegte Stellplätze)'),
fixe_einplanung_markt_fg BIGNUMERIC(38,0) OPTIONS(description='Status_1\'fixe Einplanung\''),
lag_aktionssort STRING(1) OPTIONS(description='Lager mit Aktionssortiment'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);