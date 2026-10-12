--==============================================================
-- Table: art_ofentyp_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_ofentyp_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_OFENTYP_ZU_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'DWH Artikelnummer',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   ofen_typ_id                         VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Ofentyps aus dem Quellfeld oventype, z.Bsp. A.',
   blech_belegung                      INTEGER     NOT NULL COMMENT 'optimale Anzahl des Artikels pro Backblech',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_OFENTYP_ZU PRIMARY KEY (art_id, mandant_id, ofen_typ_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Diese Tabelle ordnet den Artikeln die Ofentypen zu. Quelle ist die SAP-Klassenbibliothek';

