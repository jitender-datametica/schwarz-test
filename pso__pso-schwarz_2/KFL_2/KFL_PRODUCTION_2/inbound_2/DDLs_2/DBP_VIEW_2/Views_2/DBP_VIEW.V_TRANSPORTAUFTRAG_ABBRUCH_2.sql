CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTAUFTRAG_ABBRUCH_2
AS SELECT
transport_beleg_id,
mandant_id,
lagernummer_id,
wup_id,
nb_id,
abbr_pos_id,
dat_abbr,
try_to_time(to_char(MOD(zeit_abbr,'240000'),'000000'),'HH24MISS') as zeit_abbr,
ebene_wechsel_fg
FROM dbp_data.transportauftrag_abbruch_2

;