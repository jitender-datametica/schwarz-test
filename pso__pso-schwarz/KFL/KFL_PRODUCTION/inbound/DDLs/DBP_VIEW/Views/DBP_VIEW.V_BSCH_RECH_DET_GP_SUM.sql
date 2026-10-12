CREATE OR REPLACE VIEW DBP_VIEW.V_BSCH_RECH_DET_GP_SUM AS 
    SELECT 
        mandant_id
        ,dat
        ,gp_id
        ,vw_id
        ,ek_n
        ,wrg_id


FROM DBP_DATA.bsch_rech_det_gp_sum ;