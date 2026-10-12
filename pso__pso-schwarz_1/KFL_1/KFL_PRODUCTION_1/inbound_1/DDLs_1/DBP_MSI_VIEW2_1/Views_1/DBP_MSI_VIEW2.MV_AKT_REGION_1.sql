CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKT_REGION_1
(
    AKT_REGION_ID,
	SAP_REGION_ID,
	LAND_ID,
	REGION_NAME,
	MANDANT_ID
) 
AS
   SELECT
   region_id AS akt_region_id,
   sap_region_id, 
   land_id, 
   region_name, 
   mandant_id

   FROM dbp_view.v_region_1
   WHERE mandant_id=1
   AND land_id = 'DE';