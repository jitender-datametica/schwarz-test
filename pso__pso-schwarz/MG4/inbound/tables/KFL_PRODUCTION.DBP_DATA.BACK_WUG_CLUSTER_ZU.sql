create or replace TABLE KFL_PRODUCTION.DBP_DATA.BACK_WUG_CLUSTER_ZU (
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID. Kennzeichnet',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUG_ID NUMBER(38,0) NOT NULL COMMENT 'Warenuntergruppe-ID. Die Warenuntergruppe ist nur zusammen mit der Warengruppe eindeutig',
	WUG_CLUSTER_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BACK_WUG_CLUSTER_ZU primary key (ARTHIERTYP_ID, WG_ID, MANDANT_ID, WUG_ID)
)COMMENT='VIS Backshop -Zuordnung wug-Cluster zu Warenuntergruppe aus der Quelltabelle zek_bake_wgicl'
;