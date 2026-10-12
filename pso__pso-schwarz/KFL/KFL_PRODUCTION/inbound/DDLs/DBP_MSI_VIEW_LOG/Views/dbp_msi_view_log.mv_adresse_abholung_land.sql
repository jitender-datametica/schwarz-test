CREATE OR REPLACE VIEW dbp_msi_view_log.MV_ADRESSE_ABHOLUNG_LAND(
	LAND_ID
) AS
--AP0112140, SPEC0155506, initial, dknop
   SELECT land_id
   FROM dbp_view.v_belos_adresse
   
   WHERE spedition_fg = 0
   GROUP BY land_id;