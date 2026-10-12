CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKSENDUNG(
	MANDANT_ID, 
    RUECKSENDUNG_BELEG_ID, 
    WUP_ID, 
    WA_NB_ID, 
    DAT, 
    ANZ_PALETTE, 
    GEFAHRSTOFF_FG, 
    RUECKSENDUNG_TYP_KZ, 
    RUECKSENDUNG_STATUS_ID,
    DAT_AENDERUNG, 
    DAT_ERSTELLUNG, 
    BEZUGSWEG_ID
) AS  
/*	
    2025-05-06 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    rs.mandant_id
    , ruecksendung_beleg_id
    , wup.aktuell_wup_id            AS WUP_ID
    , wa_nb_id
    , dat_lief                      AS DAT
    , anz_palette
    , gefahrstoff_fg
    , ruecksendung_typ_kz
    , ruecksendung_status_id
    , dat_aenderung
    , dat_erstellung
    , bezugsweg_id
FROM dbp_view.v_ruecksendung rs

INNER JOIN dbp_view.v_wup wup
ON rs.mandant_id = wup.mandant_id AND rs.wa_wup_id = wup.wup_id;
