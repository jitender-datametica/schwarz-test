create or replace view KFL_PRODUCTION.DBP_VIEW.V_IN_BESCH_BEST_DET(
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	MANDANT_ID,
	IN_ART_ID,
	MENGE_BEST_BME,
	BEST_MENGE_EINH_ID,
	BEST_PREIS_MENGE_EINH_ID,
	LOESCH_ID,
	WERK_ID,
	RETOURENPOS_FG,
	DUPLI_FG,
	BESCH_POS_TYP_ID,
	SYSTEM_ID,
	NETTOPREIS,
	BETRAG_POS_NETTO_BEST_WRG,
	ENDRECH_FG,
	RECH_PLAN_ID,
	BSAK_DAT_BUCH,
	MENGE_BME,
	UNTERPOSITION_TYP_ID,
	IN_WG_ID,
	K_SHOP_FG,
	WRG_ID
) as 
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


FROM DBP_DATA.in_besch_best_det ;