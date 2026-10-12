CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEMGROUP_INTERNATIONAL_1 as
   /*
   #DescStart#
   #$Revision: 6699 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Artikelstamm
   #DescEnd#
   */
   SELECT
   igi.client_id,
   igi.item_grp_int_sid,
   igi.src_itemgrp_int_cd,
   igi.src_itemgrp_int_id,
   igi.item_grp_int_name,
   igi_lidl.item_grp_int_descr_long AS itemgroup_desc_lidl_long,
   igi_default.item_grp_int_descr_long AS itemgroup_desc_default_long,
   igi_lidl.item_grp_int_descr AS itemgroup_desc_lidl,
   igi_default.item_grp_int_descr AS itemgroup_desc_default,
   igi_default.lang_cd,
   igi_lidl.lang_sid

  FROM p_lew_core_ac.v_itemgroup_international_1 AS igi
   INNER JOIN p_lew_core_ac.v_country_1 AS lidlctry
   ON igi.client_id = lidlctry.country_sid
   LEFT OUTER JOIN p_lew_core_ac.v_itemgroup_international_descr_1 AS igi_default
   ON igi_default.client_id = lidlctry.country_sid
   AND igi_default.lang_sid=lidlctry.lang_sid
   AND igi_default.item_grp_int_sid = igi.item_grp_int_sid
   LEFT OUTER JOIN p_lew_core_ac.v_itemgroup_international_descr_1 AS igi_lidl
   ON  igi_lidl.item_grp_int_sid = igi.item_grp_int_sid
   AND igi_lidl.lang_sid=2
   AND igi_lidl.client_id = igi.client_id
   ;