CREATE OR REPLACE VIEW DBP_VIEW.V_PEP_PERSONAL_BEW_ZEIT_1
AS SELECT
mandant_id,
idcompany,
idpersonal,
dat,
try_to_time(to_char(MOD(zeit_kom,'240000'),'000000'),'HH24MISS') as zeit_kom,
zeit_sekunden,
zeit_kom_orig_fg,
zeit_geh_orig_fg
FROM dbp_data.pep_personal_bew_zeit_1

;