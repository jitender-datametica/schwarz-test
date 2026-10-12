CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_PLOMBE_START
(
mandant_id
,tour_id
,plombe_id
,plombe_pos_id
,nb_id
,wup_id
,plombe_vorgang_id
,dat_erfasst
,zeit_erfasst
,storno_fg
)
AS
   SELECT
   mandant_id, tour_id, plombe_id, plombe_pos_id, nb_id, wup_id, plombe_vorgang_id, dat_erfasst, zeit_erfasst, storno_fg
   FROM dbp_view.v_tour_plombe_start
;