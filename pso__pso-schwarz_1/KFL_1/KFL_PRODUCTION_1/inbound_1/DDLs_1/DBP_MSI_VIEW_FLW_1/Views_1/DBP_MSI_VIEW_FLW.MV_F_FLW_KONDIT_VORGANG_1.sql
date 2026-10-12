CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_KONDIT_VORGANG_1
   AS 
   SELECT
   v01.mandant_id, v01.beleg_kondition_id, v01.beleg_kondition_pos_id
   , v01.beleg_konditionsart_id
   , CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
   THEN v01.betrag_beleg_kondition
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
   THEN ( v01.betrag_beleg_kondition / v500.umrechnungskurs)
   --Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
   THEN v01.betrag_beleg_kondition * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
   THEN v01.betrag_beleg_kondition
   END AS betrag_beleg_kondition
   , werk_id, loesch_id, best_beleg_pos_id, best_beleg_id, in_art_id
   , in_lief_id
   FROM dbp_msi_view_flw.tbl_mv_f_flw_kondit_vorgang_1 v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
   JOIN
   dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat_lief_wunsch BETWEEN v500.dat_von AND v500.dat_bis;