--==============================================================
-- Table: gp_ewm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_ewm
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:02:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_EWM (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   gp_ewm_id                           VARCHAR(10)     NOT NULL COMMENT 'Geschäftspartnernummer',
   gp_ewm_id_num                       INTEGER    COMMENT 'Geschäftspartnernummer (numerisch)',
   gp_ewm_typ_id                       VARCHAR(1)      COMMENT 'Geschäftspartnertyp',
   gp_ewm_grp_id                       VARCHAR(4)      COMMENT 'Geschäftspartnergruppierung',
   name_org_1                          VARCHAR(40)     COMMENT 'Name 1 zum Geschäftspartner',
   name_org_2                          VARCHAR(40)     COMMENT 'Name 2  zum Geschäftspartner',
   gp_ewm_guid                         VARCHAR(32)     COMMENT 'GUID eines Geschäftspartners',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagernummern';
