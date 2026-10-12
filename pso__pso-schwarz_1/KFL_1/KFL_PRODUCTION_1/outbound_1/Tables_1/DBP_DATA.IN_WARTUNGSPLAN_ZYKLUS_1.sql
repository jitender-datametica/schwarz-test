--==============================================================
-- Table: in_wartungsplan_zyklus_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_zyklus_1
   generated from Powerdesigner on Montag, 20. Februar 2023 09:47:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_zyklus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_zaehler BIGNUMERIC(38,0) OPTIONS(description='Zähler (identifier of the plan cycle within the plan context)'),
zyklus_wert_sek BIGNUMERIC(38,16) OPTIONS(description='Zyklus / Offset eines Wartungspaketes (immer in Sekunden!)'),
zyklus_einh_id STRING(3) OPTIONS(description='Anzeige-Einheit für die Durchführung von Wartungsmaßnahmen'),
zyklus_wert BIGNUMERIC(38,0) OPTIONS(description='Zyklus / Offset eines Wartungspaketes in Anzeige-Einheit gerundet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_id) NOT ENFORCED
) OPTIONS(description='Zyklusdefinition Wartungsplan ');