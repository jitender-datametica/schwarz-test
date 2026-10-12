CREATE OR REPLACE VIEW DBP_VIEW.V_VAUS_WUP_OEFFNUNG_ZU_PER_2
AS SELECT
mandant_id,
wup_id,
wup_oeffnungs_typ_id,
dat_von,
dat_bis,
try_to_time(to_char(MOD(zeit_von,'240000'),'000000'),'HH24MISS') as zeit_von,
try_to_time(to_char(MOD(zeit_bis,'240000'),'000000'),'HH24MISS') as zeit_bis
FROM dbp_data.vaus_wup_oeffnung_zu_per_2

;