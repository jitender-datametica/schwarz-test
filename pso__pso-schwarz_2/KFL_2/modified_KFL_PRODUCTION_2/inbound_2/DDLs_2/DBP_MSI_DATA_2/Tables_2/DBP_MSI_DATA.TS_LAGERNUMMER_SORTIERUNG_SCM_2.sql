--==============================================================
-- Table: ts_lagernummer_sortierung_scm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_lagernummer_sortierung_scm_2
   generated from Powerdesigner on Donnerstag, 17. Oktober 2024 14:11:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_LAGERNUMMER_SORTIERUNG_SCM_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 in DWH.',
   lagernummer_id                      VARCHAR(4)       NOT NULL COMMENT 'Lagernummer / Lagerkomplex.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.',
   lagersortiment_id                   VARCHAR(1)       NOT NULL COMMENT 'Lagersortiment ID.',
   artikelsortiment_id                 VARCHAR(1)       NOT NULL COMMENT 'Artikelsortiment ID.',
   lagernummer_sortierung_scm_id       VARCHAR(10)      NOT NULL COMMENT 'Lagernummersortierung SCM.',
   lagernummer_sortierung_scm_bez      VARCHAR(255)     COMMENT 'Lagernummersortierung SCM (Bezeichnung).',
   dat_pflege_layout                   DATE             COMMENT 'Datum, seit dem das Layout eines Verteilzentrums in SAP gepflegt wird. Das Layout wird benötigt um Entfernungen und darauf basierende Kennzahlen auszurechnen. Das Datum wird benötigt um zu verhindern, dass Kennzahlen zu einem Zeitraum gezogen werden, für den es noch kein fertiges / freigegebenes Layout gab.',
   dat_tms_wanko                       DATE             COMMENT 'Golive Datum des WANKO TMS.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_LAGERNUMMER_SORTIERUNG_SCM PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, lagersortiment_id, artikelsortiment_id, lagernummer_sortierung_scm_id) NOT ENFORCED
)  COMMENT = 'LIS - Lagernummer Sortierung SCM.';
