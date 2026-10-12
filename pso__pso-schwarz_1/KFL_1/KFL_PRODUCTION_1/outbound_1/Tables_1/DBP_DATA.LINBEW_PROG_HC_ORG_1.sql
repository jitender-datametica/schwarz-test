--==============================================================
-- Table: linbew_prog_hc_org_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: linbew_prog_hc_org_1
   generated from Powerdesigner on Dienstag, 18. März 2025 10:03:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.linbew_prog_hc_org_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
hr_objekt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Organisation, 8-stellige Zahl'),
dat DATE NOT NULL OPTIONS(description='Datum Vortag der Lieferung in Beladung gesetzt, im Format JJJJ-MM_1-TT'),
anz_prg_beendet BIGNUMERIC(38,0) OPTIONS(description='Anzahl abgeschlossene Programme'),
anz_prg_faellig BIGNUMERIC(38,0) OPTIONS(description='Anzahl fälligen Programme'),
anz_prg_gesamt BIGNUMERIC(38,0) OPTIONS(description='Anzahl zu erledigende Programme Gesamt'),
anz_prg_bearbeitung BIGNUMERIC(38,0) OPTIONS(description='Anzahl Progamme in Bearbeitung (auch fällige)'),
anz_prg_ausstehend BIGNUMERIC(38,0) OPTIONS(description='Anzahl nicht begonnene Programme (auch fällige)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, hr_objekt_id, dat) NOT ENFORCED
) OPTIONS(description='Einarbeitungskennzahlen programmbasiert je OrganizationID');