--==============================================================
-- Table: wup_dat_wg_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_wg_sum
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_dat_wg_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
bonanzahl BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Kassenbons'),
bonanzahl_pre_pack BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Kassenbons mit Pre-Pack Artikeln'),
bonanzahl_sug BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat, wg_id, arthiertyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Tages-Aggregat pro Markt und Warengruppe');