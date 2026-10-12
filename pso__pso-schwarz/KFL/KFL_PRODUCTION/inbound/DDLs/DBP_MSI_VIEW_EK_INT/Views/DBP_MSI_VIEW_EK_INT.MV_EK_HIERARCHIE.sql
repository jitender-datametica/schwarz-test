CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_EK_HIERARCHIE
(
 mandant_id
,zek_id
,zek_name
,wbl_id
,wbl_name
,gf_id
,gf_name
)
AS
SELECT
  v01.mandant_id
, v01.zek_id
, v01.zek_name
, v01.wbl_id
, v02.wbl_name
, v02.gf_id
, v03.gf_name

FROM dbp_view.v_zek v01

INNER JOIN dbp_view.v_wbl v02
ON v01.mandant_id = v02.mandant_id
AND v01.wbl_id = v02.wbl_id

INNER JOIN dbp_view.v_gf v03
ON v02.mandant_id = v03.mandant_id
AND v02.gf_id = v03.gf_id;