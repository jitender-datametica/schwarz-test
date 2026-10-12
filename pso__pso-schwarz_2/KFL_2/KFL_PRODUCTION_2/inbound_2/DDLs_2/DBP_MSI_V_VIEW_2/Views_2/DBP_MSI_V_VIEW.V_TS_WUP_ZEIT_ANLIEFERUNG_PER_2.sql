CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WUP_ZEIT_ANLIEFERUNG_PER_2 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        transportsortiment_id,
        dat_von,
        dat_bis,
        zeit_anlieferung,
        zeit_anlieferung_num

FROM DBP_MSI_DATA.TS_WUP_ZEIT_ANLIEFERUNG_PER_2 ;