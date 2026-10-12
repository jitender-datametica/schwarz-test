CREATE OR REPLACE TABLE kfl_production_dbp_data.abschriftart_int_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
abschriftart_id INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
abschriftart_int_id INTEGER NOT NULL
OPTIONS(description='ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, abschriftart_int_id) NOT ENFORCED
)
OPTIONS(description='VIS - Mapping-Tabelle nationale Abschrftenarten zu der iEinheitlichen Abschriftenarten KL international');