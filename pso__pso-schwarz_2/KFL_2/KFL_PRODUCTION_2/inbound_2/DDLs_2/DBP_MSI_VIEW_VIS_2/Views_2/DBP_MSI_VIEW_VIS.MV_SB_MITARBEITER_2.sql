CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_MITARBEITER_2 as -- LOOKUP/ZUORDNUNG Mitarbeiter + Beurteiler Schnellbeurteilung
   -- Auschnitt aus MA-Hierarchie fuer Schnellbeurteilung + Zuordnung Beurteiler
   -- Anreicherung der SB-Hierachietypen und Funktionen
   -- 20120402 : Initial
   --20120419 : Join VAUS Hierachie (typ 1) entfernt
   -- 20131031 : KKaiser : Mandant_2-Abfrage bei v10 hinzugefügt, weil wohl nicht mehr eindeutig
SELECT v00.mandant_id,
   v00.ma_id,
   COALESCE(v01.ma_ldap, '') AS ma_ldap,
   COALESCE(v01.email, '') AS ma_email,
   COALESCE(v01.mobil_tel, '') AS ma_mobil_tel,
   '' AS ma_funktion_sb,
   v02.ma_funktion_id AS ma_bereich_sb,
   v03.ma_funktion_id AS ma_position_sb,
   v10.beurteiler_id,
   v10.operativ_fg,
   v10.anz_sb_soll,
   v10.anz_sb_gelb_bis,
   v10.anz_sb_rot_bis
FROM dbp_view.v_l_ma_2 v00
   JOIN dbp_view.v_ma_spr_zu_2 v01 ON v01.mandant_id = v00.mandant_id
   AND v01.ma_id = v00.ma_id
   JOIN dbp_view.v_sb_beurteiler_2 v10 ON v10.ma_id = v00.ma_id
   and v10.mandant_id = v00.mandant_id
   LEFT JOIN dbp_view.v_ma_hierarchie_ma_zu_per_2 v02 ON v02.ma_id = v00.ma_id
   AND v02.ma_hierarchie_typ_id = 2
   AND v02.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_ma_hierarchie_ma_zu_per_2 v03 ON v03.ma_id = v00.ma_id
   AND v03.ma_hierarchie_typ_id = 3
   AND v03.dat_bis = '9999-12-31'
WHERE v00.dat_bis = '9999-12-31';