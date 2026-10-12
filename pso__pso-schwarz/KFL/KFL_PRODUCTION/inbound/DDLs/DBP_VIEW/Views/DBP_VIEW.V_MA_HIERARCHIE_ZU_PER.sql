CREATE OR REPLACE VIEW DBP_VIEW.V_ma_hierarchie_zu_per AS 
    SELECT 
        ma_id,
        ma_mutter_id,
        dat_von,
        dat_bis,
        mandant_id,
        wup_id,
        ma_hierarchie_ebene_id,
        td_update,
        td_insert
FROM DBP_DATA.ma_hierarchie_zu_per ;