CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BACK_WUP_CLUSTER_ZU_2 (
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_CLUSTER_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Wup_2 Clusters. Wird im DWH erzeugt'),
PRIO INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Prio '),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, WUP_CLUSTER_ID) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wup_2-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl');