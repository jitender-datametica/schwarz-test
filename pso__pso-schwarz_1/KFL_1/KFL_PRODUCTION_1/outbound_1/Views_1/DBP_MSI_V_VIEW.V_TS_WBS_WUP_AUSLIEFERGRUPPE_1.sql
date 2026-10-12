CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_wup_ausliefergruppe_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
ausliefergruppe_id OPTIONS(description='Ausliefergruppe'), init_lief_markt_cluster_id
OPTIONS(description='Markt-Cluster für die initiale Belieferung (1-5).'))
OPTIONS(DESCRIPTION = `Settings for WBS calculation core on Store level / content maintained by transaction services document. User can define Initial Delivery Cluster per Delivery Group on Store Level.\nEinstellungen für die WBS-Berechnung auf Filialebene. Der Inhalt wird durch TS gepflegt. Der Benutzer kann pro Liefergruppe den initialen Liefer-Cluster auf Filialebene definieren.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 ausliefergruppe_id,
 init_lief_markt_cluster_id
FROM kfl_production_dbp_msi_data.ts_wbs_wup_ausliefergruppe_1;