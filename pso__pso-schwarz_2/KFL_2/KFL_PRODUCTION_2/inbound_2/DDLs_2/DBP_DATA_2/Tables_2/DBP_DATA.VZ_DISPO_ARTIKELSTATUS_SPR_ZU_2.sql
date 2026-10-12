--==============================================================
-- Table: vz_dispo_artikelstatus_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vz_dispo_artikelstatus_spr_zu_2
   generated from Powerdesigner on Montag, 6. Februar 2023 14:28:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VZ_DISPO_ARTIKELSTATUS_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprachschlüssel.',
   vz_dispo_artikelstatus_id           NUMBER(38,0)     NOT NULL COMMENT 'VZ Dispo Artikelstatus.',
   vz_dispo_artikelstatus_bez          VARCHAR(60)      COMMENT 'VZ Dispo Artikelstatus Bezeichnung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VZ_DISPO_ARTIKELSTATUS_SPR_ZU PRIMARY KEY (mandant_id, spr_id, vz_dispo_artikelstatus_id) NOT ENFORCED
)  COMMENT = 'Beschreibungen Artikelstatus im VZ in Bezug auf Disposition. Quelle = DD07V, DOMNAME = ''ZSCM_DC_ARTSTATUS''.';
