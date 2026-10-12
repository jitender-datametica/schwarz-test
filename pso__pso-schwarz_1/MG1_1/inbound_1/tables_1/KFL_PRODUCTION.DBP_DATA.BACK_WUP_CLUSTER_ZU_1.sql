create or replace TABLE KFL_PRODUCTION.DBP_DATA.BACK_WUP_CLUSTER_ZU_1 (
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_CLUSTER_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID eines Wup_1 Clusters. Wird im DWH erzeugt',
	PRIO NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Prio ',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BACK_WUP_CLUSTER_ZU primary key (MANDANT_ID, WUP_ID, NB_ID, WUP_CLUSTER_ID)
)COMMENT='VIS Backshop -Zuordnung wup_1-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl'
;