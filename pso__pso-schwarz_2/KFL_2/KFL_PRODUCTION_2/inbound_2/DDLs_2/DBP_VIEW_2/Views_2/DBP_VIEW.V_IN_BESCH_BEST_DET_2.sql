CREATE OR REPLACE VIEW DBP_VIEW.V_IN_BESCH_BEST_DET_2 AS 
    SELECT 
        best_beleg_id
        ,best_beleg_pos_id
        ,mandant_id
        ,in_art_id
        ,menge_best_bme
        ,best_menge_einh_id
        ,best_preis_menge_einh_id
        ,loesch_id
        ,werk_id
        ,retourenpos_fg
        ,dupli_fg
        ,besch_pos_typ_id
        ,system_id
        ,nettopreis
        ,betrag_pos_netto_best_wrg
        ,endrech_fg
        ,rech_plan_id
        ,bsak_dat_buch
        ,menge_bme
        ,unterposition_typ_id
        ,in_wg_id
        ,k_shop_fg
        ,wrg_id


FROM DBP_DATA.in_besch_best_det_2 ;