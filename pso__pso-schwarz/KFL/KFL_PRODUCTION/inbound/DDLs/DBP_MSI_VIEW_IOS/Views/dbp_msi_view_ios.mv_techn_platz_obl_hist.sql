CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_techn_platz_obl_hist

--  2009-05-20 (T.Banh)
--  Entfernung von Sub-Select mit max(cpr_ext_id)-Logik zur Ausgabe aller Projekte
--  28.05.2009 (A. Lipkin)
--  Behandlung Technischen Plätze, für welche keine Projekte existieren
--  29.06.2009 (A. Lipkin) Einschränkung auf  die freigegebene Projekte systemstatus _id= 2
--  02.07.2009 (A. Wenzel) Laufende Nummer jetzt in der View erzeugen
--  08.07.2009 (A. Wenzel) Erweiterung Laufende Nummer (Soll jetzt über Mandant gruppiert werden (lt. Herr Kehnen bei Jour Fix 8.7.2009))
--  30.07.2009 (A. Wenzel) Anpassen um MSI zu helfen fuer das "Group By"
--  02.10.2009 (K. Kaiser) 3 neue Felder Anforderung 120184 + 148914 (tp_betreuer_handy_nr, tp_betreuer_hls_name, tp_betreuer_elektro_name)
-- 20150915 (kkai0912) Datenquelle geändert:   tp_vl_name, tp_vkl_name nun von dbp_msi_v_view.v_wup_denorm, Anfo # 619370

AS
SELECT
--cast ( 1 AS INTEGER) AS  lfdnr
CAST((CASE WHEN ROW_NUMBER() OVER (PARTITION BY obl.techn_platz_id ORDER BY cpr_ext_id) = 1 THEN 1 ELSE 0 END) AS INTEGER) AS lfdnr
,obl.techn_platz_id
,obl.techn_platz_id AS sort_techn_platz_id
,obl.projekt_id  AS projekt_id
,cpr_ext_id
,obl.mandant_id
-- aktuelle Zuordnungen
,obl.tp_vl_name
,obl.tp_vkl_name
,obl.tp_ol_vermietung
,obl.tp_bl_kbl_name
,obl.tp_betreuer_kbl_name

,obl.tp_betreuer_handy_nr
,obl.tp_betreuer_hls_name
,obl.tp_betreuer_elektro_name

,obl.tp_bl_projekt_name
,obl.tp_pl_kbl
-- historisierte Zuordnungen
,oblh.tp_vl_name                tp_vl_name_h
,oblh.tp_vkl_name               tp_vkl_name_h
,oblh.tp_ol_vermietung          tp_ol_vermietung_h
,oblh.tp_bl_kbl_name            tp_bl_kbl_name_h
,oblh.tp_betreuer_kbl_name      tp_betreuer_kbl_name_h

,oblh.tp_betreuer_handy_nr      tp_betreuer_handy_nr_h
,oblh.tp_betreuer_hls_name      tp_betreuer_hls_name_h
,oblh.tp_betreuer_elektro_name  tp_betreuer_elektro_name_h

,oblh.tp_bl_projekt_name        tp_bl_projekt_name_h
,oblh.tp_pl_kbl                 tp_pl_kbl_h
--Flags zur Kennzeichnung von Änderungen
,CASE
WHEN COALESCE(obl.tp_vl_name, '') = COALESCE(oblh.tp_vl_name, '')
THEN 0
ELSE 1
END tp_vl_name_fgh
,CASE
WHEN COALESCE(obl.tp_vkl_name, '') = COALESCE(oblh.tp_vkl_name, '')
THEN 0
ELSE 1
END tp_vkl_name_fgh
,CASE
WHEN COALESCE(obl.tp_ol_vermietung, '') = COALESCE(oblh.tp_ol_vermietung, '')
THEN 0
ELSE 1
END tp_ol_vermietung_fgh
,CASE
WHEN COALESCE(obl.tp_bl_kbl_name, '') = COALESCE(oblh.tp_bl_kbl_name, '')
THEN 0
ELSE 1
END tp_bl_kbl_name_fgh
,CASE
WHEN COALESCE(obl.tp_betreuer_kbl_name, '') = COALESCE(oblh.tp_betreuer_kbl_name, '')
THEN 0
ELSE 1
END tp_betreuer_kbl_name_fgh
,CASE
WHEN COALESCE(obl.tp_betreuer_handy_nr, '') = COALESCE(oblh.tp_betreuer_handy_nr, '')
THEN 0
ELSE 1
END tp_betreuer_handy_nr_fgh
,CASE
WHEN COALESCE(obl.tp_betreuer_hls_name, '') = COALESCE(oblh.tp_betreuer_hls_name, '')
THEN 0
ELSE 1
END tp_betreuer_hls_name_fgh
,CASE
WHEN COALESCE(obl.tp_betreuer_elektro_name, '') = COALESCE(oblh.tp_betreuer_elektro_name, '')
THEN 0
ELSE 1
END tp_betreuer_elektro_name_fgh
,CASE
WHEN COALESCE(obl.tp_bl_projekt_name, '') = COALESCE(oblh.tp_bl_projekt_name, '')
THEN 0
ELSE 1
END tp_bl_projekt_name_fgh
,CASE
WHEN COALESCE(obl.tp_pl_kbl, '') = COALESCE(oblh.tp_pl_kbl, '')
THEN 0
ELSE 1
END tp_pl_kbl_fgh

,oblh_dat.dat_extrakt

FROM
(
-- 1. Basis Techn_Platz-Daten
SELECT
tp.techn_platz_id
, pr.projekt_id
,tp.mandant_id
-- Attribut GF/ VL Vertrieb
,((TRIM(ma_spr_zu_gf.ma_anrede,' ') || ' ' || TRIM(ma_spr_zu_gf.ma_vorname,' ') || ' ' || TRIM(ma_spr_zu_gf.ma_name,' ')))  AS tp_vl_name
-- Attribut VKL Vertrieb
,((TRIM(ma_spr_zu_vkl.ma_anrede,' ') || ' ' || TRIM(ma_spr_zu_vkl.ma_vorname,' ') || ' ' || TRIM(ma_spr_zu_vkl.ma_name,' ')))  AS tp_vkl_name
,tp2.tp_ol_vermietung
,tp2.tp_bl_kbl_name
,tp2.tp_betreuer_kbl_name
,tp2.tp_betreuer_handy_nr
,tp2.tp_betreuer_hls_name
,tp2.tp_betreuer_elektro_name
,pr.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name
,pr.pl_be_name  AS tp_pl_kbl
,COALESCE(pr.cpr_ext_id, '') AS cpr_ext_id
,CURRENT_DATE()           AS dat_extrakt
FROM dbp_view.v_techn_platz_per  tp

INNER JOIN dbp_view.v_techn_platz_ebene_2_per tp2
ON  tp.techn_platz_id = tp2.techn_platz_id
AND tp2.dat_bis = '9999-12-31'

INNER JOIN dbp_view.v_techn_platz_spr_zu_per tp_s
ON  tp.techn_platz_id = tp_s.techn_platz_id
AND tp_s.spr_id = 22
AND tp_s.dat_bis = '9999-12-31'


LEFT OUTER JOIN dbp_msi_v_view.v_wup_denorm wup_denorm
ON   tp.wup_id          =  wup_denorm.wup_id
AND tp2.mandant_id = wup_denorm.mandant_id

-- Attribut VKL Vertrieb
LEFT OUTER JOIN dbp_view.v_vkl vkl
ON   vkl.vkl_id          =  wup_denorm.vkl_id
AND vkl.mandant_id = wup_denorm.mandant_id

LEFT OUTER JOIN dbp_view.v_ma_spr_zu     ma_spr_zu_vkl
ON   vkl.vkl_id          =  ma_spr_zu_vkl.ma_id
AND vkl.mandant_id = ma_spr_zu_vkl.mandant_id
AND ma_spr_zu_vkl.spr_id = 22

-- Attribut GF/ VL Vertrieb
LEFT OUTER JOIN dbp_view.v_gf     gf
ON   gf.gf_id          =  wup_denorm.gf_gbl_vertrieb_id
AND gf.mandant_id = wup_denorm.mandant_id

LEFT OUTER JOIN dbp_view.v_ma_spr_zu   ma_spr_zu_gf
ON   gf.gf_id          =  ma_spr_zu_gf.ma_id
AND gf.mandant_id = ma_spr_zu_gf.mandant_id
AND ma_spr_zu_gf.spr_id = 22



LEFT OUTER JOIN
(
SELECT
pr0.mandant_id
,pr0.techn_platz_id
,pr0.pl_be_name
,pr0.cpr_bl_projekt_bau_einr_name
,pr0.projekt_id
,pr0.cpr_ext_id
FROM dbp_view.v_cpr_projekt_per pr0
WHERE pr0.dat_bis = '9999-12-31'
AND pr0.cpr_standort IS NOT NULL
AND pr0.cpr_systemstatus1_id  = 2
) pr
ON  tp.techn_platz_id = pr.techn_platz_id
AND tp.mandant_id     = pr.mandant_id

WHERE tp.wup_stadt IS NOT NULL
AND tp.techn_platz_ebene_id = 2
AND tp.dat_bis = '9999-12-31'


-- 2. Basis Projektdaten
UNION ALL


SELECT
pr.techn_platz_id
,pr.projekt_id
,pr.mandant_id
,'' AS tp_vl_name
,'' AS tp_vkl_name
,'' AS tp_ol_vermietung
,'' AS tp_bl_kbl_name
,'' AS tp_betreuer_kbl_name
,'' AS tp_betreuer_handy_nr
,'' AS tp_betreuer_hls_name
,'' AS tp_betreuer_elektro_name
,pr.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name
,pr.pl_be_name AS tp_pl_kbl
,pr.cpr_ext_id
,CURRENT_DATE() AS dat_extrakt
FROM dbp_view.v_cpr_projekt_per pr

INNER JOIN dbp_view.v_cpr_projekt_spr_zu_per pr_s
ON  pr.projekt_id = pr_s.projekt_id
AND pr_s.spr_id   = 22
AND pr_s.dat_bis = '9999-12-31'

WHERE
pr.cpr_systemstatus1_id  = 2 AND
pr.techn_platz_id NOT IN
(
SELECT
tp0.techn_platz_id  techn_platz_id
FROM dbp_view.v_techn_platz_per  tp0
WHERE tp0.wup_stadt IS NOT NULL
AND tp0.techn_platz_ebene_id = 2
AND tp0.dat_bis = '9999-12-31'
)
AND pr.cpr_standort IS NOT NULL
AND pr.dat_bis = '9999-12-31'
) obl

LEFT OUTER JOIN dbp_msi_view_ios.mv_techn_platz_obl_basis_hist oblh
ON  obl.techn_platz_id = oblh.techn_platz_id
AND COALESCE(obl.projekt_id, '') =COALESCE(oblh.projekt_id, '')

INNER JOIN
( -- Gruppierung dat_extrakt, gilt für alle (auch neue) Sätze
SELECT mandant_id, MAX(dat_extrakt)  dat_extrakt
FROM   dbp_msi_view_ios.mv_techn_platz_obl_basis_hist
GROUP BY mandant_id
) oblh_dat
ON obl.mandant_id = oblh_dat.mandant_id;
