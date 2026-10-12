CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_f_umbewertung_det_1 (mandant_id, pae_beleg_id, kj,
pae_beleg_pos_id, gjmo, periodenart_id, dat_buch, menge_bestand_bme_alt, wert_bestand, wert_bestand_s_preis,
wert_bestand_alt, wert_bestand_s_preis_alt, gld_alt, standard_preis_alt, gld_neu, standard_preis_neu, preis_steuer_kz,
preis_faktor, wrg_id, art_id, bwkey, nb_id) AS SELECT V01.mandant_id,
 CAST(V01.pae_beleg_id AS NUMERIC) AS pae_beleg_id,
 V01.kj,
 V01.pae_beleg_pos_id,
 V01.gjmo,
 V01.periodenart_id,
 V01.dat_buch,
 V01.menge_bestand_bme_alt,
 TRUNC(CAST(COALESCE(v02.wert_bestand / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS wert_bestand,
 TRUNC(CAST(COALESCE(v02.wert_bestand_s_preis / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS wert_bestand_s_preis,
 TRUNC(CAST(COALESCE(v02.wert_bestand_alt / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS wert_bestand_alt,
 TRUNC(CAST(COALESCE(v02.wert_bestand_s_preis_alt / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS
 wert_bestand_s_preis_alt,
 TRUNC(CAST(COALESCE(v02.gld_alt / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS gld_alt,
 TRUNC(CAST(COALESCE(v02.standard_preis_alt / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS standard_preis_alt,
 TRUNC(CAST(COALESCE(v02.gld_neu / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS gld_neu,
 TRUNC(CAST(COALESCE(v02.standard_preis_neu / v02.preis_faktor_tmp, 0) AS BIGNUMERIC), 4) AS standard_preis_neu,
 v02.preis_steuer_kz,
 v02.preis_faktor,
 v02.wrg_id,
 V03.art_id,
 V03.bewertungskreis_id AS bwkey,
 V04.nb_id
FROM kfl_production_dbp_view.v_umbewertung_periode_1 AS V01
 FULL JOIN (SELECT mandant_id,
   pae_beleg_id,
   kj,
   pae_beleg_pos_id,
   gjmo,
   wrg_bewertung_typ_id,
   wert_bestand,
   wert_bestand_alt,
   wert_bestand_s_preis,
   wert_bestand_s_preis_alt,
   gld_alt,
   standard_preis_alt,
   gld_neu,
   standard_preis_neu,
   preis_steuer_kz,
   preis_faktor,
    CASE
    WHEN preis_faktor = 0
    THEN NULL
    ELSE preis_faktor
    END AS preis_faktor_tmp,
   wrg_id
  FROM kfl_production_dbp_view.v_umbewertung_werte_1
  WHERE CAST(wrg_bewertung_typ_id AS FLOAT64) = 10) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.pae_beleg_id = v02
      .pae_beleg_id AND V01.kj = v02.kj AND V01.pae_beleg_pos_id = v02.pae_beleg_pos_id AND V01.gjmo = v02.gjmo
 INNER JOIN kfl_production_dbp_view.v_umbewertung_det_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.pae_beleg_id =
     V03.pae_beleg_id AND V01.kj = V03.kj AND V01.pae_beleg_pos_id = V03.pae_beleg_pos_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V04 ON V03.mandant_id = V04.mandant_id AND CAST(V03.bewertungskreis_id AS FLOAT64)
   = V04.wup_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V05 ON V03.art_id = V05.art_id AND V03.mandant_id = V05.mandant_id
          AND (V05.mandant_id NOT IN (1, 7) OR V05.mandant_id IN (1, 7) AND TRIM(CAST(V05.wg_id AS STRING FORMAT '000')
             ) || TRIM(CAST(V05.wug_id AS STRING FORMAT '000')) <> '969006') AND (V05.mandant_id <> 7 OR V05.mandant_id
          = 7 AND TRIM(CAST(V05.wg_id AS STRING FORMAT '000')) <> '980') AND V05.wg_id <> 961 AND (V05.mandant_id NOT IN
        (2, 3, 4, 5, 6, 7, 8) OR V05.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V05.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V05.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V05.arthiertyp_id
     = 2 AND V05.dat_bis = DATE '9999-12-31';