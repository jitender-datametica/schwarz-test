--==============================================================
-- Table: tms_auftrag_beschraenkung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_beschraenkung_zu_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG_BESCHRAENKUNG_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr',
   tms_auftrag_pos_id                  NUMBER(38,0)     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen',
   tms_beschraenkung_id                NUMBER(38,0)     NOT NULL COMMENT 'ID der Auftrags-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …',
   tms_beschraenkung_pos_nr            NUMBER(38,0)     COMMENT 'Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. au_bes1 = 1, au_bes2 = 2, au_bes3 = 3',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG_BESCHRAENKUNG_ZU PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_pos_id, tms_beschraenkung_id) NOT ENFORCED
)  COMMENT = 'TMS - Zuordnungstabelle für Aufträge mit Einschränkungen, um die für den Auftrag geltenden Einschränkungen zu definieren. Aus der Quelle plau (WANKO)';
