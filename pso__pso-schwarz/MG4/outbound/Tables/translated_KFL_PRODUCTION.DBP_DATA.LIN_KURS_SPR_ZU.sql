CREATE OR REPLACE TABLE kfl_production_dbp_data.lin_kurs_spr_zu (
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Kurses, z:Bsp. 186obs'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
mandant_id INTEGER NOT NULL OPTIONS(description='PK - Mandant im DWH'),
lin_bericht STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hinweis, in welchen Berichten der Kurs relevant ist. Aus\n            report_of\n            Ausprägungen\n            - VIS\t\t(nur im VIS relevant)\n            - UWL\t\t(nur im LIN Bericht\"unternehmensweites Lernen\" relevant)\n            - BLANK\t(für beide Berichte relevant)'),
lin_kurs_bez STRING(255) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Kurses, z.Bsp. Warenkunde Obst'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='LIN - Sprachabhängige Bezeichnungen der LIN-Kurse');