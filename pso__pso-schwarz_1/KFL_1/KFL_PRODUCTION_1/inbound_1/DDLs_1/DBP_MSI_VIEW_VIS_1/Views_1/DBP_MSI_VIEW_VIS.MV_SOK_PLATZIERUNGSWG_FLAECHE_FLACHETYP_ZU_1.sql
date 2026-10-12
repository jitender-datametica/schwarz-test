CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_PLATZIERUNGSWG_FLAECHE_FLACHETYP_ZU_1(
    MANDANT_ID,
    SOK_PLATZIERUNGSWG_ID,
    GINFO_FLAECHE_ID,
    GINFO_FLAECHE_TYP_ID,
    TECHN_PLATZ_ID,
    FLAECHE_QUELLE_ID,
    WUP_ID
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    fl.mandant_id
    , fl.platzierungswg_id AS sok_platzierungswg_id
    , fl.ginfo_flaeche_id
    , fl.ginfo_flaeche_typ_id
    , fl.techn_platz_id
    , fl.flaeche_quelle_id
    , tpl.wup_id
FROM dbp_view.v_platzierungswg_flaeche_flachetyp_zu_1 fl
INNER JOIN dbp_msi_view_vis.MV_WUP_TECHN_PLATZ_1 tpl ON fl.techn_platz_id = tpl.techn_platz_id
;