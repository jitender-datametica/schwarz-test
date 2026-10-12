CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_beschraenkung_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_beschraenkung_id
OPTIONS(description='ID der Beschränkung (Nummer der Beschränkung). Aus plbes.besnr'), tms_beschraenkung_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_beschraenkung_2 im Quellsystem. Aus plbes.bes_id'), tms_beschraenkung_bez
OPTIONS(description='Bezeichnung zur Beschränkung'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR VERWALTUNG VON EINSCHRÄNKUNGEN FÜR TOUREN UND GESCHÄFTSPARTNERN, Z. B. NUR FRÜH- UND/ODER SPÄTANLIEFERUNG. AUS DER QUELLE PLBES (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_beschraenkung_id,
 tms_beschraenkung_lfd_nr,
 tms_beschraenkung_bez
FROM kfl_production_dbp_data.l_tms_beschraenkung_2;