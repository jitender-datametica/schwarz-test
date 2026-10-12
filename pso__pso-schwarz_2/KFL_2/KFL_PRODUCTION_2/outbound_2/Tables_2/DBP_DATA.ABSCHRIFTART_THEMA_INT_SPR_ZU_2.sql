--==============================================================
-- Table: abschriftart_thema_int_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_thema_int_spr_zu_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_thema_int_spr_zu_2 (
abschriftart_thema_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Abschriftenart-Thema (z.B. 1=Totalabschriften VT; 2=Totalabschriften EK; 3=Preisänderungen; etc.)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
abschriftart_thema_int_bez STRING(30) COLLATE 'und:ci'
OPTIONS(description='ID des Abschriftenart-Thema (z.B. 1=Totalabschriften VT; 2=Totalabschriften EK; 3=Preisänderungen; etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abschriftart_thema_int_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Sprach-Tabelle für Einheitliche Abschriftenarten Thema  KL international');