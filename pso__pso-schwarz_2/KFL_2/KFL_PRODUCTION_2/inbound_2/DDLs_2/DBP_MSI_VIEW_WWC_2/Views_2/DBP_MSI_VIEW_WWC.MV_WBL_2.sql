CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WBL_2
-- 06.07.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 mandant_id
,ek_flg
,gf_id
,ek_gf_id
,wbl_dat_von
,wbl_id
,wbl_name
)
AS SELECT
 mandant_id
,ek_fg
,gf_id
,gf_id AS ek_gf_id
,wbl_dat_von
,wbl_id
,wbl_name
FROM DBP_VIEW.v_wbl_2
WHERE mandant_id = 1;