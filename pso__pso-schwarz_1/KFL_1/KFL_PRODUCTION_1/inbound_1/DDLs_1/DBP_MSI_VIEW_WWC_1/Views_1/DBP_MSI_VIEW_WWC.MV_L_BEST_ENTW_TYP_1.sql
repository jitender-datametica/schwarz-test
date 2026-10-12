CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BEST_ENTW_TYP_1
(
mandant_id
,BEWTP
,nachbelastung_fg
,preis_pruefen_fg
)
AS
   SELECT
   mandant_id, best_entw_typ_id   AS BEWTP, nachbelastung_fg, preis_pruefen_fg
   FROM dbp_view.v_l_best_entw_typ_1
;