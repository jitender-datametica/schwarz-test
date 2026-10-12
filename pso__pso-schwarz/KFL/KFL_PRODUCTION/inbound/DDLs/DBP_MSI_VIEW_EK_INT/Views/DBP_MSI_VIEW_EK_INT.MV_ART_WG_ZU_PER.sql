CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ART_WG_ZU_PER
(
art_id
,mandant_id
,arthiertyp_id
,wug_id
,wg_id
,dat_von
,dat_bis
)
AS
   SELECT
   v01.art_id, v01.mandant_id, v01.arthiertyp_id, v01.wug_id, v01.wg_id, v01.dat_von, v01.dat_bis

   FROM dbp_view.v_art_wg_zu_per v01

   WHERE v01.arthiertyp_id = 2
   AND   v01.dat_bis = '9999-12-31';