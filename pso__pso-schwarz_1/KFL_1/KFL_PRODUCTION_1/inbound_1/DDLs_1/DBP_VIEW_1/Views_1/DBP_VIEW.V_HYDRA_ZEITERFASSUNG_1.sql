CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_ZEITERFASSUNG_1 AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        dat,
        dauer,
        abrechnung_fg

FROM DBP_DATA.HYDRA_ZEITERFASSUNG_1 ;