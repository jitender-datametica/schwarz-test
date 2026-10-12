CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_HWG_2 as
   -- LOOKUP : Hauptwarengruppe
   -- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
   -- 20150220 : Initial (BM 2.0)

   SELECT
   v01.mandant_id, v01.wg_hierarchie_id AS hwg_id

   FROM dbp_view.v_wg_hierarchie_zu_per_2 v01

   WHERE v01.arthiertyp_id = 5
   AND v01.wg_hierarchie_ebene_id = 3  --hwg
   AND v01.dat_bis = '9999-12-31'
;