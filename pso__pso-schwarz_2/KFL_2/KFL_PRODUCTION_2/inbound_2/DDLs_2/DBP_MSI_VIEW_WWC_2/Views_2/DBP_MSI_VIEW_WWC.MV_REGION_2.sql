CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_REGION_2(
	REGION_ID,
	SAP_REGION_ID,
	LAND_ID,
	REGION_NAME,
	MANDANT_ID
) AS
   --11.06.2024, SPEC0255380, prescherad, Neualange 
   SELECT
   region_id, 
   sap_region_id, 
   land_id, 
   region_name, 
   mandant_id
   FROM dbp_view.v_region_2
   WHERE mandant_id=1
   AND land_id = 'DE';