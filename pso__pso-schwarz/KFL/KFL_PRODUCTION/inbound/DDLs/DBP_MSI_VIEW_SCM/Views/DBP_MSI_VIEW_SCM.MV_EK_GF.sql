CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_EK_GF(
	GF_ID,
	GF_NAME,
	MANDANT_ID,
	EK_FG
) AS
--2024-01-24, dknop, remove v01.mandant_id = 1
SELECT v01.gf_id
      ,v01.gf_name
	  ,v01.mandant_id
	  ,v01.ek_fg 
FROM DBP_VIEW.v_gf v01

WHERE 
--v01.mandant_id = 1 AND 
v01.ek_fg = 1;