--==============================================================
-- Table: transportation_unit_hu_lief_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_hu_lief_zu_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:32:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_HU_LIEF_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       INTEGER     NOT NULL COMMENT 'transportation_unit_sr_act_id',
   transportation_unit_seq_id          INTEGER     NOT NULL COMMENT 'Reihenfolgenummer',
   compartment_hu_guid                 VARCHAR(32)      COMMENT 'GUID Handling Unit_1 (Fach)',
   ladeposition                        INTEGER     COMMENT 'Postion am Fahrzeug / Transporteinheit',
   lagernummer_id                      VARCHAR(4)       COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   beleg_guid                          VARCHAR(32)      COMMENT 'Beleg-ID',
   beleg_pos_guid                      VARCHAR(32)      COMMENT 'Positions-ID',
   belegtyp_id                         VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegtyp',
   beleg_id                            INTEGER     COMMENT 'Belegnummer',
   beleg_pos_id                        INTEGER     COMMENT 'Positionsnummer',
   zuordnungsart_id                    VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Zuordnungsart',
   top_hu_guid                         VARCHAR(32)      COLLATE 'en-ci' COMMENT 'GUID Handling Unit_1 (Top)',
   top_hu_id                           VARCHAR(32)      COMMENT 'HUIDENT Handling Unit_1 (Top)',
   cross_hu_fg                         VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: Lieferübergreifende HU',
   change_fg                           VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: Änderungsindikator',
   status_fg                           VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: Status_1',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) COMMENT 'Erstellungszeitpunkt',
   datzeit_aenderung                   TIMESTAMP_NTZ(9) COMMENT 'Änderungszeitpunkt',
   auslieferung_exist_fg               VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: Status_1 "Auslieferung existiert"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_HU_LIEF_ZU PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, transportation_unit_seq_id) NOT ENFORCED
)  COMMENT = 'Transportation Unit_1, HU, Delivery';
