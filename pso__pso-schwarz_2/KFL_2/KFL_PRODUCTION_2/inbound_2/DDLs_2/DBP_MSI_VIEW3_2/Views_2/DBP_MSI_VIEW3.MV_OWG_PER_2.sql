CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_OWG_PER_2 as
   SELECT
   v01. owg_id, v01.arthiertyp_id, v01.mandant_id, v01.dat_von, v01.dat_bis, v01.hwg_id
   FROM dbp_view.v_owg_per_2 v01
   WHERE v01.arthiertyp_id=2
   AND v01.dat_bis = '9999-12-31';