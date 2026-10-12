--==============================================================
-- Table: ts_wup_tm_gp_kosten_upload_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_tm_gp_kosten_upload_per_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WUP_TM_GP_KOSTEN_UPLOAD_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_gp_id                           VARCHAR(30)      NOT NULL COMMENT 'ID des Geschäftspartners. Aus plkd.nr  (hier: Spedition)',
   tms_gp_typ_cd                       VARCHAR(3)       NOT NULL COMMENT 'Geschäftspartnertyp. L- Lager, S - Spediteur, 0(null) - Markt(Kunde)     (hier: nur Speditionen)',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum  (hier: nur Werk)',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kosten_upload_fg                    INTEGER     COMMENT 'Flag: für Touren die von einer gg. Spedition aus einem gg. VZ gefahren werden, werden Daten in der Tabelle transportation_unit_kosten_upload erwartet',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültig bis',
   dat_von                             DATE             COMMENT 'Gültig von',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WUP_TM_GP_KOSTEN_UPLOAD_PER PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd, wup_id, nb_id, dat_bis) NOT ENFORCED
)  COMMENT = 'Transaction Services Table - User can maintain when to expect a record in Upload Table (dbp_data.transportation_unit_kosten_1)  for a given TDL/DC combination';
