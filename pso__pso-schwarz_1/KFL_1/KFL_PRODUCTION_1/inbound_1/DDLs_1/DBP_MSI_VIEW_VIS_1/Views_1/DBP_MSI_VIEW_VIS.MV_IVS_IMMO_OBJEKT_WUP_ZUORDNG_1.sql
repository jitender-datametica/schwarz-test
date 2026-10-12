CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_IMMO_OBJEKT_WUP_ZUORDNG_1
AS
   -- 2009-05-04
   -- ZUORDNUNGEN denormalisiert (aktuell)
   -- immo_objekt + wup_1 (Marktstamm) + techn_platz (Ebene 2)
   -- 2011KW25 Initial von IVS nach VIS übernommen
   -- 2013KW03 Transkription
   -- 2013KW10 Erweiterung Kurs_1/Waehrungsumrechnung
   -- enthaelt noch viel ueberfluessiges!

   SELECT
   i.mandant_id, i.immo_objekt_id, dbp_process.transcriptc(i.objekt_ort)  AS objekt_ort, dbp_process.transcriptc(i.objekt_name) AS objekt_name
   , vs.Mitarbeiter_ID                      AS vorstand_mitarbeiter_id, vs.nachname                            AS vorstand_nachname, vs.vorname                             AS vorstand_vorname
   , ol.Mitarbeiter_ID                      AS objektleiter_mitarbeiter_id, dbp_process.transcriptc(ol.nachname)   AS objektleiter_nachname, dbp_process.transcriptc(ol.vorname)    AS objektleiter_vorname
   , w.wup_id, w.wup_standort
   , w.dat_von                        wup_dat_von
   , NULLIF(w.dat_eroeffnung,to_date('19011231','YYYYMMDD')) wup_eroeffnung
   , NULLIF(w.dat_bis,to_date('19991231','YYYYMMDD'))       wup_schliessung
   , w.vsvt_bez, w.gf_id, w.gf_name, w.vkl_id, w.vkl_name, w.hl_id, w.hl_name, tp.techn_platz_id, tp.tech_platz_bez, tp.nl_bau_einr_bez, dbp_process.transcriptc(tp.bl_bau_einr_name)       AS bl_bau_einr_name
   , dbp_process.transcriptc(tp.betreuer_bau_einr_name) AS betreuer_bau_einr_name, dbp_process.transcriptc(tp.ol_vermietung_name)     AS  ol_vermietung_name -- momentan nicht verwendet
   , tp.frische_baecker, tp.discount_backshop, tp.kaufland_baeckerei, dbp_process.transcriptc(tp.eigentum_bez)           AS  eigentum_bez-- nicht verwendet (aus KOVA)
   , i.immo_objekt_bez, CAST(NULL AS VARCHAR)               AS objekt_miete_bis  -- nicht verwendet (aus KOVA)
   , w.verkaufsflaeche      flaeche_verkauf, w.betriebsflaeche      flaeche_betrieb, 0::DECIMAL(18,2)      flaeche_konzessionaere, COALESCE(tp.ginfo_flaeche_netto , 0 )              AS flaeche_parkplaetze   --  neu  inseriert   fuer  PPL
   , ''::VARCHAR(40)       telefon_nr, ''::VARCHAR(40)       telefax_nr
   FROM (
   SELECT
   mandant_id, immo_objekt_id, dat_von, dat_bis, objekt_groesse, konzessionaer_groesse, objekt_ort, objekt_strasse, objekt_plz, objekt_name, dat_1bereich_oeffnung, dat_objekt_oeffnung, eigenmiete_pro_qm, eigenmiete_pro_monat, wrg_id, objektart_id, objektart_datum_von, objektart_datum_bis, system_id, buchungskreis_id, immo_objekt_obj_id, immo_objekt_bez, immo_objekt_nr
   FROM dbp_view.v_ivs_immo_objekt_per_1
   WHERE dat_bis = '9999-12-31'

   UNION ALL -- Dummyobjekte pro Land_1
   SELECT
   mandant_id,  'IW----------0'  AS immo_objekt_id, '1900-01-01' AS dat_von, '9999-12-31' AS dat_bis, 0 AS objekt_groesse, 0 AS konzessionaer_groesse, '' AS objekt_org, '' AS objekt_strasse, '' AS objekt_plz, 'ohne Zuordnung'  AS objekt_name, 
     '1900-01-01' AS dat_1bereicth_oeffnung, '1900-01-01' AS dat_objekt_oeffnung, 0.00 AS eigenmiete_pro_qm, 0.00 AS eigenmiete_pro_monat, 
     default_wrg AS wrg_id, '3'  AS objekart_id,'1900-01-01' AS objektart_datum_von, 
     '9999-12-31'  AS objektart_datum_bis, 0 AS system_id, 0 AS buchungskreis_id, 'IW----------0' AS immo_objekt_obj_id, 0 AS immo_objekt_bez, '' AS immo_objekt_nr
   FROM dbp_view.v_mandant_1 m
   )  i
   LEFT JOIN ( -- WUP_1 Vertriebszuordnungen GF_1, VKL_1, Schiene
   SELECT
   w1.mandant_id, w1.wup_id, w1.wup_standort, w1.dat_eroeffnung, w1.dat_von, w1.dat_bis, gf1.gf_id, gf1.gf_name, vs1.vsvt_bez, w1.vkl_id, vkl1.vkl_name, w1.hl_id, hl1.hl_name, w1.verkaufsflaeche, w1.betriebsflaeche
   FROM dbp_view.v_wup_1  w1
   LEFT JOIN dbp_view.v_hl_1 hl1
   ON   w1.hl_id = hl1.hl_id AND w1.mandant_id = hl1.mandant_id
   LEFT JOIN dbp_view.v_vkl_1 vkl1
   ON   w1.vkl_id = vkl1.vkl_id AND w1.mandant_id = vkl1.mandant_id
   LEFT JOIN dbp_view.v_gf_1 gf1
   ON   vkl1.gf_id = gf1.gf_id AND vkl1.mandant_id = gf1.mandant_id
   AND  gf1.ek_fg = 0
   LEFT JOIN dbp_view.v_vs_1 vs1
   ON   w1.vs_id = vs1.vs_id AND w1.mandant_id = vs1.mandant_id

   WHERE w1.nb_id = 0
   AND   w1.dat_eroeffnung > to_date('1900-01-01','YYYY-MM_1-DD')
   )  w
   ON i.immo_objekt_bez = w.wup_id
   AND i.mandant_id = w.mandant_id
   LEFT JOIN ( -- Immo: Vorstand (=Gebiet)
   SELECT
   oz.mandant_id, oz.immo_objekt_id, oz.zustaendig_id, iz.Mitarbeiter_ID, iz.vorname, iz.nachname, iz.anrede
   FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1 oz
   INNER JOIN dbp_msi_view_vis.mv_ivs_vorstand_1  iz
   ON   oz.zustaendig_id = iz.Mitarbeiter_ID
   AND   oz.mandant_id = iz.mandant_id

   WHERE oz.dat_bis = '9999-12-31'
   AND   oz.zustaendig_typ_id = 1

   UNION
   SELECT
   1::BYTEINT,  'IW----------0'::VARCHAR(20), 0::INT, 0::INT, 'Gebiet'::VARCHAR(40), 'ohne Zuordnung'::VARCHAR(40), NULL::VARCHAR(10)
   FROM dbp_view.v_tag_1
   WHERE dat = CURRENT_DATE
   ) vs_1
   ON   i.immo_objekt_id  = vs.immo_objekt_id
   AND i.mandant_id = vs.mandant_id
   LEFT JOIN ( -- Immo: Objektleiter Vermietung
   SELECT
   oz.mandant_id, oz.immo_objekt_id, oz.zustaendig_id, iz.Mitarbeiter_ID, iz.vorname, iz.nachname, iz.anrede
   FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1 oz
   INNER JOIN dbp_msi_view_vis.mv_ivs_objektleiter_1  iz
   ON    oz.zustaendig_id = iz.Mitarbeiter_ID
   AND   oz.mandant_id = iz.mandant_id

   WHERE oz.dat_bis = '9999-12-31'
   AND   oz.zustaendig_typ_id = 2

   UNION
   SELECT
   1::BYTEINT,  'IW----------0'::VARCHAR(20), 0::INT, 0::INT, 'Gebiet'::VARCHAR(40), 'ohne Zuordnung'::VARCHAR(40), NULL::VARCHAR(10)
   FROM dbp_view.v_tag_1
   WHERE dat = CURRENT_DATE
   ) ol
   ON   i.immo_objekt_id = ol.immo_objekt_id
   AND i.mandant_id = ol.mandant_id
   LEFT JOIN (  -- Techn. Platz Zuordnungen (ohne Vertriebsstruktur)
   SELECT
   tp0.techn_platz_id, tp0.mandant_id, tp0.wup_id, COALESCE(tp0.kostenstelle_id, TRIM(tp0.wup_id) || '-800')::VARCHAR(20) kostenstelle_id, tp1.tech_platz_bez, tp2.kbl_nl_bez           nl_bau_einr_bez, tp2.tp_bl_kbl_name       bl_bau_einr_name, tp2.tp_betreuer_kbl_name betreuer_bau_einr_name, tp2.tp_ol_vermietung     ol_vermietung_name, tp2.frische_baecker, tp2.discount_backshop, CASE
   WHEN CONTAINS( tp2.frische_baecker, 'J') OR CONTAINS( tp2.discount_backshop, 'J') THEN 'Ja'
   WHEN CONTAINS( tp2.frische_baecker, 'N') OR CONTAINS( tp2.discount_backshop, 'N') THEN 'Nein'
   ELSE ''
   END::CHAR(4) kaufland_baeckerei, tp2.eigentum_bez  -- not used
   , gfp.ginfo_flaeche_netto   --  neu  inseriert   fuer  PPL
   FROM dbp_view.v_techn_platz_per_1 tp0
   INNER JOIN dbp_view.v_techn_platz_spr_zu_per_1 tp1
   ON    tp0.techn_platz_id = tp1.techn_platz_id
   LEFT JOIN dbp_view.v_techn_platz_ebene_2_per_1 tp2
   ON    tp0.techn_platz_id = tp2.techn_platz_id
   LEFT OUTER JOIN  ---  neu  inseriert   fuer  PPL
   dbp_view.v_ginfo_flaeche_per_1 gfp
   ON    tp0.techn_platz_id = gfp.techn_platz_id

   WHERE tp0.techn_platz_ebene_id = 2
   AND   tp0.dat_bis = '9999-12-31' AND tp1.dat_bis = '9999-12-31' AND tp2.dat_bis ='9999-12-31'
   AND   tp1.spr_id = 22
   AND gfp.ginfo_flaeche_id = 'PPL'   --  neu  inseriert   fuer  PPL
   AND gfp.dat_bis = '9999-12-31'     --  neu  inseriert   fuer  PPL
   ) tp
   ON i.immo_objekt_bez = tp.wup_id AND i.mandant_id = tp.mandant_id

   ;