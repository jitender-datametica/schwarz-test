--==============================================================
-- Table: ims_projekt_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_projekt_typ_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_PROJEKT_TYP_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   ims_projekt_typ_id                  VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Projekttyp wird aus dem ersten Zeichen der fachlichen Projektid gebildet, z.Bsp B für Bau',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   ims_projekt_typ_bez                 VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Projekttyps, z.Bsp. Instandsetzung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_PROJEKT_TYP_SPR_ZU PRIMARY KEY (mandant_id, ims_projekt_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnung der Projekttypen. Nur initial gefüllt, keine Versorgung';
