CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_REGION_1
-- 11.12.2013 twie: Erweiterung um mandant_id 2
-- 15.09.2015 twie: auf land_id einschraenken, da Tabelle nicht richtig beladen
(
region_id
,sap_region_id
,land_id
,region_name
,mandant_id
)
AS
   SELECT
   region_id, sap_region_id, land_id, region_name, mandant_id
   FROM dbp_view.v_region_1
   WHERE (mandant_id = 1 AND land_id = 'DE')
   OR (mandant_id = 2 AND land_id = 'CZ');