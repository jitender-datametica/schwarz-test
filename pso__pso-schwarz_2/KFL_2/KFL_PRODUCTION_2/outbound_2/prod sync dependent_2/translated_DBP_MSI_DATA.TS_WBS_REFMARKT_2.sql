CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_wbs_refmarkt_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
wup_id_ref INTEGER OPTIONS(description='Referenzfiliale WUP_ID (exisitierender Markt).'),
nb_id_ref INTEGER OPTIONS(description='Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).'),
ref_faktor_fallback NUMERIC(29,2)
OPTIONS(description='Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).'),
mandant_id_vz_fallback INTEGER OPTIONS(description='Mandant_2 VZ Fallback.'),
wup_id_vz_fallback INTEGER OPTIONS(description='Verteilzentrum VZ Fallback.'),
nb_id_vz_fallback INTEGER OPTIONS(description='Nebenbetrieb VZ Fallback,'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
clear_stock_ausschluss_fg INTEGER
OPTIONS(description='Flag gibt an, ob der betroffene Markt global von der automatischen\""Clear Stock\""-Verteilung ausgeschlossen werden soll. Beim\""Clear Stock\""-Prozess wird der verbleibende Lagerbestand eines Artikels vollständig auf die teilnehmenden Märkte verteilt (Push-Prinzip), um das Lager komplett zu räumen.\n\n            Wertebereich:\n            0 (False): Der Markt nimmt am Prozess teil (Standard). Er erhält Zuteilungen, wenn Lagerbestände abgebaut werden müssen.\n            1 (True): Der Markt ist ausgeschlossen. Er erhält bei einer\""Clear Stock\""-Verteilung keine Ware.\n\n            Geltungsbereich: Die Einstellung ist marktbezogen und gilt global für alle Artikel_2 und alle Aktionen. Ein gesetztes Flag (1) verhindert die Belieferung aus jeglichen Clear-Stock-Prozessen für diesen Markt.'),
min_platzierung_markt_cluster_id INTEGER OPTIONS(description='Markt-Cluster für Mindestplatzierung (1-3).'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
)
OPTIONS(description='Settings for WBS calculation core on Reference Store level / content maintained by transaction services document.');