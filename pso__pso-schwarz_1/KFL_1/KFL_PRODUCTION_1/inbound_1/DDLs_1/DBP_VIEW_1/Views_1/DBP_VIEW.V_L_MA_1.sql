CREATE OR REPLACE VIEW DBP_VIEW.V_l_ma_1 AS 
    SELECT 
        ma_id,
        dat_von,
        mandant_id,
        sap_ma_id,
        ma_funktion_id,
        dat_bis,
        td_update,
        td_insert
FROM DBP_DATA.l_ma_1 ;