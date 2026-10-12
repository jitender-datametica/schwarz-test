CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_aktivitaetsbereich_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
aktivitaetsbereich_id STRING(4) NOT NULL OPTIONS(description='Aktivitätsbereich'),
protokolleintraege_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Protokolleinträge erzeugen'),
joined_area_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Aktivitätsbereiche vereinigt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Aktivitaetsbereiche');