--==============================================================
-- Table: in_plan_planknoten_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_plan_planknoten_zu_per
   generated from Powerdesigner on Montag, 20. Februar 2023 09:29:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_plan_planknoten_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
plantyp_id STRING(1) NOT NULL OPTIONS(description='Plantyp (z.B. A = Wartungsplan)'),
plangruppe_id STRING(10) NOT NULL OPTIONS(description='Schlüssel der Plangruppe'),
plangruppenzaehler STRING(2) NOT NULL OPTIONS(description='Plangruppenzähler'),
planknoten_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Planknoten dienen der Zuordnung bestimmter (Plan-)Aufgaben zu Plangruppen ( plan-nodes are used to  assign certain (plan-)activities to a plangroup).'),
planknotenzaehler_int BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zähler innerhalb des Planknotens'),
planfolge_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Folge (order number of taks activity within the plan)'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von (technical validity date within DWH)'),
dat_bis DATE OPTIONS(description='Gültig bis (technical validity date within DWH)'),
dat_gueltig_ab DATE OPTIONS(description='Datum gültig ab (business date coming from source)'),
loesch_fg BIGNUMERIC(38,0) OPTIONS(description='Löschkennzeichen'),
dat_anlage BYTES OPTIONS(description='Anlagedatum Satz (in source system)'),
dat_aenderung DATE OPTIONS(description='Datum der letzten Änderung ( in source system)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, plangruppenzaehler, planknoten_id, planknotenzaehler_int,
 planfolge_id, dat_von) NOT ENFORCED
)
OPTIONS(description='Tabelle fur Arbeitsplan Position / This is table for relationship between Plan Instance (particular Plan, not a PlanGroup) and Plan Task/Activity');