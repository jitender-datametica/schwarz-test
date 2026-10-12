--==============================================================
-- Table: l_angebot_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_typ_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:45:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ANGEBOT_TYP_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   angebot_typ_cd                      VARCHAR(10)      NOT NULL COMMENT 'Alphanumerischer Code des Angebotstyp.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ANGEBOT_TYP PRIMARY KEY (mandant_id, angebot_typ_cd) NOT ENFORCED
)  COMMENT = 'Lookuptabelle der möglichen Typen eines Angebotes.';
