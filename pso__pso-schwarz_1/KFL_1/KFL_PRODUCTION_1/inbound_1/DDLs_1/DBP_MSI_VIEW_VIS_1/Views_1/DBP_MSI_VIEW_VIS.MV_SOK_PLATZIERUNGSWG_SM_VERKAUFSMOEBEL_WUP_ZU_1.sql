CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_PLATZIERUNGSWG_SM_VERKAUFSMOEBEL_WUP_ZU_1(
    MANDANT_ID,
    SOK_PLATZIERUNGSWG_ID,
    VS_ID,
    SOK_SM_ID,
    SOK_VERKAUFSMOEBEL_ID,
    SOK_MENGE_SOLL_FLAECHE,
    SOK_FLAECHE_EINH_ID,
    WUP_ID
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
   2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
*/
SELECT 
    vm.mandant_id
    , vm.platzierungswg_id AS sok_platzierungswg_id
    , vm.vs_id
    , vm.sm_id AS sok_sk_id
    , vm.verkaufsmoebel_id AS sok_verkaufsmoebel_id
    , vm.menge_soll_flaeche AS sok_menge_soll_flaeche
    , vm.flaeche_einh_id AS sok_flaeche_einh_id
    , wup.wup_id
FROM dbp_view.v_platzierungswg_vs_sm_verkaufsmoebel_zu_1 vm
JOIN dbp_data.wup_1 wup_1 
ON wup.vs_id = vm.vs_id AND wup.mandant_id = vm.mandant_id
JOIN dbp_view.v_platzierungswg_wup_zu_1 pwup
ON vm.mandant_id = pwup.mandant_id AND vm.platzierungswg_id = pwup.platzierungswg_id AND wup.wup_id = pwup.wup_id AND vm.sm_id = pwup.sm_id
WHERE wup.nb_id = 0 AND wup.aktuell_wup_id = wup.wup_id
;