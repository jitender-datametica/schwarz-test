--==============================================================
-- Table: belos_vorgangart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_vorgangart_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_VORGANGART_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_vorgangart_id                 VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen für die Art des Belos Vorgangs (z. B. Beschaffung, Annahmeverweigerung)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   belos_vorgangart_bez                VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung für die Arten des Belos Vorgangs.',
   belos_vorgangart_kbez               VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung für die Arten des Belos Vorgangs.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_VORGANGART_SPR_ZU PRIMARY KEY (mandant_id, belos_vorgangart_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Spachabhaengige Kurzbezeichnungen fuer die Schluessel der Lookuptaballe l_belos_vorgangart.';

