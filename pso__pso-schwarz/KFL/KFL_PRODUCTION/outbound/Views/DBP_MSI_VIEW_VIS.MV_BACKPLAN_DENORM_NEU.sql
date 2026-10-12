CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_backplan_denorm_neu AS SELECT BP.mandant_id,
 BP.nb_id,
 BP.wup_id,
 BP.art_id,
 TRIM(CAST(CASE
    WHEN BP.mandant_id = 1
    THEN BP.art_id / 100
    ELSE BP.art_id / 10
    END AS STRING FORMAT '00000000')) AS kl_art_nr,
 ABSZ.art_backen_bez,
 COALESCE(ABSZ.feierabend_fg, 0) AS feierabend_fg,
 BP.listung_id_backshop,
 BP.listung_id_backshop AS art_aktion_id,
 BP.aktion_id,
 CAST(CASE
   WHEN LENGTH(TRIM(BP.aktion_id)) > 1
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS aktion_fg,
 BP.dat,
 COALESCE(ABF.fruehstart_menge, 0) AS fruehstart_menge,
 BP.menge_gs AS menge01,
  BP.menge_gff - BP.menge_gs AS menge02,
 BP.menge_spaet AS menge03,
 BP.menge_abend AS menge04,
 BP.menge_tag AS tagesmenge,
 BP.menge_abschrift AS total_abschriften,
 back.blech_belegung,
 back.back_programm_id,
 back.back_dauer,
 back.back_hinweis_id,
 back.back_hinweis_bez,
 back.back_aufbereitung_id,
 back.back_aufbereitung_bez,
 back.ofen_typ_id,
 back.anz_ofen,
 back.anz_backblech
FROM kfl_production_dbp_msi_v_view.v_backshop_prognose_neu AS BP
 LEFT JOIN kfl_production_dbp_view.v_art_backen_spr_zu AS ABSZ ON BP.art_id = ABSZ.art_id AND BP.mandant_id = ABSZ.mandant_id
     AND (ABSZ.mandant_id = 1 AND ABSZ.spr_id = 22 OR ABSZ.mandant_id <> 1 AND ABSZ.spr_id <> 22)
 LEFT JOIN kfl_production_dbp_view.v_art_backshop_fruehstart AS ABF ON BP.art_id = ABF.art_id AND BP.mandant_id = ABF.mandant_id
     AND BP.wup_id = ABF.wup_id
 LEFT JOIN (SELECT WBP.mandant_id,
   WBP.wup_id,
   WBP.anz_ofen,
   AOZ.art_id,
   AOZ.ofen_typ_id,
   LO.anz_backblech,
   AOZ.blech_belegung,
   ABZ.back_programm_id,
   LB.back_dauer,
   LB.gp_backen_bez,
   ABHZ.back_hinweis_id,
   BHSZ.back_hinweis_bez,
   ABAZ.back_aufbereitung_id,
   BASZ.back_aufbereitung_bez
  FROM kfl_production_dbp_view.v_wup_backshop_per AS WBP
   INNER JOIN kfl_production_dbp_view.v_art_ofentyp_zu AS AOZ ON WBP.mandant_id = AOZ.mandant_id AND WBP.ofen_typ_id =
     AOZ.ofen_typ_id
   INNER JOIN kfl_production_dbp_view.v_l_ofentyp AS LO ON WBP.mandant_id = LO.mandant_id AND WBP.ofen_typ_id = LO.ofen_typ_id
     
   INNER JOIN kfl_production_dbp_view.v_art_backprogramm_zu AS ABZ ON AOZ.mandant_id = ABZ.mandant_id AND AOZ.art_id =
     ABZ.art_id
   INNER JOIN kfl_production_dbp_view.v_l_backzeit AS LB ON WBP.mandant_id = LB.mandant_id AND WBP.ofen_typ_id = LB.ofen_typ_id
        AND ABZ.back_programm_id = LB.back_programm_id AND (WBP.gp_backen_bez = LB.gp_backen_bez OR LB.gp_backen_bez =
       '')
   INNER JOIN kfl_production_dbp_view.v_art_back_aufbereitung_zu AS ABAZ ON AOZ.mandant_id = ABAZ.mandant_id AND AOZ.art_id
      = ABAZ.art_id
   INNER JOIN kfl_production_dbp_view.v_back_aufbereitung_spr_zu AS BASZ ON AOZ.mandant_id = BASZ.mandant_id AND ABAZ.back_aufbereitung_id
      = BASZ.back_aufbereitung_id
   INNER JOIN kfl_production_dbp_view.v_art_back_hinweis_zu AS ABHZ ON AOZ.mandant_id = ABHZ.mandant_id AND AOZ.art_id =
     ABHZ.art_id
   INNER JOIN kfl_production_dbp_view.v_back_hinweis_spr_zu AS BHSZ ON AOZ.mandant_id = BHSZ.mandant_id AND ABHZ.back_hinweis_id
      = BHSZ.back_hinweis_id
  WHERE WBP.nb_id = 0
   AND WBP.dat_bis = DATE '9999-12-31') AS back ON BP.art_id = back.art_id AND BP.mandant_id = back.mandant_id AND BP.wup_id
    = back.wup_id;