CREATE OR REPLACE VIEW DBP_VIEW.V_TOUR_PLOMBE_START_2
AS SELECT
mandant_id,
tour_id,
plombe_id,
plombe_pos_id,
nb_id,
wup_id,
plombe_vorgang_id,
dat_erfasst,
try_to_time(to_char(MOD(zeit_erfasst,'240000'),'000000'),'HH24MISS') as zeit_erfasst,
storno_fg

FROM dbp_data.tour_plombe_start_2

;