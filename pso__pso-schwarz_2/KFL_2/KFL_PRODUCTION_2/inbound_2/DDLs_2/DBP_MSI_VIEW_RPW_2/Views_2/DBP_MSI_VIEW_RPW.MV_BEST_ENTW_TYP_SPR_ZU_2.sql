CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BEST_ENTW_TYP_SPR_ZU_2
    (
    mandant_id
    , best_entw_typ_id
    , best_entw_typ_kbez
    , best_entw_typ_bez
    )
    AS

       SELECT
       mandant_id,
       best_entw_typ_id,
       best_entw_typ_kbez,
       best_entw_typ_bez
FROM dbp_view.v_best_entw_typ_spr_zu_2

WHERE mandant_id = 1 and spr_id = 22;