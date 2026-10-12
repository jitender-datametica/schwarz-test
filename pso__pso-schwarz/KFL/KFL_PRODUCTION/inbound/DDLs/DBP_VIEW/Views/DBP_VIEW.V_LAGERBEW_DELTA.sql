CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERBEW_DELTA
AS SELECT
mandant_id,
lagerbew_beleg_id,
kj,
vorgangsart_id,
dat_buch,
beleg_user_name,
ref_lagerbew_beleg_id,
dat_beleg,
dat_erfasst,
belegart_id,
belegkopftext,
waren_begl_schein_id,
system_id,
ref_lagerbew_beleg_id_num,
lief_gp_id,
try_to_time(to_char(MOD(zeit_erfasst,'240000'),'000000'),'HH24MISS') as zeit_erfasst,
transaktion_code
FROM dbp_data.lagerbew_delta

;