--==============================================================
-- Table: coi_ump_tag_referenz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_tag_referenz_1
   generated from Powerdesigner on Dienstag, 20. September 2022 17:35:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_tag_referenz_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschaeftsjahres (1-9)'),
land_level STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Landes-Kategorisierung (1-3 Stellen) z.B HRK fuer Kroatien Kueste und HRL für Kroatien Land_1'),
dat_plan DATE NOT NULL OPTIONS(description='Datum des Plantag für das GJ auf Land_1-Level (im Format JJJJ-MM_1-TT)'),
dat_referenz DATE
OPTIONS(description='Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM_1-TT) auf Ebene Land_1-Level'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
faktor_kalender BIGNUMERIC(14,10)
OPTIONS(description='Faktor in % fuer den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz).'),
wert_kalender NUMERIC(18,4)
OPTIONS(description='Absolutwert fuer den Referenztag der Umsatzplanung (entweder faktor_kalender in % oder wert_kalender wird gefuellt) (kommt direkt aus der Upload-Excel)'),
umsatz_netto_tag_ges NUMERIC(18,4)
OPTIONS(description='Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_2 für den angegebenen Tag_1 ueber alle hgws'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, dat_plan) NOT ENFORCED
)
OPTIONS(description='WWC - COI Umsatzplanung - Pflege der Referenztage Vorjahr auf Level Mandant_1 / Land_1-Level - Planversion abhaengig - manueller Upload');