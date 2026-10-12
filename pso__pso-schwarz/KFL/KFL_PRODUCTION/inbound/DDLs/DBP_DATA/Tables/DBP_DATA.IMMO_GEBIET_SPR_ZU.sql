--==============================================================
-- Table: immo_gebiet_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_gebiet_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_GEBIET_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   gebiet_id                           NUMBER(38,0)     NOT NULL COMMENT 'Gebiet ID',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   gebiet_bez                          VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Gebiet ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_GEBIET_SPR_ZU PRIMARY KEY (mandant_id, gebiet_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Tabelle für Gebiete - SAP REFX - ZTB0000VZOP9OT';
