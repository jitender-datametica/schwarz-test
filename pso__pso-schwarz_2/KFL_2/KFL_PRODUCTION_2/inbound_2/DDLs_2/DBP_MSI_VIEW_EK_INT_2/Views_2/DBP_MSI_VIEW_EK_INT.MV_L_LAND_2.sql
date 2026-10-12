CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_L_LAND_2
AS
   SELECT
   v01.mandant_id::BYTEINT  AS land_id, v01.mandant_id::BYTEINT  AS mandant_id, CASE
   WHEN v01.mandant_id = 1 THEN 2
   WHEN v01.mandant_id = 2 THEN 4
   WHEN v01.mandant_id = 5 THEN 5
   WHEN v01.mandant_id = 6 THEN 6
   WHEN v01.mandant_id = 3 THEN 7
   WHEN v01.mandant_id = 7 THEN 8
   WHEN v01.mandant_id = 8 THEN 9
   WHEN v01.mandant_id = 4 THEN 10
   END::BYTEINT  AS land_sort_id
   FROM dbp_view.v_mandant_2 v01

   UNION ALL
   SELECT
   -1::BYTEINT     AS land_id, v02.mandant_id::BYTEINT  AS mandant_id, 1::BYTEINT  AS land_sort_id
   FROM dbp_view.v_mandant_2 v02

   UNION ALL
   SELECT
   -2::BYTEINT      AS land_id, v03.mandant_id::BYTEINT   AS mandant_id, 3::BYTEINT  AS land_sort_id
   FROM dbp_view.v_mandant_2 v03
   WHERE v03.mandant_id NOT IN (1);