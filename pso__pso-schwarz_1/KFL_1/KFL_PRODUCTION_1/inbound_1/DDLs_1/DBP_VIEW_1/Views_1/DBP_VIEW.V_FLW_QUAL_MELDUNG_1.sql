CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_QUAL_MELDUNG_1
AS SELECT
mandant_id,
qual_meldung_id,
meldungsart_id,
flw_lief_id,
best_beleg_id,
try_to_time(to_char(MOD(zeit_pforte,'240000'),'000000'),'HH24MISS') as zeit_pforte,
dat_erfasst,
system_id
FROM dbp_data.flw_qual_meldung_1
;