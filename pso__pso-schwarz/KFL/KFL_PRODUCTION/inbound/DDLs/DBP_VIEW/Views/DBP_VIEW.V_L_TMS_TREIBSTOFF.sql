CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_TREIBSTOFF (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_treibstoff_id                        COMMENT 'ID des Treibstoffs (Nummer des Treibstoffs). Aus pltrst.trst_nr'
  ,tms_treibstoff_lfd_nr                    COMMENT 'SKey für die Tabelle l_tms_treibstoff im Quellsystem. Aus pltrst.trst_id'
  ,tms_treibstoff_bez                       COMMENT 'Bezeichnung zum Treibstoff'
  ,menge_einh_id                            COMMENT 'Einheit des Treibstoffs  ("L" und "KWH" gibt es auch in SAP)'
  ,menge_co2_pro_einheit                    COMMENT 'CO2-Emission pro verbrauchter Einheit in kg'
  ,menge_co2_aeq_pro_einheit                COMMENT 'CO2-Äquivalenzwert pro verbrauchter Einheit in Kg'
)
COMMENT = 'TMS - Referenztabelle zur Speicherung von Informationen über verschiedene Kraftstoffarten, z. B. Diesel, Strom. Aus der Quelle pltrst (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_treibstoff_id,
        tms_treibstoff_lfd_nr,
        tms_treibstoff_bez,
        menge_einh_id,
        menge_co2_pro_einheit,
        menge_co2_aeq_pro_einheit

FROM DBP_DATA.L_TMS_TREIBSTOFF ;