--==============================================================
-- Table: lin_kurs_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lin_kurs_spr_zu
   generated from Powerdesigner on Mittwoch, 17. Januar 2024 19:59:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lin_kurs_spr_zu (
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Kurses, z:Bsp. 186obs'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant im DWH'),
lin_bericht STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hinweis, in welchen Berichten der Kurs relevant ist. Aus            report_of            Ausprägungen            - VIS		(nur im VIS relevant)            - UWL 		(nur im LIN Bericht "unternehmensweites Lernen" relevant)            - BLANK	(für beide Berichte relevant)'),
lin_kurs_bez STRING(255) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Kurses, z.Bsp. Warenkunde Obst'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='LIN - Sprachabhängige Bezeichnungen der LIN-Kurse');