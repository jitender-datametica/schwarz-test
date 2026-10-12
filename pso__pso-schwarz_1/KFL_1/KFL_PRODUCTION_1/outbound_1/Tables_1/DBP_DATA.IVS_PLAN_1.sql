--==============================================================
-- Table: ivs_plan_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ivs_plan_1
   generated from Powerdesigner on Freitag, 21. Oktober 2022 08:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_plan_1 (
plandetail_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID fuer ein Plandetail'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1'),
plantyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID des Plantyps'),
plan_objekt_id STRING(50) NOT NULL
OPTIONS(description='ID, auf der geplant wird. Kann zb. eine_1 Kostenstelle aus TP4 oder Flaeche aus TP5 sein.'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr und Monat_1'),
plan_wert NUMERIC(18,2) OPTIONS(description='Geplanter Wert in Landeswährung'),
plan_wert_konz NUMERIC(18,2) OPTIONS(description='Geplanter Wert in Konzernwährung'),
kostenstelle_id STRING(20) NOT NULL
OPTIONS(description='Eindeutige ID der Kostenstelle (aus SAP, Paisy-Kostenstellen werden auf SAP-Kostenstellen gemappt, bzw. fuer einige Faelle die Hyperion-Kostenstelle)'),
dat_extrakt DATE NOT NULL OPTIONS(description='Extraktions- bzw. Erstellungsdatum des Datensatzes'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (plantyp_id, plandetail_id, mandant_id, plan_objekt_id) NOT ENFORCED
) OPTIONS(description='IVS - Plandaten Köpfe, Kosten, Stunden_1');