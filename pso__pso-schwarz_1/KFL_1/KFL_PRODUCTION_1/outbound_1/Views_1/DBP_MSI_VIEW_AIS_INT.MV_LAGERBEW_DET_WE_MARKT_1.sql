CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_lagerbew_det_we_markt_1 (mandant_id, wup_id, nb_id, art_id,
dat, gp_id, we_markt_we_vz, we_markt_we_vz_ret, we_markt_we_vz_inkl_ret, we_markt_vz_vkn, we_markt_vz_vkn_ret,
we_markt_vz_vkn_inkl_ret, posten_kz_per) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat_buch AS dat,
 V01.gp_id,
 SUM(CASE
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311')
   THEN ABS(V01.menge_lagerbew_bme)
   ELSE 0
   END) AS we_markt_we_vz,
 SUM(CASE
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312')
   THEN - 1 * ABS(V01.menge_lagerbew_bme)
   ELSE 0
   END) AS we_markt_we_vz_ret,
  SUM(CASE
    WHEN V01.lager_bewart_id IN ('641', '647', '301', '311')
    THEN ABS(V01.menge_lagerbew_bme)
    ELSE 0
    END) + SUM(CASE
    WHEN V01.lager_bewart_id IN ('642', '648', '302', '312')
    THEN - 1 * ABS(V01.menge_lagerbew_bme)
    ELSE 0
    END) AS we_markt_we_vz_inkl_ret,
 SUM(CASE
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN V05.umrechnungskurs * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V06.umrechnungskurs * ABS(V01.betrag_vk_netto)
   ELSE 0
   END) AS we_markt_vz_vkn,
 SUM(CASE
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V05.umrechnungskurs * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V06.umrechnungskurs * ABS(V01.betrag_vk_netto)
   ELSE 0
   END) AS we_markt_vz_vkn_ret,
  SUM(CASE
    WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 1
    THEN ABS(V01.betrag_vk_netto)
    WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
    THEN V05.umrechnungskurs * ABS(V01.betrag_vk_netto)
    WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
    THEN V06.umrechnungskurs * ABS(V01.betrag_vk_netto)
    ELSE 0
    END) + SUM(CASE
    WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 1
    THEN - 1 * ABS(V01.betrag_vk_netto)
    WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
    THEN - 1 * V05.umrechnungskurs * ABS(V01.betrag_vk_netto)
    WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
    THEN - 1 * V06.umrechnungskurs * ABS(V01.betrag_vk_netto)
    ELSE 0
    END) AS we_markt_vz_vkn_inkl_ret,
 SUBSTR(CASE
   WHEN V07.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_lagerbew_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON V01.mandant_id_empfaenger = V03.mandant_id AND V01.empfaenger_id =
    V03.wup_id AND V03.nb_id = - 111
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V04 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V05 ON V01.wrg_id = V05.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V06 ON V01.dat_buch BETWEEN V06.dat_von AND V06.dat_bis AND V01.wrg_id =
   V06.von_wrg_id
 LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS V07 ON V01.art_id = V07.art_id AND V01.mandant_id = V07.mandant_id AND
   V01.dat_buch BETWEEN DATE_SUB(V07.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V07.dat_bis, INTERVAL 1 DAY))
WHERE V06.kurstyp_id = 3
 AND V06.nach_wrg_id = 'EUR'
 AND V05.dat_bis = DATE '9999-12-31'
 AND V05.kurstyp_id = 3
 AND V05.nach_wrg_id = 'EUR'
 AND V01.mandant_id <> 1
 AND V01.lager_bewart_id IN ('641', '647', '301', '311', '642', '648', '302', '312')
GROUP BY V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 dat,
 V01.gp_id,
 posten_kz_per
UNION ALL
SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 gp_id,
 SUM(faktura_menge_bme) AS we_markt_we_vz,
 SUM(faktura_menge_bme_ret) AS we_markt_we_vz_ret,
  SUM(faktura_menge_bme) + SUM(faktura_menge_bme_ret) AS we_markt_we_vz_inkl_ret,
 SUM(faktura_wert_ek_netto) AS we_markt_vz_vkn,
 SUM(faktura_wert_ek_netto_ret) AS we_markt_vz_vkn_ret,
  SUM(faktura_wert_ek_netto) + SUM(faktura_wert_ek_netto_ret) AS we_markt_vz_vkn_inkl_ret,
 posten_kz_per
FROM (SELECT V01.mandant_id,
    V03.wup_id,
    V03.nb_id,
    V01.art_id,
     CASE
     WHEN V08.hwg_id = 64
     THEN V01.dat_preisfindung
     ELSE V01.dat_faktura
     END AS dat,
    V09.gp_id,
    CAST(CASE
      WHEN V02.faktura_typ_id = 'N'
      THEN V01.menge_faktura_bme * - 1
      WHEN V02.faktura_typ_id NOT IN ('O', 'S')
      THEN V01.menge_faktura_bme
      ELSE 0
      END AS NUMERIC) AS faktura_menge_bme,
    CAST(CASE
      WHEN V02.faktura_typ_id = 'O'
      THEN V01.menge_faktura_bme * - 1
      WHEN V02.faktura_typ_id = 'S'
      THEN V01.menge_faktura_bme
      ELSE 0
      END AS NUMERIC) AS faktura_menge_bme_ret,
    CAST(CASE
      WHEN V02.faktura_typ_id = 'N'
      THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * - 1
      WHEN V02.faktura_typ_id NOT IN ('O', 'S')
      THEN V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag
      ELSE 0
      END AS NUMERIC) AS faktura_wert_ek_netto,
    CAST(CASE
      WHEN V02.faktura_typ_id = 'O'
      THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * - 1
      WHEN V02.faktura_typ_id = 'S'
      THEN V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag
      ELSE 0
      END AS NUMERIC) AS faktura_wert_ek_netto_ret,
    SUBSTR(CASE
      WHEN V10.posten_id NOT IN ('PN', 'PF', 'SP')
      THEN 'SO'
      ELSE 'PN'
      END, 1, 2) AS posten_kz_per
   FROM kfl_production_dbp_view.v_besch_faktura_det_1 AS V01
    INNER JOIN kfl_production_dbp_view.v_besch_faktura_1 AS V02 ON V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
         = V02.mandant_id AND V01.dat_faktura_sap = V02.dat_faktura_sap AND V02.auftraggeber_id BETWEEN '0000001000' AND
      '0000009999'
    INNER JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON ROUND(SAFE_CAST(V02.auftraggeber_id AS BIGNUMERIC), 0) = V03.wup_id
       AND V01.mandant_id = V03.mandant_id
    INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
        AND CURRENT_DATE BETWEEN V05.dat_von AND V05.dat_bis
    INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS V06 ON V05.wg_id = V06.wg_id AND V05.mandant_id = V06.mandant_id AND
      CURRENT_DATE BETWEEN V06.dat_von AND V06.dat_bis
    INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS V07 ON V06.owg_id = V07.owg_id AND V06.mandant_id = V07.mandant_id
     AND CURRENT_DATE BETWEEN V07.dat_von AND V07.dat_bis
    INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS V08 ON V07.hwg_id = V08.hwg_id AND V07.mandant_id = V08.mandant_id
     AND CURRENT_DATE BETWEEN V08.dat_von AND V08.dat_bis
    INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V09 ON V01.art_id = V09.art_id AND V01.wup_id = V09.wup_id
      AND CASE
        WHEN V08.hwg_id = 64
        THEN V01.dat_preisfindung
        ELSE V01.dat_faktura
        END BETWEEN V09.dat_von AND V09.dat_bis AND V01.mandant_id = V09.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS V10 ON V01.art_id = V10.art_id AND V01.mandant_id = V10.mandant_id
     AND V01.dat_faktura BETWEEN DATE_SUB(V10.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V10.dat_bis, INTERVAL 1 DAY))
   WHERE V01.mandant_id = 1
    AND V01.nb_id <> 99
    AND (V08.hwg_id = 64 AND V01.dat_preisfindung BETWEEN V09.dat_von AND V09.dat_bis OR V08.hwg_id <> 64 AND V01.dat_faktura
        BETWEEN V09.dat_von AND V09.dat_bis)
    AND V02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
   UNION ALL
   SELECT V01.mandant_id,
    V02.wup_id,
    V02.nb_id,
    V01.art_id,
    V01.dat_faktura AS dat,
    V03.gp_id,
     CASE
     WHEN V01.menge_fakturiert > 0
     THEN V01.menge_fakturiert
     ELSE 0
     END AS menge_fakturiert,
     CASE
     WHEN V01.menge_fakturiert < 0
     THEN V01.menge_fakturiert
     ELSE 0
     END AS menge_fakturiert_ret,
     CASE
     WHEN V01.zwsum_3_betrag > 0
     THEN V01.zwsum_3_betrag
     ELSE 0
     END AS md_faktura_ek_n,
     CASE
     WHEN V01.zwsum_3_betrag < 0
     THEN V01.zwsum_3_betrag
     ELSE 0
     END AS md_faktura_ek_n_ret,
    SUBSTR(CASE
      WHEN V06.posten_id NOT IN ('PN', 'PF', 'SP')
      THEN 'SO'
      ELSE 'PN'
      END, 1, 2) AS posten_kz_per
   FROM kfl_production_dbp_view.v_besch_faktura_medata_1 AS V01
    INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.faktura_markt = V02.wup_id AND V01.mandant_id = V02.mandant_id
      
    INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
         AND V01.dat_faktura BETWEEN V03.dat_von AND V03.dat_bis AND V01.wup_id = V03.wup_id
    INNER JOIN kfl_production_dbp_view.v_art_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
    INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS V05 ON V04.mwst_id = V05.mwst_id AND V04.mandant_id = V05.mandant_id
        AND V01.dat_faktura BETWEEN V05.dat_von AND V05.dat_bis
    LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS V06 ON V01.art_id = V06.art_id AND V01.mandant_id = V06.mandant_id
     AND V01.dat_faktura BETWEEN DATE_SUB(V06.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V06.dat_bis, INTERVAL 1 DAY))
   WHERE V01.mandant_id = 1) AS DE_WE_Markt
GROUP BY mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 gp_id,
 posten_kz_per;