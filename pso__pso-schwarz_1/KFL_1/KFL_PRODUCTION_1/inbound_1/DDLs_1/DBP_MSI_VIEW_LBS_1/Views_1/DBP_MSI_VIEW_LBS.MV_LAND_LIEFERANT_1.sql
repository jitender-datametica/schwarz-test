CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_LAND_LIEFERANT_1(
	MANDANT_ID,
	LAND_ID,
	LAND_BEZ
) AS
   SELECT
   v01.mandant_id, v01.land_id, v01.land_bez

   FROM dbp_view.v_land_1 v01;