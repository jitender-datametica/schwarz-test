CREATE OR REPLACE VIEW DBP_VIEW.V_L_LAGERBEREICHSKENNZEICHEN AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,lagerbereichskennzeichen_id


FROM DBP_DATA.l_lagerbereichskennzeichen ;