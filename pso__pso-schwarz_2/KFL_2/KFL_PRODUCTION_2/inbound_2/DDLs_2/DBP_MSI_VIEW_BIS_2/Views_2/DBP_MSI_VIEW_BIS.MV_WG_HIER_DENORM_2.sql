CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_WG_HIER_DENORM_2 as
   SELECT
   in_wg_struktur_id      AS   in_wg_ebene1_id,
   in_wg_struktur_id      AS   in_wg_ebene2_id,
   in_wg_struktur_id      AS   in_wg_ebene3_id,
   in_wg_struktur_id      AS   in_wg_ebene4_id,
   in_wg_struktur_id      AS   in_wg_ebene5_id,
   in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2

   WHERE in_wg_struktur_ebene_id=1 AND
   in_wg_struktur_id NOT IN (SELECT  in_wg_struktur_mutter_id
   FROM dbp_view.v_in_wg_struktur_2
   WHERE in_wg_struktur_ebene_id=2
   )

   UNION

   SELECT
   e2. in_wg_struktur_mutter_id      AS   in_wg_ebene1_id,
   e2.in_wg_struktur_id      AS   in_wg_ebene2_id,
   e2.in_wg_struktur_id      AS   in_wg_ebene3_id,
   e2.in_wg_struktur_id      AS   in_wg_ebene4_id,
   e2.in_wg_struktur_id      AS   in_wg_ebene5_id,
   e2.in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2 e2
   WHERE  in_wg_struktur_ebene_id=2 AND e2. in_wg_struktur_id NOT IN (SELECT  in_wg_struktur_mutter_id
   FROM dbp_view.v_in_wg_struktur_2
   WHERE in_wg_struktur_ebene_id=3
   )

   UNION


   SELECT
   e2. in_wg_struktur_mutter_id      AS   in_wg_ebene1_id,
   e3.in_wg_struktur_mutter_id      AS   in_wg_ebene2_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene3_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene4_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene5_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2  e3
   INNER JOIN dbp_view.v_in_wg_struktur_2  e2
   ON e3.in_wg_struktur_ebene_id=3 AND
   e2.in_wg_struktur_ebene_id =2 AND
   e2.in_wg_struktur_id = e3.in_wg_struktur_mutter_id

   WHERE  e3.in_wg_struktur_ebene_id=3 AND e3.in_wg_struktur_id NOT IN (SELECT  in_wg_struktur_mutter_id
   FROM dbp_view.v_in_wg_struktur_2
   WHERE in_wg_struktur_ebene_id=4
   )


   UNION


   SELECT
   e2. in_wg_struktur_mutter_id      AS   in_wg_ebene1_id,
   e3.in_wg_struktur_mutter_id      AS   in_wg_ebene2_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene3_id,
   e4.in_wg_struktur_id      AS   in_wg_ebene4_id,
   e4.in_wg_struktur_id      AS   in_wg_ebene5_id,
   e4.in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2  e4
   INNER JOIN dbp_view.v_in_wg_struktur_2  e3
   ON e3.in_wg_struktur_id = e4.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e2
   ON e2.in_wg_struktur_id = e3.in_wg_struktur_mutter_id

   WHERE
   e2.in_wg_struktur_ebene_id=2  AND
   e3.in_wg_struktur_ebene_id=3   AND
   e4.in_wg_struktur_ebene_id=4

   AND
   e4.in_wg_struktur_id NOT IN (SELECT  in_wg_struktur_mutter_id
   FROM dbp_view.v_in_wg_struktur_2
   WHERE in_wg_struktur_ebene_id=5
   )

   UNION


   SELECT
   e2. in_wg_struktur_mutter_id      AS   in_wg_ebene1_id,
   e3.in_wg_struktur_mutter_id      AS   in_wg_ebene2_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene3_id,
   e4.in_wg_struktur_id      AS   in_wg_ebene4_id,
   e5.in_wg_struktur_id      AS   in_wg_ebene5_id,
   e5.in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2  e5
   INNER JOIN dbp_view.v_in_wg_struktur_2  e4
   ON e4.in_wg_struktur_id = e5.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e3
   ON e3.in_wg_struktur_id = e4.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e2
   ON e2.in_wg_struktur_id = e3.in_wg_struktur_mutter_id

   WHERE
   e2.in_wg_struktur_ebene_id=2  AND
   e3.in_wg_struktur_ebene_id=3   AND
   e4.in_wg_struktur_ebene_id=4   AND
   e5.in_wg_struktur_ebene_id= 5

   AND
   e5.in_wg_struktur_id NOT IN (SELECT  in_wg_struktur_mutter_id
   FROM dbp_view.v_in_wg_struktur_2
   WHERE in_wg_struktur_ebene_id=6
   )
   UNION

   SELECT
   e2. in_wg_struktur_mutter_id      AS   in_wg_ebene1_id,
   e3.in_wg_struktur_mutter_id      AS   in_wg_ebene2_id,
   e3.in_wg_struktur_id      AS   in_wg_ebene3_id,
   e4.in_wg_struktur_id      AS   in_wg_ebene4_id,
   e5.in_wg_struktur_id      AS   in_wg_ebene5_id,
   e6.in_wg_struktur_id      AS   in_wg_ebene6_id
   FROM dbp_view.v_in_wg_struktur_2  e6
   INNER JOIN dbp_view.v_in_wg_struktur_2  e5
   ON e5.in_wg_struktur_id = e6.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e4
   ON e4.in_wg_struktur_id = e5.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e3
   ON e3.in_wg_struktur_id = e4.in_wg_struktur_mutter_id
   INNER JOIN dbp_view.v_in_wg_struktur_2  e2
   ON e2.in_wg_struktur_id = e3.in_wg_struktur_mutter_id

   WHERE
   e2.in_wg_struktur_ebene_id=2  AND
   e3.in_wg_struktur_ebene_id=3   AND
   e4.in_wg_struktur_ebene_id=4   AND
   e5.in_wg_struktur_ebene_id= 5  AND
   e6.in_wg_struktur_ebene_id =6;