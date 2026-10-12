CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_konto (mandant_id OPTIONS(description='Mandant im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_konto_id
OPTIONS(description='ID des Kontos (Kontonummer). Aus plkto.konto_nr'), tms_konto_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_konto im Quellsystem. Aus plkto.kto_id'), tms_konto_bez
OPTIONS(description='Bezeichnung zum Konto'), tms_konto_txt OPTIONS(description='Beschreibung des Kontos'),
tms_fibu_konto_cd OPTIONS(description='FIBU Konto (aktuell 3-Letter-Code)'), tms_kostenstelle_id
OPTIONS(description='Kostenstelle'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT DIE INFORMATIONEN ÜBER DIE KONTEN, EINSCHLIESSLICH FIBU KONTO CODE UND KOSTENSTELLE. SIE DIENT ZUR DIFFERENZIERUNG DER RECHNUNGSPOSITIONEN NACH KOSTENART. AUS DER QUELLE PLKTO (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_konto_id,
 tms_konto_lfd_nr,
 tms_konto_bez,
 tms_konto_txt,
 tms_fibu_konto_cd,
 tms_kostenstelle_id
FROM kfl_production_dbp_data.tms_konto;