CREATE OR REPLACE VIEW DBP_VIEW.V_ma_funktion_wup_zu AS 
    SELECT 
        mandant_id,
        wup_id,
        ma_id,
        ma_funktion_id,
        td_update,
        td_insert
FROM DBP_DATA.ma_funktion_wup_zu ;