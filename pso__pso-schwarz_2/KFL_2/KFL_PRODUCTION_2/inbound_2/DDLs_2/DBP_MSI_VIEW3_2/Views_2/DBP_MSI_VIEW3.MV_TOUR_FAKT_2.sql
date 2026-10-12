CREATE OR REPLACE VIEW dbp_msi_view3.mv_tour_fakt_2
-- 02.11.2016 srom: AP0006317, SPEC0013463 tour_det.loesch_fg=0 einschränken
(
mandant_id
, nb_id
, wup_id
, tour_id
, dat_tour
, transportart_id
, gp_id
, lagernummer_id
, anzahl_tour
)
AS
SELECT
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.tour_id,
v01.dat_tour,
v01.transportart_id,
v01.gp_id,
v02.lagernummer_id,
v01.tour_id AS anzahl_tour     -- Nur mit count(distinct) verwendbar!!!

FROM dbp_view.v_tour_2 v01
INNER JOIN dbp_view.v_tour_det_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.nb_id = v02.nb_id
AND v01.tour_id = v02.tour_id
WHERE v02.loesch_fg = 0
AND extract(year from v01.dat_tour) >= year(current_timestamp) - 2;