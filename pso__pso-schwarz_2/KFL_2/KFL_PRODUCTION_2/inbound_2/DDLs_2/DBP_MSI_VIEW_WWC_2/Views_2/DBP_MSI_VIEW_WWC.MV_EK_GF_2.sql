CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_EK_GF_2
-- 06.07.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 mandant_id
 ,gf_id
,ek_gf_id
,gf_name
,ek_gf_name
,ek_flg
)
AS
SELECT
 mandant_id
,gf_id
,gf_id AS ek_gf_id
,gf_name
,gf_name AS ek_gf_name
,ek_fg 
FROM DBP_VIEW.v_gf_2 
WHERE mandant_id = 1
  AND ek_fg = 1;