--==============================================================
-- Table: transportation_unit_kunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_kunde
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:37:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_KUNDE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kunde_id                            VARCHAR(10)      NOT NULL COMMENT 'Markt',
   kunde_num_id                        INTEGER     COMMENT 'Markt (numerisch für Join mit wup-Tabelle)',
   dat_tour                            DATE             NOT NULL COMMENT 'Tour Lieferdatum',
   wup_id                              INTEGER     NOT NULL COMMENT 'Betrieb',
   plantour_id                         INTEGER     COMMENT 'Plantournummer',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transportnummer',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   tour_pos_id                         INTEGER     COMMENT 'Tournummer (entspricht Position)',
   zeit_plan_ankunft                   TIME(9)          COMMENT 'Anlieferzeit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_KUNDE PRIMARY KEY (mandant_id, kunde_id, dat_tour, wup_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
)  COMMENT = 'SRS geplante Tourdaten';
