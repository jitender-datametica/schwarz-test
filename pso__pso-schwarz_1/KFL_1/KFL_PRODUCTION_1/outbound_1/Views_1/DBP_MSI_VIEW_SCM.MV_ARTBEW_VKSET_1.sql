-- 2025-04-07,AP0261080,dknop, initial
 -- , t.dat
 -- , t.dat

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_artbew_vkset_1(USERID STRING) AS WITH VKS AS (SELECT MAST.mandant_id,
   MAST.stueckliste_id -- ,t.dat
,
   A.hwg_id,
   MAST.art_id AS art_id_vkset,
   STPO.art_id AS art_id_komponente,
   STPO.komponentenmenge,
   STPO.komponentenmenge_einh_id,
   MARA.gewart_id AS menge_einh_komp,
   MARA_KOMP.gewart_id AS menge_einh_vkset,
   MARM_ST.bruttogew AS brtgew_komp,
   MARM_KOMP.umrech_faktor,
   MARM_ST.umrech_faktor AS umrech_faktor0,
    CASE
    WHEN STPO.komponentenmenge_einh_id = MARA.gewart_id
    THEN STPO.komponentenmenge -- G in ST/KG:

    WHEN STPO.komponentenmenge_einh_id = 'G' AND MARA_KOMP.gewart_id IN ('KG', 'ST')
    THEN STPO.komponentenmenge / MARM_KOMP.umrech_faktor
     -- CASE WHEN marm_st.bruttogew <> 0 THEN (marm_st.bruttogew*1000)

    ELSE 1
    END AS faktor_vkset_zu_komponente
  FROM kfl_production_dbp_view.v_stueckliste_1 AS MAST_1
   INNER JOIN kfl_production_dbp_view.v_art_1 AS MARA_1 ON MAST.mandant_id = MARA.mandant_id AND MAST.art_id = MARA.art_id
    AND MARA.artikeltyp_id = 10
     /* JOIN KFL_PRODUCTION.dbp_view.v_tag_1 t
ON t.dat BETWEEN mast.dat_von AND mast.dat_bis */
   INNER JOIN kfl_production_dbp_view.v_stueckliste_det_1 AS STPO_1 ON MAST.mandant_id = STPO.mandant_id AND MAST.stueckliste_id
      = STPO.stueckliste_id
   INNER JOIN kfl_production_dbp_view.v_art_1 AS MARA_KOMP ON STPO.mandant_id = MARA_KOMP.mandant_id AND STPO.art_id =
     MARA_KOMP.art_id
   INNER JOIN kfl_production_dbp_msi_view_scm.mv_art_denorm_1 AS A ON STPO.mandant_id = A.mandant_id AND STPO.art_id
     -- umrechnung von G in KG
 = A.art_id
   INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS MARM_KOMP ON STPO.mandant_id = MARM_KOMP.mandant_id
        AND STPO.art_id = MARM_KOMP.art_id -- AND t.dat BETWEEN marm_komp.dat_von AND marm_komp.dat_bis
 AND MARM_KOMP.dat_bis
       = DATE '9999-12-31' AND STPO.komponentenmenge_einh_id = MARM_KOMP.altnv_menge_einh_id -- umrechnung von KG in ST

     
   INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS MARM_ST ON STPO.mandant_id = MARM_ST.mandant_id AND
       STPO.art_id = MARM_ST.art_id -- AND t.dat BETWEEN marm_st.dat_von AND marm_komp.dat_bis
 AND MARM_ST.dat_bis =
      DATE '9999-12-31' AND MARA_KOMP.gewart_id = MARM_ST.altnv_menge_einh_id
  WHERE MAST.stueckliste_verwendung_id = 3
   AND STPO.stueckliste_typ_id = 'M'
   AND MARA.mandant_id = 1 -- AND t.dat = CURRENT_DATE --

   AND A.hwg_id NOT IN (82)
  QUALIFY (COUNT(STPO.art_id) OVER (PARTITION BY CAST(MAST.mandant_id AS STRING), CAST(MAST.art_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1 AND (COUNT(MAST.art_id) OVER (PARTITION BY CAST(MAST.mandant_id AS STRING)
         , CAST(STPO.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1) (-- Gleiche ME, z. B. ST in ST:

  -- ohne Imbiss
 SELECT artbew.dat,
   T.kjwo,
   T.kjmo,
   artbew.art_id,
   COALESCE(vks_komp.art_id_komponente, vks_vks.art_id_komponente) AS art_id_bestellartikel,
    CASE
    WHEN vks_vks.mandant_id IS NOT NULL
    THEN vks_vks.faktor_vkset_zu_komponente
    ELSE 1
    END AS faktor,
   artbew.mandant_id,
   artbew.nb_id,
   V05.aktuell_wup_id AS wup_id,
   artbew.vk_menge,
    artbew.vk_menge * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS vk_menge_bestellartikel,
   artbew.vk_menge_af,
    artbew.vk_menge_af * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS vk_menge_af_bestellartikel,
   artbew.vk_menge_sa,
    artbew.vk_menge_sa * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS vk_menge_sa_bestellartikel,
    artbew.umsatz_netto * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS umsatz_netto_bestellartikel,
    artbew.umsatz_netto_af * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS umsatz_netto_af_bestellartikel,
    artbew.umsatz_netto_sa * CASE
     WHEN vks_vks.mandant_id IS NOT NULL
     THEN vks_vks.faktor_vkset_zu_komponente
     ELSE 1
     END AS umsatz_netto_sa_bestellartikel,
   artbew.umsatz_netto,
   artbew.umsatz_netto_af,
   artbew.umsatz_netto_sa
  FROM (SELECT V01.dat,
     V01.art_id,
     V01.mandant_id,
     V01.nb_id,
     V01.wup_id,
     SUM(V01.menge) AS vk_menge,
     SUM(CASE
       WHEN V01.bewart_id IN (1001, 1010)
       THEN V01.menge
       ELSE NULL
       END) AS vk_menge_af,
     SUM(CASE
       WHEN V01.bewart_id = 1002
       THEN V01.menge
       ELSE NULL
       END) AS vk_menge_sa,
     SUM(CASE
       WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1
       THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
       ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
       END) AS umsatz_netto,
     SUM(CASE
       WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
       THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
       WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
           IN (1001, 1010)
       THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
       ELSE NULL
       END) AS umsatz_netto_af,
     SUM(CASE
       WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
       THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
       WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id =
          1002
       THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
       ELSE NULL
       END) AS umsatz_netto_sa
    FROM kfl_production_dbp_view.v_artbew_1 AS V01
     INNER JOIN kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V02 ON TRUE
    GROUP BY V01.dat,
     V01.art_id,
     V01.mandant_id,
     V01.nb_id,
     V01.wup_id) AS artbew_1
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON artbew.dat = T.dat
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON artbew.mandant_id = V05.mandant_id AND artbew.wup_id = V05.wup_id
    AND V05.nb_id = 0
   LEFT JOIN VKS AS vks_komp ON -- artbew.dat = vks_komp.dat AND
 artbew.mandant_id = vks_komp.mandant_id AND artbew.art_id
      = vks_komp.art_id_komponente
   LEFT JOIN VKS AS vks_vks ON -- artbew.dat = vks_vks.dat AND
 artbew.mandant_id = vks_vks.mandant_id AND artbew.art_id
      = vks_vks.art_id_vkset
  WHERE vks_vks.mandant_id IS NOT NULL
   OR vks_komp.mandant_id IS NOT NULL);