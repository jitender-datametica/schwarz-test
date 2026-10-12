CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_GINFO_FLAECHE_2(
    MANDANT_ID,
    GINFO_FLAECHE_ID,
    GINFO_FLAECHE_TYP_ID,
    TECHN_PLATZ_ID,
    FLAECHE_QUELLE_ID,
    WUP_ID,
    GINFO_FLAECHE_NETTO,
    GINFO_FLAECHE_BRUTTO,
    GINFO_ACHSE_WERT,
    GINFO_ACHSE_TYP_ID,
    KJMO
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
   2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
*/
SELECT  
    fl.mandant_id, 
    fl.ginfo_flaeche_id, 
    fl.ginfo_flaeche_typ_id, 
    fl.techn_platz_id, 
    fl.flaeche_quelle_id,
    aktuell_wup_id              AS wup_id,
    flp.ginfo_flaeche_netto, 
    flp.ginfo_flaeche_brutto, 
    flp.ginfo_achse_wert, 
    flp.ginfo_achse_typ_id, 
    kjmo.kjmo
FROM 
dbp_view.v_l_ginfo_flaeche_2 fl
JOIN dbp_view.v_ginfo_flaeche_per_2 flp
ON fl.mandant_id = flp.mandant_id AND fl.ginfo_flaeche_id = flp.ginfo_flaeche_id AND fl.ginfo_flaeche_typ_id = flp.ginfo_flaeche_typ_id AND fl.techn_platz_id = flp.techn_platz_id
JOIN dbp_msi_view_vis.MV_WUP_TECHN_PLATZ_2 tpl 
ON flp.techn_platz_id = tpl.techn_platz_id
JOIN (
    SELECT kjmo, mo_dat_von 
    FROM DBP_MSI_VIEW_VIS.mv_monat_2 
    WHERE akt_mo = 0) kjmo
ON kjmo.mo_dat_von BETWEEN flp.dat_von AND flp.dat_bis
JOIN dbp_view.v_wup_2 wup_2
ON tpl.mandant_id = wup.mandant_id AND tpl.wup_id = wup.wup_id
;