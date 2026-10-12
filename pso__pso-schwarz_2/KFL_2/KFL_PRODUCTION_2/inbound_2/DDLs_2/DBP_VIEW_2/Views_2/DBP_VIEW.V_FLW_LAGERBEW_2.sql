CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_LAGERBEW_2

AS SELECT
mandant_id,
lagerbew_beleg_id,
kj,
vorgangsart_id,
dat_beleg,
dat_buch,
dat_erfasst,
ref_lagerbew_beleg_id,
try_to_time(to_char(MOD(zeit_erfasst,'240000'),'000000'),'HH24MISS') as zeit_erfasst,
belegkopftext,
system_id
FROM dbp_data.flw_lagerbew_2
;