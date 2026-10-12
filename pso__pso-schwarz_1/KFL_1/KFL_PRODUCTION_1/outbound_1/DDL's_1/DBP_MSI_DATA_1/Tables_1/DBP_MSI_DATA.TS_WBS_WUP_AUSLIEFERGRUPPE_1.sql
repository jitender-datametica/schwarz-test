CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_wbs_wup_ausliefergruppe_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
ausliefergruppe_id STRING(10) NOT NULL OPTIONS(description='Ausliefergruppe'),
init_lief_markt_cluster_id INTEGER NOT NULL OPTIONS(description='Markt-Cluster für die initiale Belieferung (1-5).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, ausliefergruppe_id) NOT ENFORCED
)
OPTIONS(description='Settings for WBS calculation core on Store level / content maintained by transaction services document. User can define Initial Delivery Cluster per Delivery Group on Store Level.\n             Einstellungen für die WBS-Berechnung auf Filialebene. Der Inhalt wird durch TS gepflegt. Der Benutzer kann pro Liefergruppe den initialen Liefer-Cluster auf Filialebene definieren.');