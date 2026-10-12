--==============================================================
-- Table: as_food_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_food_1
   generated from Powerdesigner on Donnerstag, 8. September 2022 15:47:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.as_food_1 (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer im DWH'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
dat_auslistung DATE NOT NULL OPTIONS(description='Das Datum der Auslistung aus dem Quellfeld aldat'),
gp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Geschaeftspartner - ID (Lieferanten - ID)'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
phase_status BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Vermarktungsstatus aus dem Quellfeld vstatus'),
erl_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Erledigt Flag aus dem Quellfeld erlkz (0=(\'\',\'B\'); restlichen Auspraegungen = 1 (\'A\',\'C\',\'D\';\'E\',\'F\',\'G\',\'X\'))'),
dat_final DATE OPTIONS(description='Datum Laufzeitende aus dem Quellfeld final'),
menge_startbestand NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Redundant. Aus Tabelle marktbestand_erp_1 ermittelte Menge'),
vk_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Redundant. Verkaufspreis netto aus der Tabelle marktbestand_erp_zu_1'),
menge_endbestand NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Endbestand'),
erl_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Redundant zu "erl_fg" die einzelnen Auspraegungen (Erledigt Flag aus dem Quellfeld erlkz (0=(\'\',\'B\'); restlichen Ausprägungen = 1 (\'A\',\'C\',\'D\';\'E\',\'F\',\'G\',\'X\')))'),
dat_aend DATE OPTIONS(description='Aenderungsdatum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, nb_id, wup_id, dat_auslistung) NOT ENFORCED
) OPTIONS(description='AIS - Auslistungs-Schema Kopftabelle aus der Quelltabelle zrs_rvdata');