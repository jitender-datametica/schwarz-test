CREATE OR REPLACE VIEW DBP_VIEW.V_BSCH_BESTVOR_DET_1 AS 
    SELECT 
        mandant_id,
        best_vor_nr,
        best_vor_pos,
        dat_plan,
        art_id,
        gp_id,
        menge_best_vor,
        menge_best,
        status_1,
        best_vor_einh,
        best_einh,
        wup_id,
        nb_id,
        bestellart_id,
        dat_lief_soll

FROM DBP_DATA.BSCH_BESTVOR_DET_1 ;