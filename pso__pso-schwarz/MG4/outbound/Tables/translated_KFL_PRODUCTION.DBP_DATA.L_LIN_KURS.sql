CREATE OR REPLACE TABLE kfl_production_dbp_data.l_lin_kurs (
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Kurses, z:Bsp. 186obs'),
mandant_id INTEGER NOT NULL OPTIONS(description='PK - Mandant im DWH'),
sortkz INTEGER,
lin_kursgruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='ID der Kursgruppe aus coursegroup_id'),
lin_bericht STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hinweis, in welchen Berichten der Kurs relevant ist. Aus\n            report_of\n            Ausprägungen\n            - VIS\t\t(nur im VIS relevant)\n            - UWL\t\t(nur im LIN Bericht\"unternehmensweites Lernen\" relevant)\n            - BLANK\t(für beide Berichte relevant)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='LIN - Lookuptabelle der Kurse');