CREATE OR REPLACE VIEW DBP_VIEW.V_L_SSM_TREIBER_1 AS 
    SELECT 
        mandant_id
        ,treiber_id
        ,dat_von
        ,dat_bis
        ,treiber_bez
        ,aufgabe_tages_versatz
FROM DBP_DATA.L_SSM_TREIBER_1 ;