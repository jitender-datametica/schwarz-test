CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ADRESSE_ABHOLUNG_ORT_2(
	LAND_ID,
	ORT
) AS
--2022-05-23, AP0112140, SPEC0155506, dknop, initial
   SELECT land_id, ort
   FROM dbp_view.v_belos_adresse_2
   
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort;