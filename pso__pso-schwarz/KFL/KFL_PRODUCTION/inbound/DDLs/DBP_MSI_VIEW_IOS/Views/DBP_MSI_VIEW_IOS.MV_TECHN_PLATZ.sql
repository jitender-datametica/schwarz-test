CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TECHN_PLATZ as
   SELECT
   tp.mandant_id, tp.land_id, tp.techn_platz_id, tp.techn_platz_id AS tp_sort_techn_platz_id, tp.techn_platz_ebene_id, tp.teil_oeffentl_fg, tp.region_id, tp.system_id, tp.buchungskreis_id, tp.kostenstelle_id, tp.krk_id, tp.techn_platz_typ_id, CAST(NULL AS VARCHAR(20)) AS anlage_hauptnummer, tp.werk_instandhaltung_plan, tp.adresse_name1, tp.adresse_name2, tp.wup_stadt, tp.wup_plz, tp.wup_str

   FROM dbp_view.v_techn_platz_per tp

   WHERE tp.wup_stadt IS NOT NULL
   AND tp.dat_bis = '9999-12-31'

   UNION
   SELECT
   pr.mandant_id, pr.land_id, pr.techn_platz_id, pr.techn_platz_id AS tp_sort_techn_platz_id, 2  techn_platz_ebene_id  -- FIX
   , 0  teil_oeffentl_fg  -- FIX
   , pr.region_id, 0  system_id, 0  buchungskreis_id, '' kostenstelle_id, '' krk_id, '' techn_platz_typ_id, CAST(NULL AS VARCHAR(20)) AS anlage_hauptnummer, '' werk_instandhaltung_plan, COALESCE(pr.cpr_filialtyp_bez || ' ' || pr_s.projekt_kbez, pr_s.projekt_kbez)  adresse_name1, '' adresse_name2, pr.cpr_standort  wup_stadt, pr.cpr_plz  wup_plz, pr.cpr_str  wup_str

   FROM dbp_view.v_cpr_projekt_per pr
   LEFT JOIN dbp_msi_view_ios.mv_cpr_projekt_spr_zu  pr_s
   ON   pr.projekt_id = pr_s.projekt_id
   --AND  pr_s.spr_id = 22

   WHERE pr.mandant_id > 0
   AND pr.dat_bis = '9999-12-31'
   AND pr.techn_platz_id NOT IN
   (
   SELECT tp0.techn_platz_id  techn_platz_id
   FROM dbp_view.v_techn_platz_per tp0
   WHERE tp0.wup_stadt IS NOT NULL
   AND   tp0.techn_platz_ebene_id=2
   AND   tp0.dat_bis = '9999-12-31'
   )

   AND (techn_platz_id, cpr_ext_id) IN
   (
   SELECT
   pr1.techn_platz_id  techn_platz_id, MAX(pr1.cpr_ext_id)  cpr_ext_id
   FROM dbp_view.v_cpr_projekt_per  pr1
   WHERE pr1.cpr_standort IS NOT NULL
   AND pr1.dat_bis = '9999-12-31'
   GROUP BY techn_platz_id
   );