--==============================================================
-- Table: ts_wbs_refmarkt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_refmarkt
   generated from Powerdesigner on Montag, 16. Februar 2026 12:05:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_REFMARKT (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   wup_id_ref                          NUMBER(38,0)     COMMENT 'Referenzfiliale WUP_ID (exisitierender Markt).',
   nb_id_ref                           NUMBER(38,0)     COMMENT 'Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).',
   ref_faktor_fallback                 NUMBER(9,2)      COMMENT 'Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).',
   mandant_id_vz_fallback              NUMBER(38,0)     COMMENT 'Mandant VZ Fallback.',
   wup_id_vz_fallback                  NUMBER(38,0)     COMMENT 'Verteilzentrum VZ Fallback.',
   nb_id_vz_fallback                   NUMBER(38,0)     COMMENT 'Nebenbetrieb VZ Fallback,',
   clear_stock_ausschluss_fg           NUMBER(38,0)     COMMENT 'Flag gibt an, ob der betroffene Markt global von der automatischen "Clear Stock"-Verteilung ausgeschlossen werden soll. Beim "Clear Stock"-Prozess wird der verbleibende Lagerbestand eines Artikels vollständig auf die teilnehmenden Märkte verteilt (Push-Prinzip), um das Lager komplett zu räumen.
            
            Wertebereich:
            0 (False): Der Markt nimmt am Prozess teil (Standard). Er erhält Zuteilungen, wenn Lagerbestände abgebaut werden müssen.
            1 (True): Der Markt ist ausgeschlossen. Er erhält bei einer "Clear Stock"-Verteilung keine Ware.
            
            Geltungsbereich: Die Einstellung ist marktbezogen und gilt global für alle Artikel und alle Aktionen. Ein gesetztes Flag (1) verhindert die Belieferung aus jeglichen Clear-Stock-Prozessen für diesen Markt.',
   min_platzierung_markt_cluster_id    NUMBER(38,0)     COMMENT 'Markt-Cluster für Mindestplatzierung (1-3).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_REFMARKT PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Settings for WBS calculation core on Reference Store level / content maintained by transaction services document.';
