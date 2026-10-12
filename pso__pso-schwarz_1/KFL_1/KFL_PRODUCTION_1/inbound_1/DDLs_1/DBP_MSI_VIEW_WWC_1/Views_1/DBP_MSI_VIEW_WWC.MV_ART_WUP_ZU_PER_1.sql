CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_WUP_ZU_PER_1
-- AP0032822, SPEC0041631 - 30.10.2108, mkub1811 neue View
(
art_id
, BWSCL -- bezugsweg_id
, dat_bis
, dat_von
, listung_id
, mandant_id
, nb_id
, vk_brutto
, wup_id
, kdis_kz
, kdis_aenderung_dat
)
AS
   SELECT
   v01.art_id, v01.bezugsweg_id, v01.dat_bis, v01.dat_von, v01.listung_id, v01.mandant_id, v01.nb_id, v01.vk_brutto, v01.wup_id, v01.kdis, CURRENT_DATE
   FROM dbp_view.v_art_wup_zu_per_1 v01
   WHERE v01.dat_bis = '9999-12-31'
   -- 20100330 Filterung der IWT Betriebe
   AND v01.nb_id <> 99;