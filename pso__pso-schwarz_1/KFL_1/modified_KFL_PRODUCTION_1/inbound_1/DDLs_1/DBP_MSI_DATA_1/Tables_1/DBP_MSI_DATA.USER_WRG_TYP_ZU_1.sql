--==============================================================
-- Table: user_wrg_typ_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_wrg_typ_zu_1
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.USER_WRG_TYP_ZU_1 (
   user_id                             VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
   wrg_typ_id                          INTEGER     NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land_1 = 1 und Euro = 0',
   berichtskurs_typ_id                 INTEGER     NOT NULL DEFAULT 0 COMMENT 'Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_USER_WRG_TYP_ZU PRIMARY KEY (user_id, wrg_typ_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Zuordnung des FrontEnd-Users zu einem Währungstyp und Berichtskurstyp - über FrontEnd einstellbar.';
