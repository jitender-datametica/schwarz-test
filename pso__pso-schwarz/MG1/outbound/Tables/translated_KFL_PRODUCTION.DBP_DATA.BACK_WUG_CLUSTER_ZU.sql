CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BACK_WUG_CLUSTER_ZU (
ARTHIERTYP_ID INTEGER NOT NULL OPTIONS(description='Artikel - Hierarchie - Typ - ID. Kennzeichnet'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUG_ID INTEGER NOT NULL
OPTIONS(description='Warenuntergruppe-ID. Die Warenuntergruppe ist nur zusammen mit der Warengruppe eindeutig'),
WUG_CLUSTER_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ARTHIERTYP_ID, WG_ID, MANDANT_ID, WUG_ID) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wug-Cluster zu Warenuntergruppe aus der Quelltabelle zek_bake_wgicl');