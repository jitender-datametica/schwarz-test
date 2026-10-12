CREATE OR REPLACE VIEW kfl_production_dbp_view.v_retail_company_2 (ext_system_name
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'),
ext_retail_company_id OPTIONS(description='ID des Einzelhändlers im externen System.'), mandant_id
OPTIONS(description='Mandant_2 im DWH.'), retail_company_code
OPTIONS(description='Code des Einzelhändlers, wie vom Quellsystem bereitgestellt.'), retail_company_name
OPTIONS(description='Name des Marktes.'), competitor_fg
OPTIONS(description='Flag, das angibt, ob es sich um ein Kaufland-Unternehmen (Wert 0) oder einen Mitbewerber (Wert 1) handelt.'))
AS SELECT ext_system_name,
 ext_retail_company_id,
 mandant_id,
 retail_company_code,
 retail_company_name,
 competitor_fg
FROM kfl_production_dbp_data.retail_company_2;