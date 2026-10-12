--==============================================================
-- Table: in_planknoten_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_planknoten_per
   generated from Powerdesigner on Montag, 20. Februar 2023 09:28:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_planknoten_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
plantyp_id STRING(1) NOT NULL OPTIONS(description='Plantyp (z.B. A = Wartungsplan)'),
plangruppe_id STRING(10) NOT NULL OPTIONS(description='Schlüssel der Plangruppe'),
planknoten_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Planknoten dienen der Zuordnung bestimmter (Plan-)Aufgaben zu Plangruppen ( plan-nodes are used to  assign certain (plan-)activities to a plangroup).'),
planknotenzaehler_int BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zähler innerhalb des Planknotens'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE OPTIONS(description='Gültig bis'),
co_leistungsart_arbeitsplan_id STRING(7)
OPTIONS(description='Leistungsart Arbeitsplan (type of activity in the work plan)'),
arbeitsplan_menge BIGNUMERIC(38,16) OPTIONS(description='Arbeit des Vorgangs (planed amount of the activity)'),
arbeitsplan_menge_einh_id STRING(3)
OPTIONS(description='Einheit der Arbeit (measurement uint of the planned activity amount)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, planknoten_id, planknotenzaehler_int, dat_von) NOT ENFORCED
)
OPTIONS(description='Tabelle fur Arbeitsplan Position / Table with Task List - operation/activity data - here we have relationship between Activities and PlanGroup( but not particular plan)');