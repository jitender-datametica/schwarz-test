CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BER_ABT_ZU_PER_1
-- AP0021792 WG Refresh arthiertyp_id auf 10 umgestellt  und abt_1-tabelle eingebunden / sschuecke 16.04.2018
-- AP0021792 WG Refresh wg_hierarchie_mutter_id wird zu ber_id und wg_hierarchie_ebene_id = 2 / sschuecke 11.11.2018
(
abt_id
,ber_id
,mandant_id
,dat_von
,dat_bis
,arthiertyp_id
)
AS

   SELECT
   v01.wg_hierarchie_id AS abt_id,
   v01.wg_hierarchie_mutter_id ber_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id
   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
   INNER JOIN dbp_view.v_abt_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wg_hierarchie_id = v02.abt_id

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 2
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;