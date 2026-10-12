CREATE OR REPLACE VIEW DBP_VIEW.V_TS_WBS_ARTIKEL_VZ_SHARE_2 AS 
    SELECT 
        mandant_id,
        art_id,
        aktion_id,
        angebot_id,
        kjwo,
        ausliefergruppe_id,
        gp_id,
        wup_id_vz,
        nb_id_vz,
        mandant_id_vz,
        rank_share,
        share_wert

FROM DBP_DATA.TS_WBS_ARTIKEL_VZ_SHARE_2 ;