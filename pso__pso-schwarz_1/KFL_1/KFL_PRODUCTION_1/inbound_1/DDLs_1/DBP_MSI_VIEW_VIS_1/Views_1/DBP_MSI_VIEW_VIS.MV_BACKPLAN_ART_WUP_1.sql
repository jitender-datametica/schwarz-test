CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BACKPLAN_ART_WUP_1 as
   -- Backplanung Zuordnung Stammdaten Artikel_1 - Filiale - Backplan - Lieferant
   -- 2014-05-13 : Version01
   -- 2014-06-24 : Anpassung Join Backzeit/Lieferant
   -- 2015-06-19 2015KW26 : KMO. kl_art_nr 8stellig. Anpassung Mandant_1/Sprache/Joins.

   SELECT
   awzp.mandant_id, TO_VARCHAR((CASE WHEN awzp.mandant_id=1 THEN (awzp.art_id/100) ELSE (awzp.art_id/10) END), 'FM00000000')  AS kl_art_nr, absz.art_backen_bez, awzp.listung_id, awzp.bezugsweg_id, awzp.art_id, asz2.art_bez, abkz.bestell_art_id, asz1.art_bez AS bestell_art_bez, ab.inhalt_menge, agzp.gp_id, g.gp_name, agzp.gp_art_id, SUBSTRING(gp_name, 1, CHARINDEX( ' ', gp_name)) AS gp_backen_name, awzp.wup_id, awzp.nb_id, aoz.ofen_typ_id, aoz.blech_belegung, wbp.anz_ofen, lo.anz_backblech, abz.back_programm_id, lb.back_dauer, lb.gp_backen_bez -- NEU Lieferant (nur bei manchen Programmen)
   , abhz.back_hinweis_id, bhsz.back_hinweis_bez, abaz.back_aufbereitung_id, basz.back_aufbereitung_bez

   FROM dbp_view.v_art_wup_zu_per_1 awzp

   JOIN dbp_view.v_art_backen_spr_zu_1 absz -- Bezeichnung Backartikel

   ON awzp.mandant_id = absz.mandant_id
   AND awzp.art_id = absz.art_id

   JOIN dbp_view.v_wup_backshop_per_1 wbp
   ON awzp.mandant_id=wbp.mandant_id
   AND awzp.wup_id=wbp.wup_id

   JOIN dbp_view.v_l_ofentyp_1 lo
   ON wbp.mandant_id = lo.mandant_id
   AND wbp.ofen_typ_id = lo.ofen_typ_id

   JOIN dbp_view.v_art_ofentyp_zu_1 aoz
   ON awzp.mandant_id = aoz.mandant_id
   AND awzp.art_id = aoz.art_id
   AND wbp.ofen_typ_id = aoz.ofen_typ_id

   JOIN dbp_view.v_art_backprogramm_zu_1 abz
   ON awzp.mandant_id = abz.mandant_id
   AND awzp.art_id = abz.art_id

   JOIN dbp_view.v_l_backzeit_1 lb
   ON wbp.mandant_id = lb.mandant_id
   AND wbp.ofen_typ_id = lb.ofen_typ_id
   AND abz.back_programm_id = lb.back_programm_id
   AND (wbp.gp_backen_bez = lb.gp_backen_bez OR lb.gp_backen_bez = '') -- Lieferantenabhaengig

   JOIN dbp_view.v_art_back_aufbereitung_zu_1 abaz
   ON awzp.mandant_id = abaz.mandant_id
   AND awzp.art_id = abaz.art_id
   JOIN dbp_view.v_back_aufbereitung_spr_zu_1 basz
   ON abaz.mandant_id = basz.mandant_id
   AND abaz.back_aufbereitung_id = basz.back_aufbereitung_id

   JOIN dbp_view.v_art_back_hinweis_zu_1 abhz
   ON awzp.mandant_id = abhz.mandant_id
   AND awzp.art_id = abhz.art_id
   JOIN dbp_view.v_back_hinweis_spr_zu_1 bhsz
   ON abhz.mandant_id = bhsz.mandant_id
   AND abhz.back_hinweis_id = bhsz.back_hinweis_id

   JOIN dbp_view.v_art_backshop_zu_1 abkz
   ON awzp.mandant_id = abkz.mandant_id
   AND awzp.art_id = abkz.art_id

   JOIN dbp_view.v_art_backshop_1 ab
   ON abkz.mandant_id = ab.mandant_id
   AND abkz.bestell_art_id = ab.bestell_art_id

   JOIN dbp_view.v_art_spr_zu_1 asz1 -- Bezeichnung Bestellartikel

   ON abkz.mandant_id = asz1.mandant_id
   AND abkz.bestell_art_id = asz1.art_id
   AND (asz1.mandant_id=1 AND asz1.spr_id=22 OR asz1.mandant_id<>1 AND asz1.spr_id<>22)

   JOIN dbp_view.v_art_spr_zu_1 asz2 -- Bezeichnung Verkaufsartikel

   ON awzp.mandant_id=asz2.mandant_id
   AND awzp.art_id=asz2.art_id
   AND (asz2.mandant_id=1 AND asz2.spr_id=22 OR asz2.mandant_id<>1 AND asz2.spr_id<>22)

   JOIN dbp_view.v_art_gp_zu_per_1 agzp
   ON agzp.mandant_id = absz.mandant_id
   AND agzp.art_id = abkz.bestell_art_id
   AND agzp.dat_bis = '9999-12-31'

   JOIN dbp_view.v_gp_1 g
   ON agzp.mandant_id = g.mandant_id
   AND agzp.gp_id = g.gp_id
   AND g.dat_bis = '9999-12-31'

   WHERE awzp.nb_id = 0
   AND awzp.dat_bis = '9999-12-31'
   AND wbp.dat_bis = '9999-12-31'
   ;