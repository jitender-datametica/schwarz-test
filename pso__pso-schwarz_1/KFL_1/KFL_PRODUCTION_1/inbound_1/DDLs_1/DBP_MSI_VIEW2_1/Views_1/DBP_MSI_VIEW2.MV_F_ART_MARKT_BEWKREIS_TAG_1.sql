CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_F_ART_MARKT_BEWKREIS_TAG_1
(
mandant_id
,wup_id
,nb_id
,art_id
,dat
,preis_steuer_kz
,wrg_id
,gld
,gp_id
,standard_preis
,markt_menge_bestand_bme
,markt_wert_bestand
,markt_vk_wert
)
AS
   SELECT
  t1.mandant_id                    as mandant_id, t2.wup_id                          as wup_id, t2.nb_id                              as nb_id, t1.art_id                              as art_id, t3.dat                                 as dat, t1.preis_steuer_kz              as preis_steuer_kz, t1.wrg_id                            as wrg_id, t4.gp_id                              as gp_id, t1.gld                                  as gld, t1.standard_preis                as standard_preis, t1.menge_bestand_bme     as markt_menge_bestand_bme, t1.wert_bestand                  as markt_wert_bestand, t1.vk_wert                           as markt_vk_wert


   FROM dbp_view.v_art_bewertungskreis_per_1 t1_1
   INNER JOIN dbp_view.v_wup_1 t2
   ON t1.bewertungskreis_id = t2.bewertungskreis_id
   AND t1.mandant_id = t2.mandant_id
   INNER JOIN dbp_view.v_tag_1 t3
   ON t3.dat between t1.dat_von and t1.dat_bis and akt_tag <= 0
   INNER JOIN dbp_view.v_art_gp_zu_per_1 t4
   ON
   t1.art_id = t4.art_id and
   t1.mandant_id = t4.mandant_id
   and t1.dat_von between t4.dat_von and t4.dat_bis

   WHERE
   t2.nb_id not in (-111,99)
   and
   t1.mandant_id =1;