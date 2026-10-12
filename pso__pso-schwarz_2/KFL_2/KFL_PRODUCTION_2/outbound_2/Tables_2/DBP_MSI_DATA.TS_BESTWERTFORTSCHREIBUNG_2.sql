--==============================================================
-- Table: ts_bestwertfortschreibung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_bestwertfortschreibung_2
   generated from Powerdesigner on Donnerstag, 12. Oktober 2023 11:23:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_bestwertfortschreibung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb z.Bsp.: 0 = Markt'),
dat DATE NOT NULL OPTIONS(description='Tag_2 für den die manuellen Eingaben getätigt werden'),
owg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hierarchietyp Seit 2010 immer 2'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Landeswährung - Pflege über Frontend, abhängig vom Mandant_2'),
umsatz_plan_brutto_owg NUMERIC(18,4) OPTIONS(description='Planwert Umsatz HL_2 brutto - Pflege über Frontend'),
wareneingang_brutto_owg NUMERIC(18,4) OPTIONS(description='Wareneingang brutto - IST - Pflege über Frontend'),
schlussbestand_vormonat_brutto_owg NUMERIC(18,4)
OPTIONS(description='Voraussichtlicher Schlussbestand Brutto Vormonat - IST - Pflege über Frontend'),
datzeit_pflege TIMESTAMP NOT NULL
OPTIONS(description='datzeit_pflege zur Kontrolle bei druecken Button speichern'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id, wrg_id) NOT ENFORCED
) OPTIONS(description='VIS - Transaction Frontend - Pflegetabelle für VIS Bericht Bestellfortschreibung.');