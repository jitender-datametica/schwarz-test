CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ADRESSE_ABHOLUNG_PLZ(
	LAND_ID,
	ORT,
	PLZ
) AS
--2022-05-23, AP0112140, SPEC0155506, dknop, initial
   SELECT land_id, ort, CAST(plz AS VARCHAR(10)) AS plz
   FROM dbp_view.v_belos_adresse
   
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort
   ,plz;