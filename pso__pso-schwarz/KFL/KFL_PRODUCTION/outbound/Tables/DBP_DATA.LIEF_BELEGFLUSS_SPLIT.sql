--==============================================================
-- Table: lief_belegfluss_split
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_belegfluss_split
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:04:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_belegfluss_split (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lief_beleg_id INTEGER NOT NULL OPTIONS(description='Verursachender Vertriebsbeleg'),
lief_beleg_gruppe_id INTEGER NOT NULL OPTIONS(description='Gruppe'),
lief_beleg_pos_id INTEGER NOT NULL OPTIONS(description='Verursachende Position'),
lief_beleg_split_id INTEGER NOT NULL OPTIONS(description='Vertriebsbelegnummer'),
lief_beleg_split_pos_id INTEGER NOT NULL OPTIONS(description='Vertriebsbelegnummer'),
split_fortschreibung_kz STRING(1) OPTIONS(description='Fortschreibungskennzeichen'),
menge_lief_ist_lme NUMERIC(18,3) OPTIONS(description='Tatsächlich gelieferte Menge in Lagermengeneinheiten'),
split_lfd_nr_id BIGNUMERIC(38,0) OPTIONS(description='Liefersplit: laufende Nummer des gewünschten Ergebnispakets'),
split_vorgang_id STRING(4) OPTIONS(description='Betriebswirtsch. Vorgang bei dem der Split vorgenommen wird'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Belegfluß nachträglicher Auslieferungssplit');