--==============================================================
-- Table: l_lin_kurs_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lin_kurs_1
   generated from Powerdesigner on Dienstag, 2. Januar 2024 09:16:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lin_kurs_1 (
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Kurses, z:Bsp. 186obs'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant_1 im DWH'),
sortkz BIGNUMERIC(38,0),
lin_kursgruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='ID der Kursgruppe aus coursegroup_id'),
lin_bericht STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hinweis, in welchen Berichten der Kurs_1 relevant ist. Aus            report_of            Ausprägungen            - VIS		(nur im VIS relevant)            - UWL 		(nur im LIN Bericht "unternehmensweites Lernen" relevant)            - BLANK	(für beide Berichte relevant)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='LIN - Lookuptabelle der Kurse');