--==============================================================
-- Table: l_vz_dispo_artikelstatus_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_vz_dispo_artikelstatus_2
   generated from Powerdesigner on Montag, 6. Februar 2023 14:27:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_VZ_DISPO_ARTIKELSTATUS_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   vz_dispo_artikelstatus_id           NUMBER(38,0)     NOT NULL COMMENT 'VZ Dispo Artikelstatus.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_VZ_DISPO_ARTIKELSTATUS PRIMARY KEY (mandant_id, vz_dispo_artikelstatus_id) NOT ENFORCED
)  COMMENT = 'Lookup Artikelstatus im VZ in Bezug auf Disposition. Quelle = DD07V, DOMNAME = ''ZSCM_DC_ARTSTATUS''.';
