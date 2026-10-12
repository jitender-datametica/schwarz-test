--==============================================================
-- Table: geku_gebiets_betreuer
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_gebiets_betreuer
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_GEBIETS_BETREUER (
   gebiets_betreuer_uid                INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Gebietsbetreuers',
   fv_fg                               INTEGER     COMMENT 'Flag für Eigen/Fremdverteilung. Wert = 1 ist FV',
   fv_gb_id                            VARCHAR(60)      COLLATE 'en-ci' COMMENT 'ID FV / GB aus NILS aus fv_gb_id',
   gbb_name                            VARCHAR(60)      COLLATE 'en-ci' COMMENT '(Nach)name des Gebietsbetreuers aus fv_gb_id',
   gbb_vorname                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Vorname des Gebietsbetreuers aus vorname',
   gbb_anrede                          VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Anrede des Gebietsbetreuers aus text_out.salutation_uid',
   gbb_strasse                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Strasse des Gebietsbetreuers aus street',
   gbb_plz                             VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Postleitzahl des Gebietsbetreuers plz',
   gbb_ort                             VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Standort des Gebietsbetreuers aus stadt',
   gbb_land_id                         VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Land des Gebietsbetreuers',
   mandant_id                          INTEGER     COMMENT 'Mandant im DWH',
   gbb_email                           VARCHAR(250)     COLLATE 'en-ci' COMMENT 'email_Adresse des Gebietsbetreuers aus email',
   gbb_tel_mobil                       VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Mobilnummer des Gebietsbetreuers aus tel_mobil',
   gbb_telefon                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Telefonnummer des Gebietsbetreuers  aus telefon',
   gbb_fax                             VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Faxnummer des Gebietsbetreuers aus fax',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_GEBIETS_BETREUER PRIMARY KEY (gebiets_betreuer_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Gebietsbetreuer-Stammdaten aus der Tabelle wmd_area_responsibles';

