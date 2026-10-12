CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUG_2 as
   -- LOOKUP/ZUORDNUNG : Warenuntergruppe - Warengruppe
   -- 20120229 : Initial (neue Abteilungen)

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, v01.wug_id
   FROM dbp_view.v_wug_2 v01
   WHERE v01.arthiertyp_id = 2;