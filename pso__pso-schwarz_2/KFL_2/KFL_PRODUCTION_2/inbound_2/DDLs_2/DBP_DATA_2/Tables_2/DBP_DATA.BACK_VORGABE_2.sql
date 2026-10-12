--==============================================================
-- Table: back_vorgabe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_vorgabe_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_VORGABE_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_cluster_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Wup_2 Clusters. Wird im DWH erzeugt',
   wug_cluster_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt',
   back_drehklasse_id                  VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der für den Backshop definierten Drehklasse, z.Bsp. LD',
   aktion_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Aktion_2-Flag. ! = Aktion_2, 0 = nicht in Aktion_2',
   key_bc_bez                          VARCHAR(100)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'In der Quelle der sprechende Schlüssel der Tabelle aus dem Element key_bc. Wird compressed',
   aufschlag_zeit                      NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Aufschlag Uhrzeit aus auf_uz',
   ant_mag                             NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Anteil Minimum am Gesamt aus ant_mag',
   faktor_ist                          NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Faktor auf Ist aus fak_ist',
   min_gesamt_fs                       NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Minimum Gesamt Frühstart aus min_gf',
   ant_min_fs                          NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Anteil Minimum Frühstart aus ant_mf',
   prognoseart                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Prognoseart, z.Bsp. fc_max. Ist bisher im Modell nicht abgebildet, fc_max entspricht menge_prognose_max in der Tabelle fur_prognose_2 aus prog_art',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_VORGABE PRIMARY KEY (mandant_id, wup_cluster_id, wug_cluster_id, back_drehklasse_id, aktion_fg) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Parameter für den Backplan aus der Quelltabelle zek_bake_cntrl';

