CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_KUNDE_AUFTRAG_EINTEIL
AS SELECT
mandant_id,
verkaufs_beleg_id,
verkaufs_beleg_pos_id,
einteil_id,
system_id,
dat_einteilung,
try_to_time(to_char(MOD(zeit_einteilung,'240000'),'000000'),'HH24MISS') as zeit_einteilung
FROM dbp_data.flw_kunde_auftrag_einteil
;