--==============================================================
-- Table: immo_mo_nutzung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_nutzung_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MO_NUTZUNG_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   mo_nutzung_id                       NUMBER(38,0)     NOT NULL COMMENT 'Code der Nutzungsart Mietobjekt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mo_nutzung_bez                      VARCHAR(20)      COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Nutzungsart Mietobjekt (Handels-, Gewerbefläche oder Wohnungen)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MO_NUTZUNG_SPR_ZU PRIMARY KEY (mandant_id, mo_nutzung_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup Tabelle Nutzung (Verwendung) Mitobjekt (Handesl-, Gewerbefläche, Wohnungen) - SAP REFX - TIV01';
