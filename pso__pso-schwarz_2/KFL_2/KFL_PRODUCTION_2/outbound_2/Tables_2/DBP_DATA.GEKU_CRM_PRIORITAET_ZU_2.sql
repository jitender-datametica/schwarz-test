--==============================================================
-- Table: geku_crm_prioritaet_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_prioritaet_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_prioritaet_zu_2 (
geku_crm_prioritaet_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mapping ID'),
crm_prioritaet_id BIGNUMERIC(38,0) OPTIONS(description='ID der Priorität, niedrig, mittel, hoch'),
geku_prioritaet_id BIGNUMERIC(38,0)
OPTIONS(description='Prioritaet ID aus GEKU. FK wird in View aus l_geku_zusatzinfo_sel_zu_2 (mit CROSS JOIN auf geku_zusatzinfo_spr_zu_2) gebildet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_prioritaet_id) NOT ENFORCED
)
OPTIONS(description='GEKU - Mapping Tabelle Priorität Geku zu CRM. In GEKU existiert keine Gegenparttabelle. FK wird in View aus l_geku_zusatzinfo_sel_zu_2 (mit CROSS JOIN auf geku_zusatzinfo_spr_zu_2) gebildet');