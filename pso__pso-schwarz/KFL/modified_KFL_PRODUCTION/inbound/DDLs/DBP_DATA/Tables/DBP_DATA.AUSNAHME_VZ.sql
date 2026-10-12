--==============================================================
-- Table: ausnahme_vz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausnahme_vz
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSNAHME_VZ (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant           ',
   ausnahme_vz_guid                    VARCHAR(32)      NOT NULL COMMENT 'GUID im ''CHAR'' Format in Großschreibung     ',
   meldungstyp_id                      VARCHAR(1)       COMMENT 'Meldungstyp: S Success, E Error, W Warning, I Info, A Abort ',
   nachrichtenhandler_id               VARCHAR(21)      COMMENT 'Nachrichtenhandler',
   arbeitsgebiet_id                    VARCHAR(20)      COMMENT 'Nachrichtenklasse      ',
   z_arbeitsgebiet_id                  INTEGER     COMMENT 'Nachrichtenklasse  ',
   nachrichtennummer                   INTEGER     COMMENT 'Nachrichtennummer    ',
   art_id                              VARCHAR(18)      COMMENT 'Artikelnummer       ',
   nachrichtenquelle_id                VARCHAR(1)       COMMENT 'Nachrichtenquelle',
   wup_id                              INTEGER     COMMENT 'Betrieb',
   nb_id                               INTEGER     DEFAULT -111 COMMENT 'Nebenbetrieb',
   gp_id                               INTEGER     COMMENT 'Kontonummer des Lieferanten bzw. Kreditors',
   gp_teilsortiment_id                 VARCHAR(10)      COMMENT 'Lieferantenteilsortiment       ',
   fremd_lagerort_id                   VARCHAR(4)       COMMENT 'Vorschlagslagerort für Fremdbeschaffung',
   best_beleg_id                       INTEGER     COMMENT 'Belegnummer des Einkaufsbelegs',
   nachrichtenstatus_id                VARCHAR(1)       COMMENT 'Message Status',
   dat_plan                            DATE             COMMENT 'Planungsdatum       ',
   nachrichtenklasse_id                VARCHAR(1)       COMMENT 'Klassifizierung der Nachricht      ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSNAHME_VZ PRIMARY KEY (mandant_id, ausnahme_vz_guid) NOT ENFORCED
)  COMMENT = 'Ausnahmen (VZ) = DC-Level Exceptions (e. g. Product stock < reach threshold etc.)';

