CREATE OR REPLACE TABLE kfl_production_dbp_data.back_wug_cluster_zu (
arthiertyp_id INTEGER NOT NULL OPTIONS(description='Artikel - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wug_id INTEGER NOT NULL
OPTIONS(description='Warenuntergruppe-ID. Die Warenuntergruppe ist nur zusammen mit der Warengruppe eindeutig'),
wug_cluster_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (arthiertyp_id, wg_id, mandant_id, wug_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wug-Cluster zu Warenuntergruppe aus der Quelltabelle zek_bake_wgicl');