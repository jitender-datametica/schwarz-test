CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_tourtyp_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_tourtyp_id
OPTIONS(description='ID des Tourtyps. Aus plini.entry'), tms_tourtyp_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_tourtyp_1 im Quellsystem. Aus plini.ini_id'), tms_tourtyp_bez
OPTIONS(description='Bezeichnung zum Tourtyp. z. B. 105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KLASSIFIZIERUNG VON TOUREN FÜR VERSCHIEDENE TOURTYPEN (Z.B. "01 - ZUTOUR - KEINE ABRECHNUNG", "02 - ABHOLUNG LIEFERANT", USW). ES DIENT DER DETAILLIERTEN KATEGORISIERUNG VON TOUREN FÜR REPORTING UND ABRECHNUNG. JE NACH TOURART KÖNNEN VERSCHIEDENE TOURTYPEN VORKOMMMEN. AUS DER QUELLE PLINI (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_tourtyp_id,
 tms_tourtyp_lfd_nr,
 tms_tourtyp_bez
FROM kfl_production_dbp_data.l_tms_tourtyp_1;