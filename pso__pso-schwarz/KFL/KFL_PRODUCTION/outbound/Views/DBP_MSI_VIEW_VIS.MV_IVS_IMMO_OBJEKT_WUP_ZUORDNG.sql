-- enthaelt noch viel ueberfluessiges!
 -- ZUORDNUNGEN denormalisiert (aktuell)
 -- 2009-05-04

-- 2013KW10 Erweiterung Kurs/Waehrungsumrechnung
 -- 2013KW03 Transkription

-- immo_objekt + wup (Marktstamm) + techn_platz (Ebene 2)
 -- 2011KW25 Initial von IVS nach VIS übernommen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_immo_objekt_wup_zuordng AS -- momentan nicht verwendet

-- nicht verwendet (aus KOVA)
 -- nicht verwendet (aus KOVA)
 -- neu  inseriert   fuer  PPL
 -- Dummyobjekte pro Land

-- WUP Vertriebszuordnungen GF, VKL, Schiene
 -- Immo: Vorstand (=Gebiet)
 -- Immo: Objektleiter Vermietung

-- Techn. Platz Zuordnungen (ohne Vertriebsstruktur)
 -- neu  inseriert   fuer  PPL
 SELECT i.mandant_id,
 i.immo_objekt_id,
 kfl_production_dbp_process.transcriptc(i.objekt_ort) AS objekt_ort,
 kfl_production_dbp_process.transcriptc(i.objekt_name) AS objekt_name,
 vs.mitarbeiter_id AS vorstand_mitarbeiter_id,
 vs.nachname AS vorstand_nachname,
 vs.vorname AS vorstand_vorname,
 ol.mitarbeiter_id AS objektleiter_mitarbeiter_id,
 kfl_production_dbp_process.transcriptc(ol.nachname) AS objektleiter_nachname,
 kfl_production_dbp_process.transcriptc(ol.vorname) AS objektleiter_vorname,
 w.wup_id,
 w.wup_standort,
 w.dat_von AS wup_dat_von,
 NULLIF(w.dat_eroeffnung, PARSE_DATE('%Y%m%d', '19011231')) AS wup_eroeffnung,
 NULLIF(w.dat_bis, PARSE_DATE('%Y%m%d', '19991231')) AS wup_schliessung,
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
 CAST(NULL AS STRING) AS objekt_miete_bis,
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
   FROM kfl_production_dbp_view.v_ivs_immo_objekt_per
   WHERE dat_bis = DATE '9999-12-31'
   UNION ALL
   SELECT mandant_id,
    'IW----------0' AS immo_objekt_id,
    CAST('1900-01-01' AS DATE) AS dat_von,
    CAST('9999-12-31' AS DATE) AS dat_bis,
    0 AS objekt_groesse,
    0 AS konzessionaer_groesse,
    '' AS objekt_org,
    '' AS objekt_strasse,
    '' AS objekt_plz,
    'ohne Zuordnung' AS objekt_name,
    CAST('1900-01-01' AS DATE) AS dat_1bereicth_oeffnung,
    CAST('1900-01-01' AS DATE) AS dat_objekt_oeffnung,
    0.00 AS eigenmiete_pro_qm,
    0.00 AS eigenmiete_pro_monat,
    default_wrg AS wrg_id,
    '3' AS objekart_id,
    CAST('1900-01-01' AS DATE) AS objektart_datum_von,
    CAST('9999-12-31' AS DATE) AS objektart_datum_bis,
    0 AS system_id,
    0 AS buchungskreis_id,
    'IW----------0' AS immo_objekt_obj_id,
    0 AS immo_objekt_bez,
    '' AS immo_objekt_nr
   FROM kfl_production_dbp_view.v_mandant AS M) AS i
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
  FROM kfl_production_dbp_view.v_wup AS W1
   LEFT JOIN kfl_production_dbp_view.v_hl AS HL1 ON W1.hl_id = HL1.hl_id AND W1.mandant_id = HL1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_vkl AS VKL1 ON W1.vkl_id = VKL1.vkl_id AND W1.mandant_id = VKL1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_gf AS GF1 ON VKL1.gf_id = GF1.gf_id AND VKL1.mandant_id = GF1.mandant_id AND GF1
     .ek_fg = 0
   LEFT JOIN kfl_production_dbp_view.v_vs AS VS1 ON W1.vs_id = VS1.vs_id AND W1.mandant_id = VS1.mandant_id
  WHERE W1.nb_id = 0
   AND W1.dat_eroeffnung > PARSE_DATE('%F', '1900-01-01')) AS w ON i.immo_objekt_bez = w.wup_id AND i.mandant_id = w.mandant_id
   
 LEFT JOIN (SELECT OZ.mandant_id,
    OZ.immo_objekt_id,
    OZ.zustaendig_id,
    IZ.mitarbeiter_id,
    IZ.vorname,
    IZ.nachname,
    IZ.anrede
   FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per AS OZ
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_vorstand AS IZ ON OZ.zustaendig_id = IZ.mitarbeiter_id AND OZ.mandant_id
       = IZ.mandant_id
   WHERE OZ.dat_bis = DATE '9999-12-31'
    AND OZ.zustaendig_typ_id = 1
   UNION DISTINCT
   SELECT 1,
    'IW----------0',
    0,
    0,
    'Gebiet',
    'ohne Zuordnung',
    CAST(NULL AS STRING)
   FROM kfl_production_dbp_view.v_tag
   WHERE dat = CURRENT_DATE) AS vs ON i.immo_objekt_id = vs.immo_objekt_id AND i.mandant_id = vs.mandant_id
 LEFT JOIN (SELECT OZ.mandant_id,
    OZ.immo_objekt_id,
    OZ.zustaendig_id,
    IZ.mitarbeiter_id,
    IZ.vorname,
    IZ.nachname,
    IZ.anrede
   FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per AS OZ
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_objektleiter AS IZ ON OZ.zustaendig_id = IZ.mitarbeiter_id AND OZ
      .mandant_id = IZ.mandant_id
   WHERE OZ.dat_bis = DATE '9999-12-31'
    AND OZ.zustaendig_typ_id = 2
   UNION DISTINCT
   SELECT 1,
    'IW----------0',
    0,
    0,
    'Gebiet',
    'ohne Zuordnung',
    CAST(NULL AS STRING)
   FROM kfl_production_dbp_view.v_tag
   WHERE dat = CURRENT_DATE) AS ol ON i.immo_objekt_id = ol.immo_objekt_id AND i.mandant_id = ol.mandant_id
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
     WHEN STRPOS(TP2.frische_baecker, 'J') <> 0 OR STRPOS(TP2.discount_backshop, 'J') <> 0
     THEN 'Ja'
     WHEN STRPOS(TP2.frische_baecker, 'N') <> 0 OR STRPOS(TP2.discount_backshop, 'N') <> 0
     THEN 'Nein'
     ELSE ''
     END, 1, 4) AS kaufland_baeckerei,
   TP2.eigentum_bez -- not used
,
   GFP.ginfo_flaeche_netto -- neu  inseriert   fuer  PPL

  FROM kfl_production_dbp_view.v_techn_platz_per AS TP0
   INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS TP1 ON TP0.techn_platz_id = TP1.techn_platz_id
   LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per AS TP2 ON TP0.techn_platz_id = TP2.techn_platz_id
   LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per AS GFP ON TP0.techn_platz_id = GFP.techn_platz_id
    -- neu  inseriert   fuer  PPL

  WHERE TP0.techn_platz_ebene_id = 2
   AND TP0.dat_bis = DATE '9999-12-31'
   AND TP1.dat_bis = DATE '9999-12-31'
   AND TP2.dat_bis = DATE '9999-12-31'
   AND TP1.spr_id = 22
   AND GFP.ginfo_flaeche_id = 'PPL' -- neu  inseriert   fuer  PPL

   AND GFP.dat_bis = DATE '9999-12-31') AS tp ON i.immo_objekt_bez = tp.wup_id AND i.mandant_id = tp.mandant_id;

