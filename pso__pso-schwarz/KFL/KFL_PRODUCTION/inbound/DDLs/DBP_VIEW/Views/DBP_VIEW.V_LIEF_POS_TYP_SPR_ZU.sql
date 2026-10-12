CREATE OR REPLACE VIEW DBP_VIEW.V_lief_pos_typ_spr_zu AS 
    SELECT 
        mandant_id,
        lief_pos_typ_id,
        spr_id,
        lief_pos_typ_bez
FROM DBP_DATA.lief_pos_typ_spr_zu ;