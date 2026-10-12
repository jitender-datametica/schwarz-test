CREATE OR REPLACE VIEW DBP_VIEW.V_L_PRUEFGRUND AS 
    SELECT 
        mandant_id,
        spr_id,
        z_arbeitsgebiet_id,
        pruef_id,
        pruef_bez,
        vis_pruef_bez
FROM DBP_DATA.L_PRUEFGRUND ;