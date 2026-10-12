--==============================================================
-- Table: immo_mo_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_status_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MO_STATUS_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   mo_status_id                        INTEGER     NOT NULL COMMENT 'Status_1 ID des Mietobjekt',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mo_status_bez                       VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Status_1  Mietobjekt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MO_STATUS_SPR_ZU PRIMARY KEY (mandant_id, mo_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichungen des Status_1 des Mietobjekts (z.B. Leerstand, vermietet, übergeben) - SAP REFX - ZRE_FL_STATUST';
