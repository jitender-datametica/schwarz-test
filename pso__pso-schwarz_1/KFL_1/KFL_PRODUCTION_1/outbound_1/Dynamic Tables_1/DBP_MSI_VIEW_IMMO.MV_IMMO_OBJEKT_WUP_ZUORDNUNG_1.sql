CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_objekt_wup_zuordnung_1 AS
SELECT
  i.mandant_id AS mandant_id,
  i.immo_objekt_id AS immo_objekt_id,
  kfl_production_dbp_process.transcriptc(i.objekt_ort) AS objekt_ort,
  kfl_production_dbp_process.transcriptc(
    CASE
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
    END
  ) AS objekt_name,
  vs.mitarbeiter_id AS vorstand_mitarbeiter_id,
  vs.nachname AS vorstand_nachname,
  vs.vorname AS vorstand_vorname,
  ol.zustaendig_id AS objektleiter_mitarbeiter_id,
  kfl_production_dbp_process.transcriptc(ol.nachname) AS objektleiter_nachname,
  kfl_production_dbp_process.transcriptc(ol.vorname) AS objektleiter_vorname,
  rl.zustaendig_id AS rl_ma_id,
  kfl_production_dbp_process.transcriptc(rl.nachname) AS rl_nachname,
  kfl_production_dbp_process.transcriptc(rl.vorname) AS rl_vorname,
  w.wup_id AS wup_id,
  w.wup_standort AS wup_standort,
  COALESCE(w.breitengrad, 0) AS breitengrad,
  COALESCE(w.laengengrad, 0) AS laengengrad,
  w.dat_von AS wup_dat_von,
  NULLIF(w.dat_eroeffnung, PARSE_DATE('%Y%m%d', '19011231')) AS wup_eroeffnung,
  NULLIF(w.dat_bis, PARSE_DATE('%Y%m%d', '19991231')) AS wup_schliessung,
  w.vsvt_bez AS vsvt_bez,
  w.gf_id AS gf_id,
  w.gf_name AS gf_name,
  w.vkl_id AS vkl_id,
  w.vkl_name AS vkl_name,
  w.hl_id AS hl_id,
  w.hl_name AS hl_name,
  tp.techn_platz_id AS techn_platz_id,
  tp.tech_platz_bez AS tech_platz_bez,
  tp.nl_bau_einr_bez AS nl_bau_einr_bez,
  kfl_production_dbp_process.transcriptc(tp.bl_bau_einr_name) AS bl_bau_einr_name,
  kfl_production_dbp_process.transcriptc(tp.betreuer_bau_einr_name) AS betreuer_bau_einr_name,
  kfl_production_dbp_process.transcriptc(tp.ol_vermietung_name) AS ol_vermietung_name,
  tp.frische_baecker AS frische_baecker,
  tp.discount_backshop AS discount_backshop,
  tp.kaufland_baeckerei AS kaufland_baeckerei,
  kfl_production_dbp_process.transcriptc(tp.eigentum_bez) AS eigentum_bez,
  i.immo_objekt_bez AS immo_objekt_bez,
  CAST(NULL AS STRING) AS objekt_miete_bis,
  w.verkaufsflaeche AS flaeche_verkauf,
  w.betriebsflaeche AS flaeche_betrieb,
  0 AS flaeche_konzessionaere,
  COALESCE(tp.ginfo_flaeche_netto, 0) AS flaeche_parkplaetze,
  '' AS telefon_nr,
  '' AS telefax_nr
FROM (
  SELECT
    mandant_id,
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
  FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_1
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
  UNION DISTINCT
  SELECT
    m.mandant_id,
    'IW----------0' AS immo_objekt_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    CAST('9999-12-31' AS DATE) AS dat_bis,
    0 AS objekt_groesse,
    0 AS konzessinoaer_groesse,
    '' AS objekt_org,
    '' AS objekt_strasse,
    '' AS objekt_plz,
    'ohne Zuordnung' AS objekt_name,
    PARSE_DATE('%F', '1900-01-01') AS dat_1bereicth_oeffnung,
    PARSE_DATE('%F', '1900-01-01') AS dat_objekt_oeffnung,
    0.00 AS eigenmiete_pro_qm,
    0.00 AS eigenmiete_pro_monat,
    m.default_wrg AS wrg_id,
    '3' AS objekart_id,
    PARSE_DATE('%F', '1900-01-01') AS objektart_datum_von,
    DATE('9999-12-31') AS objektart_datum_bis,
    0 AS sysetem_id,
    0 AS buchungskreis_id,
    'IW----------0' AS immo_objekt_obj_id,
    0 AS immo_objekt_bez,
    '' AS immo_objekt_nr
  FROM kfl_production_dbp_view.v_tag_1
  INNER JOIN kfl_production_dbp_view.v_mandant_1 AS m
    ON TRUE
  WHERE
    v_tag.dat = CURRENT_DATE
) AS i
LEFT JOIN (
  SELECT
    w1.mandant_id,
    w1.wup_id,
    w1.wup_standort,
    COALESCE(w1.breitengrad, 0) AS breitengrad,
    COALESCE(w1.laengengrad, 0) AS laengengrad,
    w1.dat_eroeffnung,
    w1.dat_von,
    w1.dat_bis,
    gf1.gf_id,
    gf1.gf_name,
    vs1.vsvt_bez,
    w1.vkl_id,
    vkl1.vkl_name,
    w1.hl_id,
    hl1.hl_name,
    w1.verkaufsflaeche,
    w1.betriebsflaeche
  FROM kfl_production_dbp_view.v_wup_1 AS w1
  LEFT JOIN kfl_production_dbp_view.v_hl_1 AS hl1
    ON w1.hl_id = hl1.hl_id AND w1.mandant_id = hl1.mandant_id
  LEFT JOIN kfl_production_dbp_view.v_vkl_1 AS vkl1
    ON w1.vkl_id = vkl1.vkl_id AND w1.mandant_id = vkl1.mandant_id
  LEFT JOIN kfl_production_dbp_view.v_gf_1 AS gf1
    ON vkl1.gf_id = gf1.gf_id AND vkl1.mandant_id = gf1.mandant_id AND gf1.ek_fg = 0
  LEFT JOIN kfl_production_dbp_view.v_vs_1 AS vs1
    ON w1.vs_id = vs1.vs_id AND w1.mandant_id = vs1.mandant_id
  WHERE
    w1.nb_id = 0 AND w1.dat_eroeffnung > PARSE_DATE('%F', '1900-01-01')
) AS w
  ON i.immo_objekt_bez = w.wup_id AND i.mandant_id = w.mandant_id
LEFT JOIN (
  SELECT
    oz.mandant_id,
    oz.immo_objekt_id,
    oz.zustaendig_id,
    iz.mitarbeiter_id,
    iz.vorname,
    iz.nachname,
    iz.anrede
  FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_1 AS oz
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_vorstand_1 AS iz
    ON oz.zustaendig_id = iz.mitarbeiter_id AND oz.mandant_id = iz.mandant_id
  WHERE
    oz.dat_bis = CAST('9999-12-31' AS DATE) AND oz.zustaendig_typ_id = 1
  UNION DISTINCT
  SELECT
    v_mandant.mandant_id,
    'IW----------0',
    0,
    0,
    'Gebiet',
    'ohne Zuordnung',
    CAST(NULL AS STRING)
  FROM kfl_production_dbp_view.v_tag_1 AS v_tag0
  INNER JOIN kfl_production_dbp_view.v_mandant_1
    ON TRUE
  WHERE
    v_tag0.dat = CURRENT_DATE
) AS vs_1
  ON i.immo_objekt_id = vs.immo_objekt_id AND i.mandant_id = vs.mandant_id
LEFT JOIN (
  SELECT
    oz.mandant_id,
    oz.immo_objekt_id,
    oz.zustaendig_id,
    iz.vorname,
    iz.nachname,
    iz.anrede
  FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_1 AS oz
  INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_1 AS iz
    ON oz.zustaendig_id = iz.zustaendig_id AND oz.mandant_id = iz.mandant_id
  WHERE
    oz.dat_bis = CAST('9999-12-31' AS DATE) AND oz.zustaendig_typ_id = 2
  UNION ALL
  SELECT
    mandant_id,
    'IW----------0',
    0,
    'ohne',
    'Zuordnung',
    ''
  FROM kfl_production_dbp_view.v_mandant_1
) AS ol
  ON i.immo_objekt_id = ol.immo_objekt_id AND i.mandant_id = ol.mandant_id
LEFT JOIN (
  SELECT
    oz.mandant_id,
    oz.immo_objekt_id,
    oz.zustaendig_id,
    iz.vorname,
    iz.nachname,
    iz.anrede
  FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_1 AS oz
  INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_1 AS iz
    ON oz.zustaendig_id = iz.zustaendig_id AND oz.mandant_id = iz.mandant_id
  WHERE
    oz.dat_bis = CAST('9999-12-31' AS DATE) AND oz.zustaendig_typ_id = 3
  UNION ALL
  SELECT
    mandant_id,
    'IW----------0',
    0,
    'ohne',
    'Zuordnung',
    ''
  FROM kfl_production_dbp_view.v_mandant_1
) AS rl
  ON i.immo_objekt_id = rl.immo_objekt_id AND i.mandant_id = rl.mandant_id
LEFT JOIN (
  SELECT
    tp0.techn_platz_id,
    tp0.mandant_id,
    tp0.wup_id,
    COALESCE(tp0.kostenstelle_id, TRIM(SUBSTR(CAST(tp0.wup_id AS STRING), 1, 39)) || '-800') AS kostenstelle_id,
    tp1.tech_platz_bez,
    tp2.kbl_nl_bez AS nl_bau_einr_bez,
    tp2.tp_bl_kbl_name AS bl_bau_einr_name,
    tp2.tp_betreuer_kbl_name AS betreuer_bau_einr_name,
    tp2.tp_ol_vermietung AS ol_vermietung_name,
    tp2.frische_baecker,
    tp2.discount_backshop,
    SUBSTR(
      CASE
        WHEN INSTR(tp2.frische_baecker, 'J') <> 0 OR INSTR(tp2.discount_backshop, 'J') <> 0
        THEN 'Ja'
        WHEN INSTR(tp2.frische_baecker, 'N') <> 0 OR INSTR(tp2.discount_backshop, 'N') <> 0
        THEN 'Nein'
        ELSE ''
      END,
      1,
      4
    ) AS kaufland_baeckerei,
    tp2.eigentum_bez,
    gfp.ginfo_flaeche_netto
  FROM kfl_production_dbp_view.v_techn_platz_per_1 AS tp0
  INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_1 AS tp1
    ON tp0.techn_platz_id = tp1.techn_platz_id
  LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS tp2
    ON tp0.techn_platz_id = tp2.techn_platz_id
  LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_1 AS gfp
    ON tp0.techn_platz_id = gfp.techn_platz_id
  WHERE
    tp0.techn_platz_ebene_id = 2
    AND tp0.dat_bis = CAST('9999-12-31' AS DATE)
    AND tp1.dat_bis = CAST('9999-12-31' AS DATE)
    AND tp2.dat_bis = CAST('9999-12-31' AS DATE)
    AND tp1.spr_id = 22
    AND gfp.ginfo_flaeche_id = 'PPL'
    AND gfp.dat_bis = CAST('9999-12-31' AS DATE)
) AS tp
  ON i.immo_objekt_bez = tp.wup_id AND i.mandant_id = tp.mandant_id;
