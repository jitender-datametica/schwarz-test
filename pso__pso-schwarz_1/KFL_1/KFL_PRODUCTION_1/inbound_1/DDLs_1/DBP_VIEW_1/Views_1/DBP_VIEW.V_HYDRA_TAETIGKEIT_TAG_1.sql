CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_TAETIGKEIT_TAG_1 AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        dat,
        taetigkeit_id,
        kostenstelle_id,
        dauer,
        abrechnung_fg

FROM DBP_DATA.HYDRA_TAETIGKEIT_TAG_1 ;