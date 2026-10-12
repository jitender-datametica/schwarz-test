CREATE OR REPLACE TABLE kfl_production_dbp_data.kukla_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kukla_id STRING(2) NOT NULL OPTIONS(description='ID des Konkurrenten (z.B. 05 für Aldi Nord)'),
spr_id INTEGER NOT NULL OPTIONS(description='Sprach-ID der spr_zu-Tabellen'),
kukla_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung des Konkurrenten'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kukla_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachzuordnungstabelle der kukla_id, Wettbewerber ID (z.B. 05 für Aldi Nord) gem. ZEKEWK100');