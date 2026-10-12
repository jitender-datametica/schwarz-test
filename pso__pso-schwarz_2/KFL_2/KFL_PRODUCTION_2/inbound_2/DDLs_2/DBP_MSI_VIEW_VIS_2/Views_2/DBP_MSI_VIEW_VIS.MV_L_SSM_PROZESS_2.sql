CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SSM_PROZESS_2
AS
-- 09.04.2020 snik1809 AP0052955-SPEC0067085
-- 11.25.2020 snik1809	added rundung_typ_kz
-- 11.10.2023 muellerpatri  added mandant_id
SELECT
ssm_prozess_id,
ssm_aufwand_typ_id,
wup_abt_id,
treiber_id,
dat_von,
dat_bis,
ssm_prozess_bez,
dayforce_xrefcode,
dayforce_xrefcode_de,
dayforce_minimal_mapping,
oeffnung_laden_theken_fg,
rundung_typ_kz,
mandant_id
FROM dbp_view.v_l_ssm_prozess_2;


