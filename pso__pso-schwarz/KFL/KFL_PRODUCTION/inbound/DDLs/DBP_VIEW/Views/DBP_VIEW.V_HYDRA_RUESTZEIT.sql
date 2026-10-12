CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_RUESTZEIT AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        dat,
        praemiengrp_id,
        transport_gv_id,
        lagernummer_id,
        ewm_fg,
        dauer_ist,
        dauer_ruest,
        dauer_wechsel,
        dauer_sonstiges,
        abrechnung_fg

FROM DBP_DATA.HYDRA_RUESTZEIT ;