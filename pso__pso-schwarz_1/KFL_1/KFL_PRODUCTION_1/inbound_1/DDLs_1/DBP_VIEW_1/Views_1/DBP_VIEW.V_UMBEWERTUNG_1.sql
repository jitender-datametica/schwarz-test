CREATE OR REPLACE VIEW DBP_VIEW.V_UMBEWERTUNG_1
AS SELECT
mandant_id,
pae_beleg_id,
kj,
dat_beleg,
dat_erfasst,
try_to_time(to_char(MOD(zeit_erfasst,'240000'),'000000'),'HH24MISS') as zeit_erfasst,
beleg_user_name
FROM dbp_data.umbewertung_1

;