--==============================================================
-- Table: tms_auftrag_text_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_text_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 15:44:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG_TEXT_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftrag_text_id                 INTEGER     NOT NULL COMMENT 'ID des Freitextes welcher dem Auftrag hinzugefügt wurde.',
   tms_satzart_id                      INTEGER     COMMENT 'ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:
            0 = 1. Lieferscheinnummer
            1 = 2. Lieferscheinnummer
            2 = 3. Lieferscheinnummer
             
            Unter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte für''s Be-/Entladen erfasst.
            87 = Bemerkung beim Beladen 
            88 = Bemerkung beim Entladen
            
            Über die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). ',
   tms_auftrag_unter_id                INTEGER     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. ',
   tms_text_typ_cd                     VARCHAR(30)      COMMENT 'Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = Versandeinheit
            D.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)
            Dasselbe analog für NVEs.',
   auftrag_txt                         VARCHAR(500)     COMMENT 'Inhalt des Freitextes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG_TEXT PRIMARY KEY (mandant_id, system_id, tms_auftrag_text_id) NOT ENFORCED
)  COMMENT = 'TMS - Tabelle enthält mögliche Freitexte die im Quellsystem den Aufträgen manuell zugeordnet werden können für ergänzende Informationen / Bemerkungen / etc.';
