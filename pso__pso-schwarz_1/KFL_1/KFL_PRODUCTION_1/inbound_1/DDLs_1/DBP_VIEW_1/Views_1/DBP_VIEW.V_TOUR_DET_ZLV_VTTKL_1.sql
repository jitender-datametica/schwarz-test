CREATE OR REPLACE VIEW DBP_VIEW.V_TOUR_DET_ZLV_VTTKL_1
AS SELECT
mandant_id,
nb_id,
wup_id,
tour_id,
kl_tour_pos_id,
lagernummer_id,
kunde_id,
mandant_id_kunde,
status_tour,
rundlauf_markt_fg,
try_to_time(to_char(MOD(zeit_plan_ankunft,'240000'),'000000'),'HH24MISS') as zeit_plan_ankunft,
menge_stp_geraeumt,
cd_fg,
wgvgrp_id,
dat_tour,
zeit_relevant_fg,
oug_tour_fg

FROM dbp_data.tour_det_zlv_vttkl_1

;