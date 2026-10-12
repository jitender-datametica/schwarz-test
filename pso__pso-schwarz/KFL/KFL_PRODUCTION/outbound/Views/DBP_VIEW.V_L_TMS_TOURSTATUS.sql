CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_tourstatus (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_tourstatus_id
OPTIONS(description='ID des Tourstatus. Aus plini.entry'), tms_tourstatus_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_tour_status im Quellsystem. Aus plini.ini_id. Aus plini.ini_id'),
tms_tourstatus_bez OPTIONS(description='Bezeichnung zum Tourstatus. (Verladen, Abgerechnet,…)'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KENNZEICHNUNG DES STATUS VON TOUREN MIT EINDEUTIGEN BEZEICHNUNGEN UND BESCHREIBUNGEN FÜR VERSCHIEDENE TOURSTADIEN (Z. B. AN ABRECHNUNG ÜBERTRAGEN, ABGERECHNET, USW). AUS DER QUELLE PLINI (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_tourstatus_id,
 tms_tourstatus_lfd_nr,
 tms_tourstatus_bez
FROM kfl_production_dbp_data.l_tms_tourstatus;