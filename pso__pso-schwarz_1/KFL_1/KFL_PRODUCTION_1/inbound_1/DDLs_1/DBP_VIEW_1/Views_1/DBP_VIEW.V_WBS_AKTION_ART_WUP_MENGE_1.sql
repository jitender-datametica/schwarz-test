CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_AKTION_ART_WUP_MENGE_1 AS 
    SELECT 
        mandant_id,
        wup_id,
        wup_id_vz,
        nb_id,
        nb_id_vz,
        art_id,
        dat_ab,
        dat_bis,
        bonuskauf_promotionstyp,
        dat_lief_split,
        bestellmenge_final_ame,
        menge_initial_ame,
        menge_wbs,
        init_lief_modus_kz

FROM DBP_DATA.WBS_AKTION_ART_WUP_MENGE_1 ;