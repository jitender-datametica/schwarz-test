CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BEST_ENTW_TYP_1
 (
 mandant_id
 ,best_entw_typ_id
 ,nachbelastung_fg
 ,preis_pruefen_fg
 )
 AS
    SELECT
    mandant_id,
    best_entw_typ_id,
    nachbelastung_fg,
    preis_pruefen_fg
    FROM dbp_view.v_l_best_entw_typ_1
    WHERE mandant_id = 1;