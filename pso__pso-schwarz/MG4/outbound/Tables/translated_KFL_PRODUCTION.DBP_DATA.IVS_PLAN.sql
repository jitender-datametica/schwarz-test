CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_plan (
plandetail_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID fuer ein Plandetail'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant'),
plantyp_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Plantyps'),
plan_objekt_id STRING(50) NOT NULL
OPTIONS(description='ID, auf der geplant wird. Kann zb. eine Kostenstelle aus TP4 oder Flaeche aus TP5 sein.'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahr und Monat'),
plan_wert NUMERIC(18,2) OPTIONS(description='Geplanter Wert in Landeswährung'),
plan_wert_konz NUMERIC(18,2) OPTIONS(description='Geplanter Wert in Konzernwährung'),
kostenstelle_id STRING(20) NOT NULL
OPTIONS(description='Eindeutige ID der Kostenstelle (aus SAP, Paisy-Kostenstellen werden auf SAP-Kostenstellen gemappt, bzw. fuer einige Faelle die Hyperion-Kostenstelle)'),
dat_extrakt DATE NOT NULL OPTIONS(description='Extraktions- bzw. Erstellungsdatum des Datensatzes'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
PRIMARY KEY (plantyp_id, plandetail_id, mandant_id, plan_objekt_id) NOT ENFORCED
) OPTIONS(description='IVS - Plandaten Köpfe, Kosten, Stunden');