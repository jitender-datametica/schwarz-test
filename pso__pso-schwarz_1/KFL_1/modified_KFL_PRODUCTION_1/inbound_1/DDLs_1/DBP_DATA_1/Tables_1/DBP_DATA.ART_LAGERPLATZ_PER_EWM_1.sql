--==============================================================
-- Table: art_lagerplatz_per_ewm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_lagerplatz_per_ewm_1
   generated from Powerdesigner on Mittwoch, 23. März 2022 10:04:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_LAGERPLATZ_PER_EWM_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   art_guid                            VARCHAR(32)     NOT NULL COMMENT 'Product',
   wup_id                              INTEGER    NOT NULL COMMENT 'Betrieb',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb',
   lagerplatz_id                       VARCHAR(18)     COLLATE 'en-ci' NOT NULL COMMENT 'ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie (hier abweichend UTF9 aufgrund von evtl. fehlerhafter Pflege in SAP)',
   dat_von                             DATE            NOT NULL COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (von)',
   art_id                              INTEGER    COMMENT 'Artikelnummer       ',
   dat_bis                             DATE            COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (bis)',
   lagertyp_id                         VARCHAR(4)      COLLATE 'en-ci' COMMENT 'ID des Lagertyps. Zweite Ebene der Lagerhierarchie',
   menge_max                           NUMBER(29,3)    COMMENT 'Maximalmenge',
   menge_max_einh_id                   VARCHAR(3)      COMMENT 'Anzeige Mengeneinheit für Maximalmenge',
   menge_min                           NUMBER(29,3)    COMMENT 'Maximalmenge',
   menge_min_einh_id                   VARCHAR(3)      COMMENT 'Anzeige Mengeneinheit für Minimalmenge',
   menge_fixiert_fg                    INTEGER    NOT NULL COMMENT 'Minimal-/Maximal-/Nachschubmenge fixiert flag',
   menge_min_direkt                    NUMBER(29,3)    COMMENT 'Mindestmenge für die Direkteinlagerung',
   menge_min_direkt_einh_id            VARCHAR(3)      COMMENT 'Mengeneinheit der Mindestmenge für die Einlagerung',
   datzeit_aenderung                   TIMESTAMP_LTZ   COMMENT 'LSTC = last change?',
   tr_fg                               INTEGER   COMMENT 'Tagesrenner Griffzone',
   tkl_fg                              INTEGER   COMMENT 'TKL Prozess',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_LAGERPLATZ_PER_EWM PRIMARY KEY (mandant_id, lagernummer_id, art_guid, wup_id, nb_id, lagerplatz_id, dat_von) NOT ENFORCED
)  COMMENT = 'Materialdaten pro Lagertyp';
