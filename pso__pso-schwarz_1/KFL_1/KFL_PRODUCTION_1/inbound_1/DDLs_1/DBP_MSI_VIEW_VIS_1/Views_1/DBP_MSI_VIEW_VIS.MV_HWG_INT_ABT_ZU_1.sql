CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HWG_INT_ABT_ZU_1 as
   -- LOOKUP/ZUORDNUNG : Hauptwarengruppe (international) - Abteilung
   -- 2017.0320 ssch0611 : Initial - neue Struktur HWG/Abteilung

   SELECT DISTINCT
   v02.wg_hierarchie_id AS hwg_id, v01.wg_hierarchie_id AS abt_id, CASE when v02.wg_hierarchie_id > 0 THEN v01.wg_hierarchie_id * 100 + v02.wg_hierarchie_id ELSE 1000 - v02.wg_hierarchie_id END::SMALLINT AS sort_id

   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
   INNER JOIN dbp_view.v_wg_hierarchie_zu_per_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wg_hierarchie_id = v02.wg_hierarchie_mutter_id
   AND v01.arthiertyp_id = v02.arthiertyp_id
   AND v02.wg_hierarchie_ebene_id = 3 --hwg
   AND v02.dat_bis = '9999-12-31'

   WHERE v01.arthiertyp_id = 5
   AND v01.wg_hierarchie_ebene_id = 2  -- abt_1
   AND v01.dat_bis = '9999-12-31'

   ;