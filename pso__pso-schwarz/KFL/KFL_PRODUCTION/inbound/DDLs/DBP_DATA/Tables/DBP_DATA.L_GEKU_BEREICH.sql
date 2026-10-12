--==============================================================
-- Table: l_geku_bereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_geku_bereich
   generated from Powerdesigner on Dienstag, 20. September 2022 11:52:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_GEKU_BEREICH (
   geku_bereich_uid                    NUMBER(38,0)    NOT NULL COMMENT 'Eindeutige ID des GeKu-Bereichs, aus workflow_level1_uid.',
   geku_bereich_id                     VARCHAR(60)     NOT NULL COMMENT 'Logischer Schlüssel aus Fachbereich, z.B. 90. Aus workflow_level1_ext_key.',
   wmd_fg                              NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Flag: Freigabe für WMD: 0 = nicht freigegeben; 1 = freigegeben.',
   kdc_fg                              NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Flag: Freigabe für KDC: 0 = nicht freigegeben; 1 = freigegeben.',
   mzk_fg                              NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Flag: Freigabe für MZK: 0 = nicht freigegeben; 1 = freigegeben.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_GEKU_BEREICH PRIMARY KEY (geku_bereich_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Stufe 1 der GeKu-Artikelhierarchie aus s1_dhw_workflow_level1_out.';
