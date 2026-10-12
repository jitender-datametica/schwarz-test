
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_immo_objekt_wup_zuordnung_2 AS SELECT i.mandant_id,
 i.immo_objekt_id,
 kfl_production_dbp_process.transcriptc(i.objekt_ort) AS objekt_ort,
 kfl_production_dbp_process.transcriptc(CASE
   WHEN INSTR(i.objekt_name, 'PAOB') > 0
   THEN TRIM(SUBSTR(i.objekt_name, 1, INSTR(i.objekt_name, 'PAOB') - 1))
   WHEN INSTR(i.objekt_name, ',PAOB') > 0
   THEN TRIM(SUBSTR(i.objekt_name, 1, INSTR(i.objekt_name, ',PAOB') - 1))
   WHEN INSTR(i.objekt_name, 'UMGL') > 0
   THEN TRIM(SUBSTR(i.objekt_name, 1, INSTR(i.objekt_name, 'UMGL') - 1))
   WHEN INSTR(i.objekt_name, ',UMGL') > 0
   THEN TRIM(SUBSTR(i.objekt_name, 1, INSTR(i.objekt_name, ',UMGL') - 1))
   WHEN INSTR(i.objekt_name, 'Partnerobjekt') > 0
   THEN TRIM(SUBSTR(i.objekt_name, 1, INSTR(i.objekt_name, 'Partnerobjekt') - 1))
   ELSE i.objekt_name
   END) AS objekt_name,
 vs.mitarbeiter_id AS vorstand_mitarbeiter_id,
 vs.nachname AS vorstand_nachname,
 vs.vorname AS vorstand_vorname,
 ol.zustaendig_id AS objektleiter_mitarbeiter_id,
 kfl_production_dbp_process.transcriptc(ol.nachname) AS objektleiter_nachname,
 kfl_production_dbp_process.transcriptc(ol.vorname) AS objektleiter_vorname,
 rl.zustaendig_id AS rl_ma_id,
 kfl_production_dbp_process.transcriptc(rl.nachname) AS rl_nachname,
 kfl_production_dbp_process.transcriptc(rl.vorname) AS rl_vorname,
 w.wup_id,
 w.wup_standort,
 w.dat_von AS wup_dat_von,
 NULLIF(w.dat_eroeffnung, DATE('2090-12-31')) AS wup_eroeffnung,
 NULLIF(w.dat_bis, DATE('9999-12-31')) AS wup_schliessung,
 w.vsvt_bez,
 w.gf_id,
 w.gf_name,
 w.vkl_id,
 w.vkl_name,
 w.hl_id,
 w.hl_name,
 tp.techn_platz_id,
 tp.tech_platz_bez,
 tp.nl_bau_einr_bez,
 kfl_production_dbp_process.transcriptc(tp.bl_bau_einr_name) AS bl_bau_einr_name,
 kfl_production_dbp_process.transcriptc(tp.betreuer_bau_einr_name) AS betreuer_bau_einr_name,
 kfl_production_dbp_process.transcriptc(tp.ol_vermietung_name) AS ol_vermietung_name,
 tp.frische_baecker,
 tp.discount_backshop,
 tp.kaufland_baeckerei,
 kfl_production_dbp_process.transcriptc(tp.eigentum_bez) AS eigentum_bez,
 i.immo_objekt_bez,
 DATE(NULL) AS objekt_miete_bis,
 w.verkaufsflaeche AS flaeche_verkauf,
 w.betriebsflaeche AS flaeche_betrieb,
 0 AS flaeche_konzessionaere,
 COALESCE(tp.ginfo_flaeche_netto, 0) AS flaeche_parkplaetze,
 '' AS telefon_nr,
 '' AS telefax_nr
FROM (SELECT mandant_id,
    immo_objekt_id,
    dat_von,
    dat_bis,
    objekt_groesse,
    konzessionaer_groesse,
    objekt_ort,
    objekt_strasse,
    objekt_plz,
    objekt_name,
    dat_1bereich_oeffnung,
    dat_objekt_oeffnung,
    eigenmiete_pro_qm,
    eigenmiete_pro_monat,
    wrg_id,
    objektart_id,
    objektart_datum_von,
    objektart_datum_bis,
    system_id,
    buchungskreis_id,
    immo_objekt_obj_id,
    immo_objekt_bez,
    immo_objekt_nr
   FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_2
   WHERE dat_bis = DATE('9999-12-31')
   UNION DISTINCT
   SELECT M.mandant_id,
    'IW----------0' AS immo_objekt_id,
    DATE('1900-01-01') AS dat_von,
    DATE('9999-12-31') AS dat_bis,
    0 AS objekt_groesse,
    0 AS konzessinoaer_groesse,
    '' AS objekt_org,
    '' AS objekt_strasse,
    '' AS objekt_plz,
    'ohne Zuordnung' AS objekt_name,
    DATE('1900-01-01') AS dat_1bereicth_oeffnung,
    DATE('1900-01-01') AS dat_objekt_oeffnung,
    0.00 AS eigenmiete_pro_qm,
    0.00 AS eigenmiete_pro_monat,
    M.default_wrg AS wrg_id,
    '3' AS objekart_id,
    DATE('1900-01-01') AS objektart_datum_von,
    DATE('9999-12-31') AS objektart_datum_bis,
    0 AS sysetem_id,
    0 AS buchungskreis_id,
    'IW----------0' AS immo_objekt_obj_id,
    0 AS immo_objekt_bez,
    '' AS immo_objekt_nr
   FROM kfl_production_dbp_view.v_tag_2
    INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON TRUE
   WHERE v_tag.dat = CURRENT_DATE) AS i
 LEFT JOIN (SELECT W1.mandant_id,
   W1.wup_id,
   W1.wup_standort,
   W1.dat_eroeffnung,
   W1.dat_von,
   W1.dat_bis,
   GF1.gf_id,
   GF1.gf_name,
   VS1.vsvt_bez,
   W1.vkl_id,
   VKL1.vkl_name,
   W1.hl_id,
   HL1.hl_name,
   W1.verkaufsflaeche,
   W1.betriebsflaeche
  FROM kfl_production_dbp_view.v_wup_2 AS W1
   LEFT JOIN kfl_production_dbp_view.v_hl_2 AS HL1 ON W1.hl_id = HL1.hl_id AND W1.mandant_id = HL1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_vkl_2 AS VKL1 ON W1.vkl_id = VKL1.vkl_id AND W1.mandant_id = VKL1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_gf_2 AS GF1 ON VKL1.gf_id = GF1.gf_id AND VKL1.mandant_id = GF1.mandant_id AND GF1
     .ek_fg = 0
   LEFT JOIN kfl_production_dbp_view.v_vs_2 AS VS1 ON W1.vs_id = VS1.vs_id AND W1.mandant_id = VS1.mandant_id
  WHERE W1.nb_id = 0
   AND W1.dat_eroeffnung > DATE '1900-01-01') AS w ON i.immo_objekt_bez = w.wup_id AND i.mandant_id = w.mandant_id
 LEFT JOIN (SELECT OZ.mandant_id,
    OZ.immo_objekt_id,
    OZ.zustaendig_id,
    IZ.mitarbeiter_id,
    IZ.vorname,
    IZ.nachname,
    IZ.anrede
   FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS OZ
    INNER JOIN kfl_production_dbp_msi_view_ivs.mv_vorstand_2 AS IZ ON OZ.zustaendig_id = IZ.mitarbeiter_id AND OZ.mandant_id
       = IZ.mandant_id
   WHERE OZ.dat_bis = DATE('9999-12-31')
    AND OZ.zustaendig_typ_id = 1
   UNION DISTINCT
   SELECT v_mandant.mandant_id,
    'IW----------0',
    0,
    0,
    'Gebiet',
    'ohne Zuordnung',
    CAST(NULL AS STRING)
   FROM kfl_production_dbp_view.v_tag_2 AS v_tag0
    INNER JOIN kfl_production_dbp_view.v_mandant_2 ON TRUE
   WHERE v_tag0.dat = CURRENT_DATE) AS vs_2 ON i.immo_objekt_id = vs.immo_objekt_id AND i.mandant_id = vs.mandant_id
 LEFT JOIN (SELECT OZ.mandant_id,
    OZ.immo_objekt_id,
    OZ.zustaendig_id,
    IZ.vorname,
    IZ.nachname,
    IZ.anrede
   FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS OZ
    INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS IZ ON OZ.zustaendig_id = IZ.zustaendig_id AND OZ.mandant_id
       = IZ.mandant_id
   WHERE OZ.dat_bis = DATE('9999-12-31')
    AND OZ.zustaendig_typ_id = 2
   UNION ALL
   SELECT mandant_id,
    'IW----------0',
    0,
    'ohne',
    'Zuordnung',
    ''
   FROM kfl_production_dbp_view.v_mandant_2) AS ol ON i.immo_objekt_id = ol.immo_objekt_id AND i.mandant_id = ol.mandant_id
   
 LEFT JOIN (SELECT OZ.mandant_id,
    OZ.immo_objekt_id,
    OZ.zustaendig_id,
    IZ.vorname,
    IZ.nachname,
    IZ.anrede
   FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS OZ
    INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS IZ ON OZ.zustaendig_id = IZ.zustaendig_id AND OZ.mandant_id
       = IZ.mandant_id
   WHERE OZ.dat_bis = DATE('9999-12-31')
    AND OZ.zustaendig_typ_id = 3
   UNION ALL
   SELECT mandant_id,
    'IW----------0',
    0,
    'ohne',
    'Zuordnung',
    ''
   FROM kfl_production_dbp_view.v_mandant_2) AS rl ON i.immo_objekt_id = rl.immo_objekt_id AND i.mandant_id = rl.mandant_id
   
 LEFT JOIN (SELECT TP0.techn_platz_id,
   TP0.mandant_id,
   TP0.wup_id,
   COALESCE(TP0.kostenstelle_id, TRIM(SUBSTR(CAST(TP0.wup_id AS STRING), 1, 39)) || '-800') AS kostenstelle_id,
   TP1.tech_platz_bez,
   TP2.kbl_nl_bez AS nl_bau_einr_bez,
   TP2.tp_bl_kbl_name AS bl_bau_einr_name,
   TP2.tp_betreuer_kbl_name AS betreuer_bau_einr_name,
   TP2.tp_ol_vermietung AS ol_vermietung_name,
   TP2.frische_baecker,
   TP2.discount_backshop,
   SUBSTR(CASE
     WHEN TP2.frische_baecker LIKE '%J%' OR TP2.discount_backshop LIKE '%J%'
     THEN 'Ja'
     WHEN TP2.frische_baecker LIKE '%N%' OR TP2.discount_backshop LIKE '%N%'
     THEN 'Nein'
     ELSE ''
     END, 1, 4) AS kaufland_baeckerei,
   TP2.eigentum_bez,
   GFP.ginfo_flaeche_netto
  FROM kfl_production_dbp_view.v_techn_platz_per_2 AS TP0
   INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS TP1 ON TP0.techn_platz_id = TP1.techn_platz_id
   LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_2 AS TP2 ON TP0.techn_platz_id = TP2.techn_platz_id
   LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS GFP ON TP0.techn_platz_id = GFP.techn_platz_id
  WHERE TP0.techn_platz_ebene_id = 2
   AND TP0.dat_bis = DATE('9999-12-31')
   AND TP1.dat_bis = DATE('9999-12-31')
   AND TP2.dat_bis = DATE('9999-12-31')
   AND TP1.spr_id = 22
   AND GFP.ginfo_flaeche_id = 'PPL'
   AND GFP.dat_bis = DATE('9999-12-31')) AS tp ON i.immo_objekt_bez = tp.wup_id AND i.mandant_id = tp.mandant_id;

