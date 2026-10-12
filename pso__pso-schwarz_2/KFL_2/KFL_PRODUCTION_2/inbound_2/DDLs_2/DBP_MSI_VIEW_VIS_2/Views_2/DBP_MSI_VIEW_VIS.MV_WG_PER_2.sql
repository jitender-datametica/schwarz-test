CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WG_PER_2 as
   -- LOOKUP/ZUORDNUNG : Warengruppe
   -- 2010KW07 : arthiertyp_2 2 für 3stellige WG
   -- 2018.09 : WG Refresh

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.lead_mwst_id, v01.wg_id, v01.owg_id, v01.abt_id, v01.dat_von, v01.dat_bis
   FROM dbp_view.v_wg_per_2 v01

   WHERE dat_bis = '9999-12-31'
   AND   arthiertyp_id = 2;