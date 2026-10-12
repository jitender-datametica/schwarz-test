CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_GF_2
(
 gf_id
,gf_name
,mandant_id
,ek_fg
)
AS
SELECT
 gf_id
,gf_name
,mandant_id
,ek_fg
FROM dbp_view.v_gf_2
WHERE ek_fg = 0
AND mandant_id > 1;