--==============================================================
-- Table: tms_gp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_gp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_GP (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_gp_id                           VARCHAR(30)      NOT NULL COMMENT 'ID des Geschäftspartners. Aus plkd.nr',
   tms_gp_typ_cd                       VARCHAR(3)       NOT NULL COMMENT 'Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)',
   tms_gp_lfd_nr                       INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_gp im Quellsystem. Aus plkd.kd_id',
   tms_gp_name                         VARCHAR(50)      NOT NULL COMMENT 'Name des Geschäftspartners',
   tms_gp_altnv_name                   VARCHAR(50)      COMMENT 'Alternativer Name des Geschäftspartners',
   tms_gp_strasse                      VARCHAR(50)      COMMENT 'Straße des Geschäftspartners Adresse',
   tms_gp_ort_name                     VARCHAR(50)      COMMENT 'Ort des Geschäftspartners Adresse',
   tms_gp_plz                          VARCHAR(20)      COMMENT 'Postleitzahl des Geschäftspartners Adresse',
   tms_land_cd                         VARCHAR(5)       COMMENT 'Länderkennzeichen',
   sperr_fg                            INTEGER     COMMENT 'Kennzeichnung für Sperrung des Kunden',
   sammelbeleg_id                      INTEGER     COMMENT 'Kennzeichen für Sammelbelege (aktuell nur J/N/leer)',
   tms_standorttyp_id                  INTEGER     COMMENT 'Standort-Typ (Außenlager, VZ, FLW, Markt,…)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_GP PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die Informationen über Geschäftspartner (z. B. Lager, Spediteure, Märkte) im System, einschließlich Adressen, Sperr_fg und Standorttyp. Aus der Quelle plkd (WANKO)';
