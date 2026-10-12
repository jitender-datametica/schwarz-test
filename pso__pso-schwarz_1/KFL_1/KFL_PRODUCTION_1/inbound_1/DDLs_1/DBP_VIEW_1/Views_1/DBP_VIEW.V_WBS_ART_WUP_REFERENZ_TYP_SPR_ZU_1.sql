CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_ART_WUP_REFERENZ_TYP_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        spr_id,
        wbs_art_wup_ref_typ_id,
        wbs_art_wup_ref_typ_bez

FROM DBP_DATA.WBS_ART_WUP_REFERENZ_TYP_SPR_ZU_1 ;