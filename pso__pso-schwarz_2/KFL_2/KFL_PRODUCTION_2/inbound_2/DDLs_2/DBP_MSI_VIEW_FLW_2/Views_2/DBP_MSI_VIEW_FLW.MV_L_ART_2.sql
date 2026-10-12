CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ART_2
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 23.10.2013 twie: Join auf in_art_2 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
-- 25.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 06.02.2014 twie: direkt in_art_id auslesen statt Alias auf flw_art_id -> Performanceverbesserung

(
art_id
,mandant_id
,in_art_id
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
,artikelart_id
,basismenge_einh_id
,faktor_nettoinhalt
,mutter_vk_id
,lager_prozent
,temperatur_id
,duales_system_fg
,grs_fg
,ear_fg
,gema_fg
,lactose_fg
,gluten_fg
,diaet_fg
,artikeltyp_id
,verkauf_sperre_fg
,einh_id
,platz_relevant_fg
,bitrex_fg
,blauer_engel_fg
,dachlogo_fg
,dolphin_safe_fg
,euro_blume_fg
,ecocert_fg
,eier_bh_fh_fg
,fair_trade_fg
,fos_fg
,fsc_fg
,gap_fg
,gots_fg
,halal_fg
,kaninchen_bh_fg
,keimling_fg
,kein_stopf_rupf_fg
,msc_fg
,kon_nat_kosmetik_fg
,natrue_fg
,naturland_fg
,ohne_gentechnik_fg
,oeko_tex_fg
,pefc_fg
,rainforest_fg
,sustain_clean_fg
,tierschutz_gepr_fg

)
AS

   SELECT
   v01.art_id, v01.mandant_id, v02.in_art_id, v01.mwst_id, v01.land_id, v01.region_id, v01.kl_art_id, v01.dat_von, v01.dat_bis, v01.loesch_id, v01.bio_fg, v01.wg_art_fg, v01.posten_id, v01.lead_id, v01.leist_id, v01.discount_id, v01.verpart_id, v01.esb_id, v01.aldi_id, v01.zek_id, v01.gewart_id, v01.eigenmarke_id, v01.mutter_wb_id, v01.display_id, v01.best_menge_einh_id, v01.loeschvorm_fg, v01.mhd_zeitraum, v01.artikelart_id, v01.basismenge_einh_id, v01.faktor_nettoinhalt, v01.mutter_vk_id, v01.lager_prozent, v01.temperatur_id, v01.duales_system_fg, v01.grs_fg, v01.ear_fg, v01.gema_fg, v01.lactose_fg, v01.gluten_fg, v01.diaet_fg, v01.artikeltyp_id, v01.verkauf_sperre_fg, v01.einh_id, v01.platz_relevant_fg, v01.bitrex_fg, v01.blauer_engel_fg, v01.dachlogo_fg, v01.dolphin_safe_fg, v01.euro_blume_fg, v01.ecocert_fg, v01.eier_bh_fh_fg, v01.fair_trade_fg, v01.fos_fg, v01.fsc_fg, v01.gap_fg, v01.gots_fg, v01.halal_fg, v01.kaninchen_bh_fg, v01.keimling_fg, v01.kein_stopf_rupf_fg, v01.msc_fg, v01.kon_nat_kosmetik_fg, v01.natrue_fg, v01.naturland_fg, v01.ohne_gentechnik_fg, v01.oeko_tex_fg, v01.pefc_fg, v01.rainforest_fg, v01.sustain_clean_fg, v01.tierschutz_gepr_fg

   FROM dbp_view.v_art_2 v01
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_2 v02      -- MARA_2 + Retailartikel

   ON v01.art_id  =v02.art_id
   AND v01.mandant_id = v02.mandant_id
   WHERE v01.art_id <> -1
   AND v01.mandant_id IN (1,2);