--==============================================================
-- Table: wup_dat_abt_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_abt_sum_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_dat_abt_sum_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM_2-TT'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
bonanzahl BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Kassenbons'),
bonanzahl_pre_pack BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Kassenbons mit Pre-Pack Artikeln'),
bonanzahl_sug BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat, abt_id, arthiertyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Tages-Aggregat pro Markt und Abteilung');