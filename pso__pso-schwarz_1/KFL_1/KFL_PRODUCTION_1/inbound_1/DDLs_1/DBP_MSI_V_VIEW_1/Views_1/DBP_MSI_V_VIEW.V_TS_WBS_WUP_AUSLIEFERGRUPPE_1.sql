create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_WBS_WUP_AUSLIEFERGRUPPE_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	WUP_ID COMMENT 'Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	AUSLIEFERGRUPPE_ID COMMENT 'Ausliefergruppe',
	INIT_LIEF_MARKT_CLUSTER_ID COMMENT 'Markt-Cluster für die initiale Belieferung (1-5).'
) COMMENT='Settings for WBS calculation core on Store level / content maintained by transaction services document. User can define Initial Delivery Cluster per Delivery Group on Store Level.\nEinstellungen für die WBS-Berechnung auf Filialebene. Der Inhalt wird durch TS gepflegt. Der Benutzer kann pro Liefergruppe den initialen Liefer-Cluster auf Filialebene definieren.'
 as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        ausliefergruppe_id,
        init_lief_markt_cluster_id

FROM DBP_MSI_DATA.TS_WBS_WUP_AUSLIEFERGRUPPE_1 ;
