--==============================================================
-- Table: flw_bew_grund_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bew_grund_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BEW_GRUND_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_bew_grund_id                    INTEGER     NOT NULL COMMENT 'Grund der Bewegung (PDAO) aus SAP Quelle T157E.GRUND (Ursprung /SPDGS/PDAOE1.ZZGRUND)',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Laber Bewegungsart aus SAP Quelle T157E.BWART',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   flw_bew_grund_bez                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Bewegung aus SAP Quelle T157E.GRTXT',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BEW_GRUND_SPR_ZU PRIMARY KEY (flw_bew_grund_id, lager_bewart_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Texttabelle: Grund der Bewegung aus SAP P21 T157E';

