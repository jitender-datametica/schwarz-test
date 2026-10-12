CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGION_2
-- Einschränkung auf land_id, da SAP-Daten nicht sauber sind - sschuecke 10.09.2015
(
 region_id
,sap_region_id
,land_id
,region_name
,mandant_id
)
AS
   SELECT
   region_id, 
   sap_region_id, 
   land_id, 
   region_name, 
   mandant_id

   FROM dbp_view.v_region_2
   WHERE mandant_id=1
   AND land_id = 'DE';