--==============================================================
-- Table: fipo_l_kategorie
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_kategorie
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_KATEGORIE (
   fipo_kategorie_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id',
   fipo_bereich_id                     INTEGER     COMMENT 'Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id',
   fipo_kategorie_nr                   INTEGER     COMMENT 'Sortierkriterium für die Kategorien- Quellfeld kat_nr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_KATEGORIE PRIMARY KEY (fipo_kategorie_id) NOT ENFORCED
)  COMMENT = 'FIPO - Kategorien (Hierarchie: Prüfmodule-Bereiche-Kategorien-Prüfpunkte) - Quelltabelle kategorien';

