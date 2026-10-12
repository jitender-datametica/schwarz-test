-- 2014-06-24 : Anpassung CROSS JOIN Backzeit/Lieferant
 -- 2014-05-13 : Version01

-- 2015-06-19 2015KW26 : KMO. kl_art_nr 8stellig. Anpassung Mandant/Sprache/Joins.

-- Backplanung Zuordnung Stammdaten Artikel - Filiale - Backplan - Lieferant

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_backplan_art_wup AS -- Bezeichnung Backartikel

-- Lieferantenabhaengig
 -- Bezeichnung Verkaufsartikel
 SELECT AWZP.mandant_id,
 TRIM(CAST(CASE
    WHEN AWZP.mandant_id = 1
    THEN AWZP.art_id / 100
    ELSE AWZP.art_id / 10
    END AS STRING FORMAT '00000000')) AS kl_art_nr,
 ABSZ.art_backen_bez,
 AWZP.listung_id,
 AWZP.bezugsweg_id,
 AWZP.art_id,
 ASZ2.art_bez,
 ABKZ.bestell_art_id,
 ASZ1.art_bez AS bestell_art_bez,
 AB.inhalt_menge,
 AGZP.gp_id,
 G.gp_name,
 AGZP.gp_art_id,
 SUBSTR(G.gp_name, 1, STRPOS(G.gp_name, ' ')) AS gp_backen_name,
 AWZP.wup_id,
 AWZP.nb_id,
 AOZ.ofen_typ_id,
 AOZ.blech_belegung,
 WBP.anz_ofen,
 LO.anz_backblech,
 ABZ.back_programm_id,
 LB.back_dauer,
 LB.gp_backen_bez -- NEU Lieferant (nur bei manchen Programmen)
,
 ABHZ.back_hinweis_id,
 BHSZ.back_hinweis_bez,
 ABAZ.back_aufbereitung_id,
 BASZ.back_aufbereitung_bez
FROM kfl_production_dbp_view.v_art_wup_zu_per AS AWZP
 INNER JOIN kfl_production_dbp_view.v_art_backen_spr_zu AS ABSZ ON AWZP.mandant_id = ABSZ.mandant_id AND AWZP.art_id =
   ABSZ.art_id
 INNER JOIN kfl_production_dbp_view.v_wup_backshop_per AS WBP ON AWZP.mandant_id = WBP.mandant_id AND AWZP.wup_id = WBP
   .wup_id
 INNER JOIN kfl_production_dbp_view.v_l_ofentyp AS LO ON WBP.mandant_id = LO.mandant_id AND WBP.ofen_typ_id = LO.ofen_typ_id
   
 INNER JOIN kfl_production_dbp_view.v_art_ofentyp_zu AS AOZ ON AWZP.mandant_id = AOZ.mandant_id AND AWZP.art_id = AOZ.art_id
     AND WBP.ofen_typ_id = AOZ.ofen_typ_id
 INNER JOIN kfl_production_dbp_view.v_art_backprogramm_zu AS ABZ ON AWZP.mandant_id = ABZ.mandant_id AND AWZP.art_id =
   ABZ.art_id
 INNER JOIN kfl_production_dbp_view.v_l_backzeit AS LB ON WBP.mandant_id = LB.mandant_id AND WBP.ofen_typ_id = LB.ofen_typ_id
      AND ABZ.back_programm_id = LB.back_programm_id AND (WBP.gp_backen_bez = LB.gp_backen_bez OR LB.gp_backen_bez = ''
   )
 INNER JOIN kfl_production_dbp_view.v_art_back_aufbereitung_zu AS ABAZ ON AWZP.mandant_id = ABAZ.mandant_id AND AWZP.art_id
    = ABAZ.art_id
 INNER JOIN kfl_production_dbp_view.v_back_aufbereitung_spr_zu AS BASZ ON ABAZ.mandant_id = BASZ.mandant_id AND ABAZ.back_aufbereitung_id
    = BASZ.back_aufbereitung_id
 INNER JOIN kfl_production_dbp_view.v_art_back_hinweis_zu AS ABHZ ON AWZP.mandant_id = ABHZ.mandant_id AND AWZP.art_id =
   ABHZ.art_id
 INNER JOIN kfl_production_dbp_view.v_back_hinweis_spr_zu AS BHSZ ON ABHZ.mandant_id = BHSZ.mandant_id AND ABHZ.back_hinweis_id
    = BHSZ.back_hinweis_id
 INNER JOIN kfl_production_dbp_view.v_art_backshop_zu AS ABKZ ON AWZP.mandant_id = ABKZ.mandant_id AND AWZP.art_id =
   ABKZ.art_id
 INNER JOIN kfl_production_dbp_view.v_art_backshop AS AB ON ABKZ.mandant_id = AB.mandant_id AND ABKZ.bestell_art_id = AB
   .bestell_art_id -- Bezeichnung Bestellartikel

 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS ASZ1 ON ABKZ.mandant_id = ASZ1.mandant_id AND ABKZ.bestell_art_id =
    ASZ1.art_id AND (ASZ1.mandant_id = 1 AND ASZ1.spr_id = 22 OR ASZ1.mandant_id <> 1 AND ASZ1.spr_id <> 22)
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS ASZ2 ON AWZP.mandant_id = ASZ2.mandant_id AND AWZP.art_id = ASZ2.art_id
     AND (ASZ2.mandant_id = 1 AND ASZ2.spr_id = 22 OR ASZ2.mandant_id <> 1 AND ASZ2.spr_id <> 22)
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS AGZP ON ABSZ.mandant_id = AGZP.mandant_id AND ABKZ.bestell_art_id
     = AGZP.art_id AND AGZP.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_gp AS G ON AGZP.mandant_id = G.mandant_id AND AGZP.gp_id = G.gp_id AND G.dat_bis =
   DATE '9999-12-31'
WHERE AWZP.nb_id = 0
 AND AWZP.dat_bis = DATE '9999-12-31'
 AND WBP.dat_bis = DATE '9999-12-31';