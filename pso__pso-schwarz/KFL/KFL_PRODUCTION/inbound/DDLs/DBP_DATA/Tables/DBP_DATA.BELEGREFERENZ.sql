--==============================================================
-- Table: belegreferenz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegreferenz
   generated from Powerdesigner on Freitag, 12. Januar 2024 12:51:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGREFERENZ (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   beleg_guid                          VARCHAR(32)      NOT NULL COMMENT 'Beleg-ID',
   beleg_pos_guid                      VARCHAR(32)      NOT NULL COMMENT 'Position-ID',
   referenz_belegtyp_id                VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Referenzbelegtyp',
   referenzbeleg_guid                  VARCHAR(32)      NOT NULL COMMENT 'Referenzbeleg-ID',
   referenzbeleg_pos_guid              VARCHAR(32)      NOT NULL COMMENT 'Referenzpositions-ID',
   referenzbeleg_id                    VARCHAR(35)      COLLATE 'en-ci' COMMENT 'Referenzbelegnummer',
   belegtyp_id                         VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegtyp',
   referenz_bs_id                      VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Schlüsselname Business System',
   partner_guid                        VARCHAR(32)      COMMENT 'Partner-ID',
   referenzbeleg_pos_id                NUMBER(38,0)     COMMENT 'Referenzpositionsnummer',
   zeitzone                            VARCHAR(6)       COLLATE 'en-ci' COMMENT 'Zeitzone',
   datzeit_termin_beginn               TIMESTAMP_NTZ(9) COMMENT 'Termin Beginn',
   datzeit_termin_ende                 TIMESTAMP_NTZ(9) COMMENT 'Termin Ende',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) COMMENT 'Erstellungszeitpunkt des Belegs, Quellspalte = CRETST, Quelltabelle abhängig vom Belegtyp: PDI = /SCDL/DB_PROCH_I, PDO = /SCDL/DB_PROCH_O, FDO = /SCDL/DB_DLVH_O (The column does not contain timezone, but the value of the timestamp is in the timezone of the mandant)',
   datzeit_aenderung                   TIMESTAMP_NTZ(9) COMMENT 'Änderungszeitpunkt des Belegs, Quellspalte = CHTST, Quelltabelle abhängig vom Belegtyp: PDI = /SCDL/DB_PROCH_I, PDO = /SCDL/DB_PROCH_O, FDO = /SCDL/DB_DLVH_O (The column does not contain timezone, but the value of the timestamp is in the timezone of the mandant)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGREFERENZ PRIMARY KEY (mandant_id, beleg_guid, beleg_pos_guid, referenz_belegtyp_id, referenzbeleg_guid, referenzbeleg_pos_guid) NOT ENFORCED
)  COMMENT = 'Belegreferenz EWM';
