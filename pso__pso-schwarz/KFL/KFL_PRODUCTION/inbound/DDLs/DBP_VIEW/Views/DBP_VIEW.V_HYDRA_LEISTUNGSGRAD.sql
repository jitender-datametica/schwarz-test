CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_LEISTUNGSGRAD AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        dat,
        lohnart_id,
        zeitart_id,
        praemiengrp_id,
        transport_gv_id,
        lagernummer_id,
        ewm_fg,
        dauer_ist,
        dauer_soll,
        grad_leistung,
        menge,
        abrechnung_fg

FROM DBP_DATA.HYDRA_LEISTUNGSGRAD ;