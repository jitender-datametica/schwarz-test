CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_besch_faktura_det (mandant_id, nb_id, wup_id, dat, vz_nb_id,
vz_wup_id, art_id, dat_faktura, faktura_typ_id, gp_id, menge_faktura_bme, menge_faktura_kolli, faktura_menge_bme,
faktura_menge_bme_ret) AS SELECT V01.mandant_id,
 V03.nb_id,
 V03.aktuell_wup_id AS wup_id,
 V01.dat_faktura AS dat,
 V01.nb_id AS vz_nb_id,
 V01.wup_id AS vz_wup_id,
 V01.art_id,
 V01.dat_faktura,
 V02.faktura_typ_id,
 V04.gp_id,
 V01.menge_faktura_bme,
 V01.menge_faktura_kolli,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('N')
   THEN V01.menge_faktura_bme * - 1
   WHEN V02.faktura_typ_id NOT IN ('O', 'S')
   THEN V01.menge_faktura_bme
   ELSE 0
   END AS NUMERIC) AS faktura_menge_bme,
 CAST(CASE
   WHEN V02.faktura_typ_id IN ('O')
   THEN V01.menge_faktura_bme * - 1
   WHEN V02.faktura_typ_id IN ('S')
   THEN V01.menge_faktura_bme
   ELSE 0
   END AS NUMERIC) AS faktura_menge_bme_ret
FROM kfl_production_dbp_view.v_besch_faktura_det AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_faktura AS V02 ON V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
       = V02.mandant_id AND V01.dat_faktura_sap = V02.dat_faktura_sap AND V02.auftraggeber_id BETWEEN '0000001000' AND
    '0000009999' AND V02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON ROUND(SAFE_CAST(V02.auftraggeber_id AS BIGNUMERIC), 0) = V03.wup_id
   AND V01.mandant_id = V03.mandant_id AND V03.nb_id = 0
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
     AND V01.dat_faktura BETWEEN V04.dat_von AND V04.dat_bis
WHERE V01.mandant_id = 1
 AND V01.nb_id <> 99;