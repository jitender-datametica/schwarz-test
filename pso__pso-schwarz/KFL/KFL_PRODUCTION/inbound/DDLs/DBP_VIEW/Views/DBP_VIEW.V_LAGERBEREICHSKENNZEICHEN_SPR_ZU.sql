CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERBEREICHSKENNZEICHEN_SPR_ZU AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,lagerbereichskennzeichen_id
        ,spr_id
        ,lagerbereichskennzeichen_bez


FROM DBP_DATA.lagerbereichskennzeichen_spr_zu ;