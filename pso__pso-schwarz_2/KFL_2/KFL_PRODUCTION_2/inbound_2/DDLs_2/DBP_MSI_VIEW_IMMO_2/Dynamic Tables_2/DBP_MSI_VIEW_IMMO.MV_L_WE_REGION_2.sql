CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_WE_REGION_2(
	MANDANT_ID,
	MANDANT_KBEZ,
	WE_REGION,
	KURZBESCHREIBUNG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   mandant_id, mandant_kbez, CAST('E'AS VARCHAR(5)) AS we_region, CAST('Süd-West' AS VARCHAR(20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'D' AS we_region, CAST('West' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'C' AS we_region, CAST('Süd-Ost' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'N' AS we_region, CAST('Ost' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'O' AS we_region, CAST('Mitte' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'S' AS we_region, CAST('Sonstige' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'W' AS we_region, CAST('Nord' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, '1' AS we_region, CAST('Region_2 1' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, '2' AS we_region, CAST('Region_2 2' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, '3' AS we_region, CAST('Region_2 3' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'Y' AS we_region, CAST('Süd' AS VARCHAR (20)) AS kurzbeschreibung
   FROM dbp_view.v_mandant_2
   

   UNION ALL

   SELECT
   mandant_id, mandant_kbez, 'n.v.' AS we_region, mandant_bez AS kurzbeschreibung
   FROM dbp_view.v_mandant_2

;