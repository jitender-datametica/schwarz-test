CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_SPR_ZU_PER_2 as
   SELECT
   v111.projekt_id, v111.projekt_nr, v111.spr_id, v111.cpr_projekt_bez, v111.cpr_projekt_langtext, v111.projekt_kbez, v111.mandant_id, v111.dat_von, v111.dat_bis, v111.dat

   FROM
   (
   SELECT v11.*, COALESCE(v03.cpr_projekt_langtext,'') AS cpr_projekt_langtext FROM
   (
   SELECT
   v02.projekt_id, v04.cpr_ext_id AS projekt_nr, v02.spr_id, v02.cpr_projekt_bez, SUBSTR(v02.cpr_projekt_bez,4,80)::VARCHAR(80)  AS projekt_kbez, v04.mandant_id, v02.dat_von, v02.dat_bis, t.dat


   FROM dbp_view.v_cpr_projekt_spr_zu_per_2  v02
   LEFT JOIN dbp_view.v_tag_2 t
   ON t.dat BETWEEN v02.dat_von AND v02.dat_bis
   AND t.dat <= CURRENT_DATE
   INNER JOIN dbp_view.v_cpr_projekt_per_2 v04
   ON  v02.projekt_id = v04.projekt_id
   AND t.dat BETWEEN v04.dat_von AND v04.dat_bis
   INNER JOIN dbp_view.v_mandant_spr_zu_2 v06
   ON v02.spr_id = v06.spr_id

   --LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2  v05
   -- ON v02.projekt_id = v05.projekt_id
   --AND v05.spr_id = v02.spr_id

   --WHERE
   --v02.spr_id = 22 AND
   --v02.dat_bis = 80991231
   --AND v03.dat_bis = 80991231
   --AND v04.dat_bis = 80991231
   --AND v05.dat_bis = 80991231
   ) V11
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2  v03
   ON v11.projekt_id = v03.projekt_id
   AND v03.spr_id =22
   AND v11.dat BETWEEN v03.dat_von AND v03.dat_bis
   )
   v111;