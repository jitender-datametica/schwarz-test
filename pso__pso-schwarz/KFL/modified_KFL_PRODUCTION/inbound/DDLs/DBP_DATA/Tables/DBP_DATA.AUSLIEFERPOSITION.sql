--==============================================================
-- Table: auslieferposition
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslieferposition
   generated from Powerdesigner on Wednesday, June 8, 2022 1:34:06 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSLIEFERPOSITION (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   beleg_guid                          VARCHAR(32)      NOT NULL COMMENT 'Beleg-ID.',
   beleg_pos_guid                      VARCHAR(32)      NOT NULL COMMENT 'Positions-ID.',
   belegtyp_id                         VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegtyp.',
   beleg_id                            NUMBER(29,0)     COMMENT 'Belegnummer.',
   manuell_erzeugt_fg                  INTEGER     COMMENT 'Flag: Manuell erzeugt.',
   beleg_pos_id                        INTEGER     COMMENT 'Positionsnummer.',
   tor_id                              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Lagertor.',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) COMMENT 'Anlagetimestamp.',
   datzeit_aenderung                   TIMESTAMP_NTZ(9) COMMENT 'Aenderungstimestamp.',
   dat_lief_soll                       DATE             COMMENT 'Lieferdatum (GI = Goods Issue).',
   zeit_lief_soll                      TIME(6)          COMMENT 'Uhrzeit zum Lieferdatum (GI = Goods Issue).',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSLIEFERPOSITION PRIMARY KEY (mandant_id, beleg_guid, beleg_pos_guid) NOT ENFORCED
)  COMMENT = 'Outbound Delivery Order Item.';
