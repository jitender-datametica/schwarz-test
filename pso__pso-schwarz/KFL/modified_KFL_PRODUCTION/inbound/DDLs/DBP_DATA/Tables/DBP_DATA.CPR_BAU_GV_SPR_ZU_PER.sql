--==============================================================
-- Table: cpr_bau_gv_spr_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_bau_gv_spr_zu_per
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_BAU_GV_SPR_ZU_PER (
   projekt_id                          VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Projekts',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   bau_gv_dok_id                       VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige GUID des Dokuments aus der Quelle zz_dpr_document.dpr_tv_guid',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   dokument_bez                        VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Dokumententext aus document_text',
   dokument_bez_lang                   VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Dokumentenbeschreibung aus document_descr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_BAU_GV_SPR_ZU_PER PRIMARY KEY (projekt_id, dat_von, bau_gv_dok_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnungen zu den Baugenehmigungen aus dpr_document_t';

