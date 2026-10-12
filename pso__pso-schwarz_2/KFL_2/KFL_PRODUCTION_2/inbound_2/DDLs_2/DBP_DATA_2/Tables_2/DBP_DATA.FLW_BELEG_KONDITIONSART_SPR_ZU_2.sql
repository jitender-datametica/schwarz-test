--==============================================================
-- Table: flw_beleg_konditionsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_beleg_konditionsart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BELEG_KONDITIONSART_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   beleg_konditionsart_id              VARCHAR(4)       NOT NULL COMMENT 'Konditionsart aus kschl',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   beleg_konditionsart_bez             VARCHAR(20)      NOT NULL DEFAULT ' ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BELEG_KONDITIONSART_SPR_ZU PRIMARY KEY (mandant_id, beleg_konditionsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Belegkalkulationsart - SAP P21 T685T';
