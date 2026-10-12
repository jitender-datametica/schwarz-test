CREATE OR REPLACE VIEW DBP_VIEW.V_ma_spr_zu AS 
    SELECT 
        ma_id,
        spr_id,
        ma_anrede,
        ma_name,
        ma_vorname,
        email,
        mobil_tel,
        ma_ldap,
        mandant_id,
        td_update,
        td_insert
FROM DBP_DATA.ma_spr_zu ;