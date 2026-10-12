CREATE OR REPLACE VIEW DBP_VIEW.V_TMS_KONTO_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_konto_id                             COMMENT 'ID des Kontos (Kontonummer). Aus plkto.konto_nr'
  ,tms_konto_lfd_nr                         COMMENT 'SKey für die Tabelle tms_konto_1 im Quellsystem. Aus plkto.kto_id'
  ,tms_konto_bez                            COMMENT 'Bezeichnung zum Konto_1'
  ,tms_konto_txt                            COMMENT 'Beschreibung des Kontos'
  ,tms_fibu_konto_cd                        COMMENT 'FIBU Konto_1 (aktuell 3-Letter-Code)'
  ,tms_kostenstelle_id                      COMMENT 'Kostenstelle'
)
COMMENT = 'TMS - Die Tabelle enthält die Informationen über die Konten, einschließlich FIBU Konto_1 Code und Kostenstelle. Sie dient zur Differenzierung der Rechnungspositionen nach Kostenart. Aus der Quelle plkto (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_konto_id,
        tms_konto_lfd_nr,
        tms_konto_bez,
        tms_konto_txt,
        tms_fibu_konto_cd,
        tms_kostenstelle_id

FROM DBP_DATA.TMS_KONTO_1 ;