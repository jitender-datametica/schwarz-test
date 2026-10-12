--==============================================================
-- Table: fipo_person
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_person
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_PERSON (
   fipo_person_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID der Person aus prs_id',
   mandant_id                          INTEGER     NOT NULL DEFAULT 1 COMMENT 'Mandant im DWH',
   fipo_pos_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer FIPO-Position aus dem Quellfeld pos_id',
   rev_fb_id                           INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Revisions-Fachbereichs aus rfb_id',
   fipo_person_name                    VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Nachname der Person aus prs_name',
   fipo_person_vorname                 VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Vorname der Person aus prs_vorname',
   fipo_person_anrede                  VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Anrede der Person z.Bsp. Herr aus prs_anrede',
   dat_bis                             DATE             NOT NULL COMMENT 'Austrittsdatum der Perso aus prs_endedatum. Bei aktiven Personen der 31.12.9999',
   fipo_person_organisation            VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'ORGANISATION - Zuordnung der Person zu einer Gruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_PERSON PRIMARY KEY (fipo_person_id) NOT ENFORCED
)  COMMENT = 'FIPO - Tabelle der FIPO-Personen aus der Quelle personen';

