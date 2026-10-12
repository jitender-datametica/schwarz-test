CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_PLOMBE_ZIEL_1
(
mandant_id
,nb_id
,wup_id
,tour_id
,plombe_id
,plombe_prozess_id
,plombe_aktivitaet
,dat_scan
,zeit_scan
)
AS
   SELECT
   mandant_id, nb_id, wup_id, tour_id, plombe_id, plombe_prozess_id, plombe_aktivitaet, dat_scan, zeit_scan
   FROM dbp_view.v_tour_plombe_ziel_1
   WHERE extract(year from dat_scan) >= year(current_timestamp) - 2

;