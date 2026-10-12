CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_PLATZIERUNGSWG_WUP_ZU_2(
    MANDANT_ID,
    SOK_PLATZIERUNGSWG_ID,
    WUP_ID,
    NB_ID,
    SOK_SM_ID,
    SOK_SAP_SM_ID,
    SOK_ANZ_ARTIKEL,
    SOK_MENGE_SOLL_FLAECHE_REGIO
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    wup.mandant_id
    , wup.platzierungswg_id             AS sok_platzierungswg_id
    , wup.wup_id
    , wup.nb_id
    , wup.sm_id                         AS sok_sm_id
    , sm.sap_sm_id                      AS sok_sap_sm_id
    , wup.anz_artikel                   AS sok_anz_artikel
    , wup.menge_soll_flaeche_regio      AS sok_menge_soll_flaeche_regio
FROM dbp_view.v_platzierungswg_wup_zu_2 wup_2
JOIN 
    (
        SELECT DISTINCT mandant_id, sm_id, sap_sm_id
        FROM dbp_view.v_sm_2
    ) sm_2
ON wup.mandant_id = sm.mandant_id AND wup.sm_id = sm.sm_id
;