--==============================================================
-- Table: flw_bew_ziel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bew_ziel_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BEW_ZIEL_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   flw_ziel_id                         NUMBER(38,0)     NOT NULL COMMENT 'Ziel (PDAO) aus SAP Quelle /SPDGS/PDAOE1.ZZFWZIEL',
   domaene_bez                         VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung einer Domäne aus SAP Quelle DD07T.DOMNAME',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   flw_ziel_bez                        VARCHAR(60)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Ziel (PDAO) aus SAP Quelle DD07T.DDTEXT',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BEW_ZIEL_SPR_ZU PRIMARY KEY (mandant_id, flw_ziel_id, domaene_bez, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Texte zu Domänenfestwerten aus SAP P21 DD07T';

