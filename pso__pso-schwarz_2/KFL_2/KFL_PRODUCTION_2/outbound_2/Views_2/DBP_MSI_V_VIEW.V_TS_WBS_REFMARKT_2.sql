CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_refmarkt_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), wup_id_ref
OPTIONS(description='Referenzfiliale WUP_ID (exisitierender Markt).'), nb_id_ref
OPTIONS(description='Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).'), ref_faktor_fallback
OPTIONS(description='Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).'),
mandant_id_vz_fallback OPTIONS(description='Mandant_2 VZ Fallback.'), wup_id_vz_fallback
OPTIONS(description='Verteilzentrum VZ Fallback.'), nb_id_vz_fallback OPTIONS(description='Nebenbetrieb VZ Fallback,'),
clear_stock_ausschluss_fg
OPTIONS(description='Flag gibt an, ob der betroffene Markt global von der automatischen\""Clear Stock\""-Verteilung ausgeschlossen werden soll. Beim\""Clear Stock\""-Prozess wird der verbleibende Lagerbestand eines Artikels vollständig auf die teilnehmenden Märkte verteilt (Push-Prinzip), um das Lager komplett zu räumen.\n\nWertebereich:\n0 (False): Der Markt nimmt am Prozess teil (Standard). Er erhält Zuteilungen, wenn Lagerbestände abgebaut werden müssen.\n1 (True): Der Markt ist ausgeschlossen. Er erhält bei einer\""Clear Stock\""-Verteilung keine Ware.\n\nGeltungsbereich: Die Einstellung ist marktbezogen und gilt global für alle Artikel_2 und alle Aktionen. Ein gesetztes Flag (1) verhindert die Belieferung aus jeglichen Clear-Stock-Prozessen für diesen Markt.'),
min_platzierung_markt_cluster_id OPTIONS(description='Markt-Cluster für Mindestplatzierung (1-3).')) AS SELECT
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
FROM kfl_production_dbp_msi_data.ts_wbs_refmarkt_2;

