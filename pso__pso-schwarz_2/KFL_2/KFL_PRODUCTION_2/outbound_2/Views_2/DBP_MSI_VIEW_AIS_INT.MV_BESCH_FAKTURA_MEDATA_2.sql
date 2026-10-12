CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_besch_faktura_medata_2 (art_id, dat_faktura, wup_id, nb_id,
mandant_id, menge_fakturiert, vz_wup_id, vz_nb_id, gp_id, posten_kz_per, md_faktura_ek_n, md_ek_netto_bnk,
md_zekp_ek_brutto, md_zekp_ek_mep, md_zekp_ek_mepolk) AS SELECT V01.art_id,
 V01.dat_faktura,
 V02.wup_id,
 V02.nb_id,
 V01.mandant_id,
 V01.menge_fakturiert,
 V01.wup_id AS vz_wup_id,
 V01.nb_id AS vz_nb_id,
 V03.gp_id,
 SUBSTR(CASE
   WHEN V06.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 V01.zwsum_3_betrag AS md_faktura_ek_n,
 V01.ek_netto_bnk AS md_ek_netto_bnk,
  V01.zwsum_3_betrag * ROUND(CAST((100 + V05.mwst) / 100 AS BIGNUMERIC), 5) AS md_zekp_ek_brutto,
 V01.ek_mep AS md_zekp_ek_mep,
  V01.ek_mep - V01.logistikkostenzuschlag AS md_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_medata_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.faktura_markt = V02.wup_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_2 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
     AND V01.dat_faktura BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V05 ON V04.mwst_id = V05.mwst_id AND V04.mandant_id = V05.mandant_id
  AND V01.dat_faktura BETWEEN V05.dat_von AND V05.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS V06 ON V01.art_id = V06.art_id AND V01.mandant_id = V06.mandant_id AND
   V01.dat_faktura BETWEEN DATE_SUB(V06.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V06.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1;