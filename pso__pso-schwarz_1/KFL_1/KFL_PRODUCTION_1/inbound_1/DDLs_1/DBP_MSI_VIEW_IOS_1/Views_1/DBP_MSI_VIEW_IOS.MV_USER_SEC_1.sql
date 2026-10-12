CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_USER_SEC_1 as
   -- 20161111 kkaiser: user-Währung-typ_id

   SELECT distinct
   k.mandant_id, k.wrg_id, k.kurs_1, k.wrg_typ_id
   --, w.wrg_id

   FROM
   dbp_msi_view_ios.mv_user_kurs_1 k
   GROUP BY
   k.mandant_id
   , k.wrg_id
   , k.kurs_1
   , k.wrg_typ_id;