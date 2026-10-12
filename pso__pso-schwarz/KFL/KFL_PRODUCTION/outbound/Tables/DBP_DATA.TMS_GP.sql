--==============================================================
-- Table: tms_gp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_gp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_gp (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_gp_id STRING(30) NOT NULL OPTIONS(description='ID des Geschäftspartners. Aus plkd.nr'),
tms_gp_typ_cd STRING(3) NOT NULL
OPTIONS(description='Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)'),
tms_gp_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_gp im Quellsystem. Aus plkd.kd_id'),
tms_gp_name STRING(50) NOT NULL OPTIONS(description='Name des Geschäftspartners'),
tms_gp_altnv_name STRING(50) OPTIONS(description='Alternativer Name des Geschäftspartners'),
tms_gp_strasse STRING(50) OPTIONS(description='Straße des Geschäftspartners Adresse'),
tms_gp_ort_name STRING(50) OPTIONS(description='Ort des Geschäftspartners Adresse'),
tms_gp_plz STRING(20) OPTIONS(description='Postleitzahl des Geschäftspartners Adresse'),
tms_land_cd STRING(5) OPTIONS(description='Länderkennzeichen'),
sperr_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichnung für Sperrung des Kunden'),
sammelbeleg_id BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen für Sammelbelege (aktuell nur J/N/leer)'),
tms_standorttyp_id BIGNUMERIC(38,0) OPTIONS(description='Standort-Typ (Außenlager, VZ, FLW, Markt,…)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die Informationen über Geschäftspartner (z. B. Lager, Spediteure, Märkte) im System, einschließlich Adressen, Sperr_fg und Standorttyp. Aus der Quelle plkd (WANKO)');