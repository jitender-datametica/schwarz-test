CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_treibstoff_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_treibstoff_id
OPTIONS(description='ID des Treibstoffs (Nummer des Treibstoffs). Aus pltrst.trst_nr'), tms_treibstoff_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_treibstoff_1 im Quellsystem. Aus pltrst.trst_id'), tms_treibstoff_bez
OPTIONS(description='Bezeichnung zum Treibstoff'), menge_einh_id
OPTIONS(description='Einheit des Treibstoffs  ("L" und "KWH" gibt es auch in SAP)'), menge_co2_pro_einheit
OPTIONS(description='CO2-Emission pro verbrauchter Einheit in kg'), menge_co2_aeq_pro_einheit
OPTIONS(description='CO2-Äquivalenzwert pro verbrauchter Einheit in Kg'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR SPEICHERUNG VON INFORMATIONEN ÜBER VERSCHIEDENE KRAFTSTOFFARTEN, Z. B. DIESEL, STROM. AUS DER QUELLE PLTRST (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_treibstoff_id,
 tms_treibstoff_lfd_nr,
 tms_treibstoff_bez,
 menge_einh_id,
 menge_co2_pro_einheit,
 menge_co2_aeq_pro_einheit
FROM kfl_production_dbp_data.l_tms_treibstoff_1;