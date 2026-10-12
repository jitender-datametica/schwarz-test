--==============================================================
-- Table: back_wug_cluster_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_wug_cluster_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.back_wug_cluster_zu_1 (
arthiertyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wug_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenuntergruppe-ID. Die Warenuntergruppe ist nur zusammen mit der Warengruppe eindeutig'),
wug_cluster_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (arthiertyp_id, wg_id, mandant_id, wug_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wug_1-Cluster zu Warenuntergruppe aus der Quelltabelle zek_bake_wgicl');