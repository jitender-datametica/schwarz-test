CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WARENVERLUST_PFLEGE_2(
	MANDANT_ID, 
    WUP_ID, 
    ART_ID,
    WG_HIST_ID,
    OWG_HIST_ID,
    HWG_HIST_ID,
    ABT_HIST_ID,
    INVENTURART_ID,
    DAT_INVENTUR_VON,
    DAT_INVENTUR_BIS,
    DAT_INVENTUR_BUCHUNG_VON,
    DAT_INVENTUR_BUCHUNG_BIS,
    GJ,
    INVENTUR_ID,
    LOESCH_FG
) AS  
/*	
    2025-05-17 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    wv.mandant_id
    , wup_id
    , art_id
    , wg_id                                  AS WG_HIST
    , owg_id                                AS OWG_HIST
    , hwg_id                                AS HWG_HIST
    , abt_id                                AS ABT_HIST 
    , inventurart_id                        
    , dat_inventur_von
    , dat_inventur_bis
    , dat_inventur_buchung_von
    , dat_inventur_buchung_bis
    , gj
    , inventur_id
    , loesch_fg
FROM dbp_view.v_inventur_warenverlust_2 wv
;