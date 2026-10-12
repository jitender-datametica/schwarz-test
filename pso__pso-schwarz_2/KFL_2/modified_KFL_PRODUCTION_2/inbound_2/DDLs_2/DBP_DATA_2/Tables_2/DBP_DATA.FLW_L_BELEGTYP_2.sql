--==============================================================
-- Table: flw_l_belegtyp_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_belegtyp_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_BELEGTYP_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_beleg_typ_id                    VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Belegtyp, z.Bsp. WE, WA aus belty',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_BELEGTYP PRIMARY KEY (mandant_id, flw_beleg_typ_id) NOT ENFORCED
)  COMMENT = 'Abbildung der FLW-Beleg-Typ-ID als eine_2 Loockup Tabelle.';

