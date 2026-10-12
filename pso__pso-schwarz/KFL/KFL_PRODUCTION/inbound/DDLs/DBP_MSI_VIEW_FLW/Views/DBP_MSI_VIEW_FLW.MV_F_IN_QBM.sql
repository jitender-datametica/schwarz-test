CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_QBM
-- 30.11.2011 MR Performance art_id Verbindung
-- 26.10.2011 system_id entfernt
-- 22.10.2013 twie: Join zu in_kunde vereinfacht ueber wup_id
-- 24.10.2013 twie: gp_id ausgeben
-- 23.01.2014 twie: Join auf in_art jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
--                             reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
dat
,rekl_grund_id
,in_art_id
,in_art_nr
,in_kunde_id
,mandant_id
,gp_id
--  ,system_id
,basismenge_einh_id
,mhd
,los_charge
,vk_menge_re_org
,vk_menge_re_st
,vk_menge_re_kg
)
AS
   SELECT
   dat, rekl_grund_id, in_art_id, in_art_nr, in_kunde_id, mandant_id, gp_id, basismenge_einh_id, mhd, los_charge, SUM(vk_menge_re_org), SUM(vk_menge_re_st), SUM(vk_menge_re_kg)
   FROM
   (
   SELECT
   v01.dat AS dat, 
    v01.reklamationsgrund_id AS rekl_grund_id, 
    v03.flw_art_id AS in_art_id, 
     v03.in_art_nr AS in_art_nr, 
     v05.flw_kunde_id AS in_kunde_id, 
     v01.mandant_id AS mandant_id, 
     v01.gp_id, v03.basismenge_einh_id, 
     v01.mhd AS mhd, v01.los_charge AS los_charge, 
     v01.vk_menge_re AS vk_menge_re_org, 
     CASE WHEN v03.basismenge_einh_id = 'KG'  AND v03.flw_art_id >= 0 THEN CAST(v01.vk_menge_re * v06.umrech_faktor AS DECIMAL(18,6))
   -- Artikel, die es nur im Retail gibt (Dummy flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren
   WHEN v03.basismenge_einh_id = 'KG'  AND v03.flw_art_id < 0 THEN CAST(v01.vk_menge_re * v07.umrech_faktor AS DECIMAL(18,6))
   WHEN v03.basismenge_einh_id = 'ST' THEN v01.vk_menge_re
   END AS vk_menge_re_st, CASE WHEN v03.basismenge_einh_id = 'KG' THEN v01.vk_menge_re
   WHEN v03.basismenge_einh_id = 'ST'  AND v03.flw_art_id >= 0  THEN CAST(v01.vk_menge_re * v06.umrech_faktor AS DECIMAL(18,6))
   WHEN v03.basismenge_einh_id = 'ST'  AND v03.flw_art_id < 0  THEN CAST(v01.vk_menge_re * v07.umrech_faktor AS DECIMAL(18,6))
   END AS vk_menge_re_kg

   FROM dbp_view.v_rekl  v01
   LEFT JOIN dbp_view.v_art v02
   ON v01.art_id        = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis
   INNER JOIN dbp_msi_view_flw.mv_l_in_art v03     -- MARA + Retail Artikel

   ON v03.art_id     = v02.art_id
   AND v03.mandant_id = v02.mandant_id
   LEFT JOIN dbp_view.v_flw_kunde v05
   ON v05.wup_id = v01.wup_id
   AND v05.mandant_id = v01.mandant_id
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per v06
   ON v03.mandant_id   = v06.mandant_id
   AND v03.flw_art_id = v06.flw_art_id
   AND (CASE WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v06.altnv_menge_einh_id
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per v07
   ON v03.mandant_id   = v07.mandant_id
   AND v03.art_id = v07.art_id
   AND (CASE WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v07.altnv_menge_einh_id
   AND v07.dat_bis = '9999-12-31' 

   WHERE v01.mandant_id = 1
   AND v02.dat_bis = '9999-12-31'
   -- 21.10.11 Awol: Bonstornos (1) werden nicht beruecksichtigt.
   AND bon_storno_fg = 0
   ) AS tmp

   GROUP BY
   tmp.dat
   ,tmp.rekl_grund_id
   ,tmp.in_art_id
   ,tmp.in_art_nr
   ,tmp.in_kunde_id
   ,tmp.mandant_id
   ,tmp.gp_id
   --  ,tmp.system_id
   ,tmp.basismenge_einh_id
   ,tmp.mhd
   ,tmp.los_charge;