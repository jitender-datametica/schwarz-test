CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_besch_faktura_det (art_id, mandant_id, vz_nb_id, vz_wup_id
, dat_faktura, faktura_typ_id, wup_id, nb_id, gp_id, posten_kz_per, retoure_fg, bestellart_id, faktura_beleg_id,
faktura_menge_bme, faktura_menge_kolli, faktura_wert_ek_netto, faktura_wert_ek_brutto, faktura_zekp_ek_netto_bnk,
faktura_zekp_ek_mep, faktura_zekp_ek_mepolk) AS SELECT V01.art_id,
 V01.mandant_id,
 V01.nb_id AS vz_nb_id,
 V01.wup_id AS vz_wup_id,
 V01.dat_faktura,
 V02.faktura_typ_id,
 V03.wup_id,
 V03.nb_id,
 V09.gp_id,
 SUBSTR(CASE
   WHEN V10.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'S')
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS retoure_fg,
 V01.bestellart_id,
 V01.faktura_beleg_id,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'N')
   THEN V01.menge_faktura_bme * - 1
   ELSE V01.menge_faktura_bme
   END AS NUMERIC) AS faktura_menge_bme,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'N')
   THEN V01.menge_faktura_kolli * - 1
   ELSE V01.menge_faktura_kolli
   END AS NUMERIC) AS faktura_menge_kolli,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * - 1
    ELSE V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag
    END AS NUMERIC), 2) AS faktura_wert_ek_netto,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * ROUND(CAST(V01.mwst / 100 + 1 AS BIGNUMERIC),
       5) * - 1
    ELSE (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * ROUND(CAST(V01.mwst / 100 + 1 AS BIGNUMERIC),
      5)
    END AS NUMERIC), 2) AS faktura_wert_ek_brutto,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN V01.ek_netto_bnk * - 1
    ELSE V01.ek_netto_bnk
    END AS NUMERIC), 2) AS faktura_zekp_ek_netto_bnk,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN V01.ek_mep * - 1
    ELSE V01.ek_mep
    END AS NUMERIC), 2) AS faktura_zekp_ek_mep,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.ek_mep - V01.zwsum_6_betrag) * - 1
    ELSE V01.ek_mep - V01.zwsum_6_betrag
    END AS NUMERIC), 2) AS faktura_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_det AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_faktura AS V02 ON V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
      = V02.mandant_id AND V01.dat_faktura_sap = V02.dat_faktura_sap AND V02.auftraggeber_id BETWEEN '0000001000' AND
   '0000009999'
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON ROUND(SAFE_CAST(V02.auftraggeber_id AS BIGNUMERIC), 0) = V03.wup_id
  AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
     AND CURRENT_DATE BETWEEN V05.dat_von AND V05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per AS V06 ON V05.wg_id = V06.wg_id AND V05.mandant_id = V06.mandant_id AND
   CURRENT_DATE BETWEEN V06.dat_von AND V06.dat_bis
 INNER JOIN kfl_production_dbp_view.v_owg_per AS V07 ON V06.owg_id = V07.owg_id AND V06.mandant_id = V07.mandant_id AND
   CURRENT_DATE BETWEEN V07.dat_von AND V07.dat_bis
 INNER JOIN kfl_production_dbp_view.v_hwg_per AS V08 ON V07.hwg_id = V08.hwg_id AND V07.mandant_id = V08.mandant_id AND
   CURRENT_DATE BETWEEN V08.dat_von AND V08.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS V09 ON V01.art_id = V09.art_id AND V01.mandant_id = V09.mandant_id
      AND V01.dat_faktura BETWEEN V09.dat_von AND V09.dat_bis AND V08.hwg_id <> 64
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V10 ON V01.art_id = V10.art_id AND V01.mandant_id = V10.mandant_id AND
   V01.dat_faktura BETWEEN DATE_SUB(V10.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V10.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1
 AND V01.nb_id <> 99
 AND V02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
UNION ALL
SELECT V01.art_id,
 V01.mandant_id,
 V01.nb_id AS vz_nb_id,
 V01.wup_id AS vz_wup_id,
 V01.dat_preisfindung AS dat_faktura,
 V02.faktura_typ_id,
 V03.wup_id,
 V03.nb_id,
 V09.gp_id,
 SUBSTR(CASE
   WHEN V10.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'S')
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS retoure_fg,
 V01.bestellart_id,
 V01.faktura_beleg_id,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'N')
   THEN V01.menge_faktura_bme * - 1
   ELSE V01.menge_faktura_bme
   END AS NUMERIC) AS faktura_menge_bme,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O', 'N')
   THEN V01.menge_faktura_kolli * - 1
   ELSE V01.menge_faktura_kolli
   END AS NUMERIC) AS faktura_menge_kolli,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * - 1
    ELSE V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag
    END AS NUMERIC), 2) AS faktura_wert_ek_netto,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * ROUND(CAST(V01.mwst / 100 + 1 AS BIGNUMERIC),
       5) * - 1
    ELSE (V01.zwsum_3_betrag - V01.zwsum_4_betrag - V01.zwsum_9_betrag) * ROUND(CAST(V01.mwst / 100 + 1 AS BIGNUMERIC),
      5)
    END AS NUMERIC), 2) AS faktura_wert_ek_brutto,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN V01.ek_netto_bnk * - 1
    ELSE V01.ek_netto_bnk
    END AS NUMERIC), 2) AS faktura_zekp_ek_netto_bnk,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN V01.ek_mep * - 1
    ELSE V01.ek_mep
    END AS NUMERIC), 2) AS faktura_zekp_ek_mep,
 ROUND(CAST(CASE
    WHEN V02.faktura_typ_id IN ('O', 'N')
    THEN (V01.ek_mep - V01.zwsum_6_betrag) * - 1
    ELSE V01.ek_mep - V01.zwsum_6_betrag
    END AS NUMERIC), 2) AS faktura_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_det AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_faktura AS V02 ON V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
      = V02.mandant_id AND V01.dat_faktura_sap = V02.dat_faktura_sap AND V02.auftraggeber_id BETWEEN '0000001000' AND
   '0000009999'
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON ROUND(SAFE_CAST(V02.auftraggeber_id AS BIGNUMERIC), 0) = V03.wup_id
  AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
     AND CURRENT_DATE BETWEEN V05.dat_von AND V05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per AS V06 ON V05.wg_id = V06.wg_id AND V05.mandant_id = V06.mandant_id AND
   CURRENT_DATE BETWEEN V06.dat_von AND V06.dat_bis
 INNER JOIN kfl_production_dbp_view.v_owg_per AS V07 ON V06.owg_id = V07.owg_id AND V06.mandant_id = V07.mandant_id AND
   CURRENT_DATE BETWEEN V07.dat_von AND V07.dat_bis
 INNER JOIN kfl_production_dbp_view.v_hwg_per AS V08 ON V07.hwg_id = V08.hwg_id AND V07.mandant_id = V08.mandant_id AND
   CURRENT_DATE BETWEEN V08.dat_von AND V08.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS V09 ON V01.art_id = V09.art_id AND V01.mandant_id = V09.mandant_id
      AND V01.dat_preisfindung BETWEEN V09.dat_von AND V09.dat_bis AND V08.hwg_id = 64
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V10 ON V01.art_id = V10.art_id AND V01.mandant_id = V10.mandant_id AND
   V01.dat_faktura BETWEEN DATE_SUB(V10.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V10.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1
 AND V01.nb_id <> 99
 AND V02.fakturaart_id NOT IN ('ZIWU', 'ZIWV');