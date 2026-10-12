CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_2 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 art_id
,mandant_id
,mwst_id
,land_id
,region_id
,kl_art_id
,dat_von
,dat_bis
,loesch_id
,bio_fg
,wg_art_fg
,posten_id
,lead_id
,leist_id
,discount_id
,verpart_id
,esb_id
,aldi_id
,zek_id
,gewart_id
,eigenmarke_id
,mutter_wb_id
,display_id
,best_menge_einh_id
,loeschvorm_fg
,mhd_zeitraum
,basismenge_einh_id
,artikelart_id
,faktor_nettoinhalt
)
AS
SELECT
v01.art_id,
v01.mandant_id,
v01.mwst_id,
v01.land_id,
v01.region_id,
v01.kl_art_id,
v01.dat_von,
v01.dat_bis,
v01.loesch_id,
v01.bio_fg,
v01.wg_art_fg,
CASE
WHEN v01.posten_id = 'PN' THEN v01.posten_id
ELSE ' ' END AS posten_id,
v01.lead_id,
CASE
WHEN v01.leist_id = ' ' THEN 'keine'
ELSE v01.leist_id END AS leist_id,
v01.discount_id,
v01.verpart_id,
v01.esb_id,
v01.aldi_id,
v01.zek_id,
v01.gewart_id,
v01.eigenmarke_id,
v01.mutter_wb_id,
v01.display_id,
v01.best_menge_einh_id,
v01.loeschvorm_fg,
v01.mhd_zeitraum,
v01.basismenge_einh_id,
v01.artikelart_id,
v01.faktor_nettoinhalt
FROM dbp_view.v_art_2 v01;
