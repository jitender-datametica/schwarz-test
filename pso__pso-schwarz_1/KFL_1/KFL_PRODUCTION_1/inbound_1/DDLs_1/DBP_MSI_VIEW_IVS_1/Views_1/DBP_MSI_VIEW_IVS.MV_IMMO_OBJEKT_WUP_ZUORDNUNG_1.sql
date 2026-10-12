CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_IMMO_OBJEKT_WUP_ZUORDNUNG_1
AS

-- 2009-05-04
-- ZUORDNUNGEN denormalisiert (aktuell)
-- immo_objekt + wup_1 (Marktstamm) + techn_platz (Ebene 2)
-- Mapping: wup_id(xxx0) - Immo_objekt(xxx8) + wup_id(xxx3) - Immo_objekt(xxx4)
-- 2009KW07 Anpassung an Änderungen aus IOS
-- 2009-05  Anpassung JOIN gf_1-Tabelle (ek_fg)
-- 200912  Thema: Parkplaetze-Anzahl   (Werte von IOS)
-- 200912  Thema: Vermietername  (Werte von  IOS)
-- 200912  Ohne Vermietername / der Name schon in  "ol_vermietung_name"
-- 2010KW33 Umlenken aller Joins auf immo_objekt_per
-- WENN Wup_1-Nachbildung DANN (immo_objekt_bez = wup_id) SONST (immo_objekt_id = immo_objekt_id)
-- 2012KW38 Integration KMO Mandanten
-- 2013KW03 Transkription ergaenzt
-- 2013KW31PU Offizielle Bezeichnungen
--2013KW46 Regionalleiter

SELECT
i.mandant_id
,i.immo_objekt_id
,dbp_process.transcriptc(i.objekt_ort) AS objekt_ort
,dbp_process.transcriptc(
  CASE
WHEN POSITION('PAOB' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION('PAOB' in objekt_name)-1))
WHEN POSITION(',PAOB' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name,1, POSITION(',PAOB' in objekt_name) -1))
WHEN POSITION('UMGL' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION('UMGL' in objekt_name)-1))
WHEN POSITION(',UMGL' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION(',UMGL' in objekt_name)-1))
WHEN POSITION('Partnerobjekt' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name,1, POSITION('Partnerobjekt' in objekt_name)-1))
ELSE objekt_name END
) AS objekt_name
,vs.Mitarbeiter_ID      vorstand_mitarbeiter_id
,vs.nachname            vorstand_nachname
,vs.vorname             vorstand_vorname
,ol.zustaendig_id      objektleiter_mitarbeiter_id
,dbp_process.transcriptc(ol.nachname) AS             objektleiter_nachname
,dbp_process.transcriptc(ol.vorname) AS             objektleiter_vorname
,rl.zustaendig_id                                         AS rl_ma_id
,dbp_process.transcriptc(rl.nachname) AS rl_nachname
,dbp_process.transcriptc(rl.vorname)    AS rl_vorname

,w.wup_id
,w.wup_standort
,w.dat_von                        wup_dat_von
,NULLIF(w.dat_eroeffnung,CAST('2090-12-31' AS DATE)) wup_eroeffnung
,NULLIF(w.dat_bis,CAST('9999-12-31' AS DATE))       wup_schliessung
,w.vsvt_bez
,w.gf_id
,w.gf_name
,w.vkl_id
,w.vkl_name
,w.hl_id
,w.hl_name
,tp.techn_platz_id
,tp.tech_platz_bez
,tp.nl_bau_einr_bez
,dbp_process.transcriptc(tp.bl_bau_einr_name) AS bl_bau_einr_name
,dbp_process.transcriptc(tp.betreuer_bau_einr_name) AS betreuer_bau_einr_name
,dbp_process.transcriptc(tp.ol_vermietung_name) AS  ol_vermietung_name-- momentan nicht verwendet
,tp.frische_baecker
,tp.discount_backshop
,tp.kaufland_baeckerei
,dbp_process.transcriptc(tp.eigentum_bez) AS  eigentum_bez-- nicht verwendet (aus KOVA)
,i.immo_objekt_bez
,CAST(NULL AS DATE) objekt_miete_bis  -- nicht verwendet (aus KOVA)
,w.verkaufsflaeche      flaeche_verkauf
,w.betriebsflaeche      flaeche_betrieb
,CAST(0 AS DECIMAL(18,2))      flaeche_konzessionaere
,COALESCE(tp.ginfo_flaeche_netto , 0 ) AS flaeche_parkplaetze   --  neu  inseriert   fuer  PPL
,''      telefon_nr
,''    telefax_nr
FROM
(
SELECT
mandant_id
,immo_objekt_id
,dat_von
,dat_bis
,objekt_groesse
,konzessionaer_groesse
,objekt_ort
,objekt_strasse
,objekt_plz
,objekt_name
,dat_1bereich_oeffnung
,dat_objekt_oeffnung
,eigenmiete_pro_qm
,eigenmiete_pro_monat
,wrg_id
,objektart_id
,objektart_datum_von
,objektart_datum_bis
,system_id
,buchungskreis_id
,immo_objekt_obj_id
,immo_objekt_bez
,immo_objekt_nr
FROM dbp_view.v_ivs_immo_objekt_per_1
WHERE dat_bis = CAST('9999-12-31'  AS DATE)

UNION
SELECT
mandant_id
, 'IW----------0'  AS immo_objekt_id
,CAST('1900-01-01' AS DATE) AS dat_von
,CAST('9999-12-31'  AS DATE) AS dat_bis
,0 AS objekt_groesse
,0 AS konzessinoaer_groesse
,'' AS objekt_org
,'' AS objekt_strasse
,'' AS objekt_plz
,'ohne Zuordnung'  AS objekt_name
,CAST('1900-01-01' AS DATE) AS dat_1bereicth_oeffnung
,CAST('1900-01-01' AS DATE) AS dat_objekt_oeffnung
,0.00 AS eigenmiete_pro_qm
,0.00 AS eigenmiete_pro_monat
,default_wrg AS wrg_id
,'3'  AS objekart_id
,CAST('1900-01-01' AS DATE) AS objektart_datum_von
,CAST('9999-12-31' AS DATE) AS objektart_datum_bis
,0 AS sysetem_id
,0 AS buchungskreis_id
,'IW----------0' AS immo_objekt_obj_id
,0 AS immo_objekt_bez
,'' AS immo_objekt_nr
FROM  dbp_view.v_tag_1

INNER JOIN dbp_view.v_mandant_1 m
ON 1=1

WHERE dat = CURRENT_DATE
) i

LEFT JOIN -- WUP_1 Vertriebszuordnungen GF_1, VKL_1, Schiene
(
SELECT
w1.mandant_id
,w1.wup_id
,w1.wup_standort
,w1.dat_eroeffnung
,w1.dat_von
,w1.dat_bis
,gf1.gf_id
,gf1.gf_name
,vs1.vsvt_bez
,w1.vkl_id
,vkl1.vkl_name
,w1.hl_id
,hl1.hl_name
,w1.verkaufsflaeche
,w1.betriebsflaeche
FROM dbp_view.v_wup_1  w1

LEFT JOIN dbp_view.v_hl_1 hl1
ON w1.hl_id = hl1.hl_id
AND w1.mandant_id = hl1.mandant_id

LEFT JOIN dbp_view.v_vkl_1 vkl1
ON w1.vkl_id = vkl1.vkl_id
AND w1.mandant_id = vkl1.mandant_id

LEFT JOIN dbp_view.v_gf_1 gf1
ON vkl1.gf_id = gf1.gf_id
AND vkl1.mandant_id = gf1.mandant_id
AND gf1.ek_fg = 0

LEFT JOIN dbp_view.v_vs_1 vs1
ON w1.vs_id = vs1.vs_id
AND w1.mandant_id = vs1.mandant_id

WHERE w1.nb_id = 0
AND w1.dat_eroeffnung > '1900-01-01'
)  w
ON i.immo_objekt_bez = w.wup_id
AND i.mandant_id = w.mandant_id

LEFT JOIN -- Immo: Vorstand (=Gebiet)
(
SELECT
oz.mandant_id
,oz.immo_objekt_id
,oz.zustaendig_id
,iz.mitarbeiter_id
,iz.vorname
,iz.nachname
,iz.anrede
FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1 oz

INNER JOIN dbp_msi_view_ivs.mv_vorstand_1  iz
ON oz.zustaendig_id = iz.mitarbeiter_id
AND oz.mandant_id = iz.mandant_id

WHERE oz.dat_bis = CAST('9999-12-31' AS DATE)
AND oz.zustaendig_typ_id = 1

UNION

SELECT
mandant_id
,CAST('IW----------0' AS VARCHAR(20))
,0 
,0
,'Gebiet' ::VARCHAR(40)
,'ohne Zuordnung' ::VARCHAR(40)
,NULL
FROM dbp_view.v_tag_1

INNER JOIN dbp_view.v_mandant_1
ON 1=1

WHERE dat = CURRENT_DATE
) vs_1
ON i.immo_objekt_id  = vs.immo_objekt_id
AND i.mandant_id = vs.mandant_id

LEFT JOIN -- Immo: Objektleiter Vermietung
(
SELECT
oz.mandant_id
, oz.immo_objekt_id
, oz.zustaendig_id
, iz.vorname
, iz.nachname
, iz.anrede
FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1 oz

INNER JOIN dbp_view.v_ivs_immo_zustaendig_1  iz
ON  oz.zustaendig_id = iz.zustaendig_id
AND oz.mandant_id = iz.mandant_id

WHERE oz.dat_bis = CAST('9999-12-31' AS DATE)
AND   oz.zustaendig_typ_id = 2

UNION ALL
SELECT
mandant_id
,'IW----------0' ::VARCHAR(20)
,0 
,'ohne' ::VARCHAR(40)
,'Zuordnung' :: VARCHAR(40)
,'' 
FROM dbp_view.v_mandant_1
) ol
ON i.immo_objekt_id = ol.immo_objekt_id
AND i.mandant_id = ol.mandant_id

LEFT JOIN -- Immo: Regionalleiter
(
SELECT
oz.mandant_id
, oz.immo_objekt_id
, oz.zustaendig_id
, iz.vorname
, iz.nachname
, iz.anrede
FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1 oz

INNER JOIN dbp_view.v_ivs_immo_zustaendig_1  iz
ON  oz.zustaendig_id = iz.zustaendig_id
AND oz.mandant_id = iz.mandant_id

WHERE oz.dat_bis = CAST('9999-12-31' AS DATE)
AND   oz.zustaendig_typ_id = 3

UNION ALL
SELECT
mandant_id
,'IW----------0' 
,0 
,'ohne' 
,'Zuordnung' 
,'' 
FROM dbp_view.v_mandant_1
) rl
ON i.immo_objekt_id = rl.immo_objekt_id
AND i.mandant_id = rl.mandant_id


LEFT JOIN
(
-- Techn. Platz Zuordnungen (ohne Vertriebsstruktur)
SELECT
tp0.techn_platz_id
,tp0.mandant_id
,tp0.wup_id
,CAST(COALESCE(tp0.kostenstelle_id, TRIM(tp0.wup_id) || '-800') AS VARCHAR(20)) kostenstelle_id
,tp1.tech_platz_bez
,tp2.kbl_nl_bez           nl_bau_einr_bez
,tp2.tp_bl_kbl_name       bl_bau_einr_name
,tp2.tp_betreuer_kbl_name betreuer_bau_einr_name
,tp2.tp_ol_vermietung     ol_vermietung_name
,tp2.frische_baecker
,tp2.discount_backshop
,CAST(CASE WHEN tp2.frische_baecker LIKE '%J%' OR tp2.discount_backshop LIKE '%J%' THEN 'Ja'
WHEN tp2.frische_baecker LIKE '%N%' OR tp2.discount_backshop LIKE '%N%' THEN 'Nein'
ELSE ''
END AS CHAR(4)) kaufland_baeckerei
,tp2.eigentum_bez  -- not used
,gfp.ginfo_flaeche_netto   --  neu  inseriert   fuer  PPL
FROM dbp_view.v_techn_platz_per_1 tp0

INNER JOIN dbp_view.v_techn_platz_spr_zu_per_1 tp1
ON tp0.techn_platz_id = tp1.techn_platz_id

LEFT JOIN dbp_view.v_techn_platz_ebene_2_per_1 tp2
ON tp0.techn_platz_id = tp2.techn_platz_id

LEFT OUTER JOIN dbp_view.v_ginfo_flaeche_per_1 gfp
ON tp0.techn_platz_id = gfp.techn_platz_id

WHERE tp0.techn_platz_ebene_id = 2
AND tp0.dat_bis = CAST('9999-12-31' AS DATE)
AND tp1.dat_bis = CAST('9999-12-31' AS DATE)
AND tp2.dat_bis = CAST('9999-12-31' AS DATE)
AND tp1.spr_id = 22
AND gfp.ginfo_flaeche_id = 'PPL'
AND gfp.dat_bis = CAST('9999-12-31' AS DATE)     --  neu  inseriert   fuer  PPL
) tp
ON i.immo_objekt_bez = tp.wup_id
AND i.mandant_id = tp.mandant_id;