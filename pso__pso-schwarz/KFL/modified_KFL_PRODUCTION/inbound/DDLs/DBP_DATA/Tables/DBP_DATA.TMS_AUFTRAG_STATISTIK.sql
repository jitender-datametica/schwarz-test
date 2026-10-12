--==============================================================
-- Table: tms_auftrag_statistik
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_statistik
   generated from Powerdesigner on Montag, 10. März 2025 10:57:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG_STATISTIK (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plaust.au_nr',
   tms_auftrag_pos_id                  INTEGER     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen',
   auftrag_statistik_lfd_nr            INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_auftrag_statistik im Quellsystem. Aus plaust.aust_id',
   lief_beleg_id                       NUMBER(29,0)     COMMENT 'Lieferbeleg',
   kj_lief_beleg                       INTEGER     COMMENT 'Kalenderjahr aus LFDAT. Lookup in besch_lief, -1 für keinen Treffer',
   lieferkunde_tms_gp_id               VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Lieferkunde auftrifft',
   lieferkunde_tms_gp_typ_cd           VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Lieferkunde auftrifft',
   tms_tour_id                         INTEGER     COMMENT 'Tournummer',
   dat_tour                            DATE             COMMENT 'Tourdatum',
   betrag_kostenanteil                 NUMBER(38,16)    COMMENT 'Anteil des Kunden an den Eigenkosten oder Fremdkosten in Euro (NETTO)',
   tms_rech_beleg_id                   INTEGER     COMMENT 'Rechnungsnummer',
   dat_rechnung                        DATE             COMMENT 'Rechnungsdatum',
   dat_leistung                        DATE             COMMENT 'Datum der Leistung',
   abrechnungslauf_id                  INTEGER     COMMENT 'Abrechnungslauf',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG_STATISTIK PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_pos_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die statistische Daten zu TMS-Aufträgen. Aus der Quelle plaust (WANKO)';
