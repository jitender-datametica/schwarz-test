CREATE OR REPLACE VIEW DBP_VIEW.V_MHD_WAELZPLAN_PRUEF_ID_SPR_ZU_2 AS 
    SELECT 
        mandant_id
        ,waelzplan_pruef_id
        ,spr_id
        ,waelzplan_pruef_bez
FROM DBP_DATA.mhd_waelzplan_pruef_id_spr_zu_2 ;