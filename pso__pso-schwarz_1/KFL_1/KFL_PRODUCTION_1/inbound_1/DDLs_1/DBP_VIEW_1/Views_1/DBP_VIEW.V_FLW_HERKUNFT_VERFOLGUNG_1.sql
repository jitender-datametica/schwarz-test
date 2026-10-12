CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_HERKUNFT_VERFOLGUNG_1 AS 
    SELECT 
        mandant_id,
        werk_id,
        aenderung_id,
        datzeit_erstellung,
        dat_produktion,
        alt_identifikation_id,
        neu_identifikation_id,
        alt_wechsel_id,
        neu_wechsel_id

FROM DBP_DATA.FLW_HERKUNFT_VERFOLGUNG_1 ;