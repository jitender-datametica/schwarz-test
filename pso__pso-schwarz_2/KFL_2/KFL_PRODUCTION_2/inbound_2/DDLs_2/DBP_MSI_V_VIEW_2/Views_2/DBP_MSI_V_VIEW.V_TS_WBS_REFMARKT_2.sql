create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_WBS_REFMARKT_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH.',
	WUP_ID COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	WUP_ID_REF COMMENT 'Referenzfiliale WUP_ID (exisitierender Markt).',
	NB_ID_REF COMMENT 'Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).',
	REF_FAKTOR_FALLBACK COMMENT 'Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).',
	MANDANT_ID_VZ_FALLBACK COMMENT 'Mandant_2 VZ Fallback.',
	WUP_ID_VZ_FALLBACK COMMENT 'Verteilzentrum VZ Fallback.',
	NB_ID_VZ_FALLBACK COMMENT 'Nebenbetrieb VZ Fallback,',
	CLEAR_STOCK_AUSSCHLUSS_FG COMMENT 'Flag gibt an, ob der betroffene Markt global von der automatischen \""Clear Stock\""-Verteilung ausgeschlossen werden soll. Beim \""Clear Stock\""-Prozess wird der verbleibende Lagerbestand eines Artikels vollständig auf die teilnehmenden Märkte verteilt (Push-Prinzip), um das Lager komplett zu räumen.\n\nWertebereich:\n0 (False): Der Markt nimmt am Prozess teil (Standard). Er erhält Zuteilungen, wenn Lagerbestände abgebaut werden müssen.\n1 (True): Der Markt ist ausgeschlossen. Er erhält bei einer \""Clear Stock\""-Verteilung keine Ware.\n\nGeltungsbereich: Die Einstellung ist marktbezogen und gilt global für alle Artikel_2 und alle Aktionen. Ein gesetztes Flag (1) verhindert die Belieferung aus jeglichen Clear-Stock-Prozessen für diesen Markt.',
	MIN_PLATZIERUNG_MARKT_CLUSTER_ID COMMENT 'Markt-Cluster für Mindestplatzierung (1-3).'
) as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        wup_id_ref,
        nb_id_ref,
        ref_faktor_fallback,
        mandant_id_vz_fallback,
        wup_id_vz_fallback,
        nb_id_vz_fallback,
        clear_stock_ausschluss_fg,
        min_platzierung_markt_cluster_id

FROM DBP_MSI_DATA.TS_WBS_REFMARKT_2 ;
