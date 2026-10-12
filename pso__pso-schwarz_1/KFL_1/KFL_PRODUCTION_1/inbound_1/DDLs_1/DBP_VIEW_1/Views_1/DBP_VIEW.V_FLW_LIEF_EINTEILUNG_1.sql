CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_LIEF_EINTEILUNG_1
AS SELECT
mandant_id,
best_beleg_id,
best_beleg_pos_id,
einteil_id,
charge_id,
dat_lief_wunsch,
try_to_time(to_char(MOD(zeit_lief_wunsch,'240000'),'000000'),'HH24MISS') as zeit_lief_wunsch,
datzeit_lief_wunsch,
system_id,
datzeit_lief_wunsch_az
FROM dbp_data.flw_lief_einteilung_1
;