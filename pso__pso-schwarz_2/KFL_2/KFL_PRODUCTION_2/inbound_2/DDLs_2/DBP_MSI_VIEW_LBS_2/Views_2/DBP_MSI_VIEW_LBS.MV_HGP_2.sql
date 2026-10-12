CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_HGP_2(
	HGP_ID,
	HGP_NAME,
	MANDANT_ID,
	ZEK_ID
) AS
SELECT 
DISTINCT gp_id,
gp_name,
mandant_id,
zek_id

FROM dbp_view.v_gp_2
WHERE gp_id IN 
(SELECT hgp_id FROM dbp_view.v_gp_2);