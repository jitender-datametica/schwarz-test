create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_LAND_1(
	LAND_SORT_ID,
	LAND_ID,
	LAND_BEZ,
	WRG_ID_LAND
) as
   SELECT
   CASE
   WHEN mandant_id = 1 THEN 2
   WHEN mandant_id = 2 THEN 4
   WHEN mandant_id = 5 THEN 5
   WHEN mandant_id = 6 THEN 6
   WHEN mandant_id = 3 THEN 7
   WHEN mandant_id = 7 THEN 8
   WHEN mandant_id = 8 THEN 9
   WHEN mandant_id = 4 THEN 10
   END ::BYTEINT  AS land_sort_id, mandant_id   AS land_id, mandant_bez  AS land_bez, default_wrg AS wrg_id_land
   FROM dbp_view.v_mandant_1

   UNION ALL
   SELECT * FROM (
   SELECT
   1 ::BYTEINT   AS land_sort_id, -1 ::BYTEINT  AS land_id, 'INT'         AS land_bez, 'EUR' AS wrg_id_land
   ) t01

   UNION ALL
   SELECT * FROM (
   SELECT
   3 ::BYTEINT   AS land_sort_id, -2 ::BYTEINT  AS land_id, 'Ausland'     AS land_bez, 'EUR' AS wrg_id_land
   ) t02;