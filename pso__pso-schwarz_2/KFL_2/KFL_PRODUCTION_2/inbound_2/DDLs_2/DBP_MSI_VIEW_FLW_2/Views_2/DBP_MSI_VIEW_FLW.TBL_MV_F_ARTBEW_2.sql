CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_ARTBEW_2
   AS 
   SELECT
   v01.dat
   , v01.mandant_id AS mandant_id
   , v01.art_id
   , v05.flw_kunde_id AS in_kunde_id 
   , COLLATE(LTRIM(COLLATE(v05.kunde_nr,''),'0'), 'en-ci') AS kunde_nr
   , v05.kunde_name
   , v03.flw_art_id AS in_art_id
   , v03.in_art_nr
   , v01.menge AS vk_menge_org
   , v03.basismenge_einh_id
   , CASE 
     WHEN v03.basismenge_einh_id = 'KG'  AND v03.flw_art_id >= 0 THEN CAST(v01.menge * v06.umrech_faktor AS DECIMAL(18,6))
   -- Artikel_2, die es nur im Retail gibt (Dummy_2 flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren
   WHEN v03.basismenge_einh_id = 'KG'  AND v03.flw_art_id < 0 THEN CAST(v01.menge * v07.umrech_faktor AS DECIMAL(18,6))
   WHEN v03.basismenge_einh_id = 'ST' THEN v01.menge
   END AS vk_menge_st
   , CASE 
   WHEN v03.basismenge_einh_id = 'KG' THEN v01.menge
   WHEN v03.basismenge_einh_id = 'ST' AND v03.flw_art_id >= 0 THEN CAST(v01.menge * v06.umrech_faktor  AS DECIMAL(18,6))
   WHEN v03.basismenge_einh_id = 'ST' AND v03.flw_art_id < 0 THEN CAST(v01.menge * v07.umrech_faktor  AS DECIMAL(18,6))
   END AS vk_menge_kg
   ,CASE WHEN v08.wg_id IN (122,128,146,147,184,186)  THEN v01.ek_mep ELSE NULL END AS ek_mep_umsatz_temp
   , v01.bewart_id, v01.gp_id, v100.default_wrg, V01.WRG_2, V01.UMSATZ_NETTO
   FROM dbp_view.v_artbew_2 v01
   INNER JOIN dbp_view.v_art_2 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_2 v03     -- MARA_2 + Retailartikel

   ON v03.art_id = v02.art_id
   AND v03.mandant_id = v02.mandant_id
   LEFT JOIN dbp_view.v_flw_kunde_2 v05
   ON v05.wup_id = v01.wup_id
   AND v05.mandant_id = v01.mandant_id
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v06
   ON v03.mandant_id   = v06.mandant_id
   AND v03.flw_art_id = v06.flw_art_id
   AND (CASE WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v06.altnv_menge_einh_id
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_2 v07
   ON v03.mandant_id   = v07.mandant_id
   AND v03.art_id = v07.art_id
   AND (CASE 
   WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v07.altnv_menge_einh_id
   AND v07.dat_bis = '9999-12-31'

   JOIN dbp_msi_view_flw.mv_art_wg_zu_per_2 v08
   ON (v03.flw_art_id = v08.flw_art_id
   AND v03.mandant_id = v08.mandant_id)

   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id
   WHERE v01.mandant_id IN (1,2)
   AND v02.dat_bis='9999-12-31'
   AND v08.art_id > 0
   AND v08.arthiertyp_id = 2;