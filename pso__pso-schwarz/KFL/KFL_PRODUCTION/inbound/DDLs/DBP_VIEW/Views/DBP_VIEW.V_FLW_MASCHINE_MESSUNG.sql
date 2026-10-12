CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MASCHINE_MESSUNG AS 
    SELECT 
        werk_id,
        maschine_name,
        maschinenteil_name,
        datzeit_messung,
        rezept_nr,
        betriebsart_id,
        pasteur_stoerung_id,
        rezept_name,
        dauer_durchlaufzeit_sek,
        unten_soll_temp,
        oben_soll_temp,
        unten_ist_temp,
        oben_ist_temp,
        unten_ventilator_proz,
        oben_ventilator_proz

FROM DBP_DATA.FLW_MASCHINE_MESSUNG ;