CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HWG_ABT_ZU as
   -- LOOKUP/ZUORDNUNG : Hauptwarengruppe - Abteilung
   -- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
   -- 20150220 : Initial (BM 2.0)

   SELECT
   v01.mandant_id, v02.wg_hierarchie_id AS hwg_id, v01.wg_hierarchie_id AS abt_id

   FROM dbp_view.v_wg_hierarchie_zu_per v01
   INNER JOIN dbp_view.v_wg_hierarchie_zu_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wg_hierarchie_id = v02.wg_hierarchie_mutter_id
   AND v01.arthiertyp_id = v02.arthiertyp_id
   AND v02.wg_hierarchie_ebene_id = 3 --hwg
   AND v02.dat_bis = '9999-12-31'

   WHERE v01.arthiertyp_id = 5
   AND v01.wg_hierarchie_ebene_id = 2  --abt
   AND v01.dat_bis = '9999-12-31'
   ;