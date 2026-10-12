CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_konzessionaer_produktiv AS SELECT kmvk.mandant_id,
 kmvk.mietvertrag_id,
 kmvk.immo_objekt_id,
 kmvk.konzessionaer_id,
 MIN(kmvk.kjmo) AS kjmo_min,
 MAX(kmvk.kjmo) AS kjmo_max,
 COUNT(kmvk.kjmo_lfd) AS kjmo_anzahl,
 MAX(kmvk.flaeche_groesse) AS konz_flaeche_groesse,
 IFNULL(SUM(kmvk.anzahl_kunden), 0) AS konz_anzahl_kunden,
 SUM(kmvk.miete_betrag * KURS.kurs) AS konz_grundmiete,
 SUM(kmvk.konz_umsatz * KURS.kurs) AS konz_umsatz_agg,
 AVG(kmvk.konz_umsatz * KURS.kurs) AS konz_umsatz_monat,
  AVG(kmvk.konz_umsatz * KURS.kurs) * 12 AS konz_umsatz_jahr,
 TRUNC(CAST(SUM(kmvk.miete_betrag * KURS.kurs) / NULLIF(SUM(kmvk.konz_umsatz * KURS.kurs), 0) AS BIGNUMERIC)) AS
 konz_miete_proz,
 TRUNC(AVG(kmvk.konz_umsatz * KURS.kurs) * 12 / NULLIF(MAX(kmvk.flaeche_groesse), 0)) AS konz_produktivitaet,
 IFNULL(TRUNC(CAST(SUM(kmvk.konz_umsatz * KURS.kurs) / NULLIF(IFNULL(SUM(kmvk.anzahl_kunden), 0), 0) AS BIGNUMERIC)), 0
  ) AS konz_umsatz_kunde,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM (SELECT kum.mandant_id,
   kum.mietvertrag_id,
   kum.immo_objekt_id,
   kum.konzessionaer_id,
   kum.kjmo,
   kum.kjmo_lfd,
   ZEIT.max_dat,
   SUM(mvf.miete_betrag) AS miete_betrag,
   SUM(fl.flaeche_groesse) AS flaeche_groesse,
   COUNT(fl.flaeche_id) AS flaeche_anzahl,
   TRUNC(CAST(SUM(wc.anzahl_kunden) / COUNT(fl.flaeche_id) AS BIGNUMERIC)) AS anzahl_kunden,
   TRUNC(CAST(SUM(kum.konz_umsatz) / COUNT(fl.flaeche_id) AS BIGNUMERIC)) AS konz_umsatz
  FROM kfl_production_dbp_view.v_monat AS ZEIT
   INNER JOIN (SELECT KUM00.mandant_id,
     KUM00.mietvertrag_id,
     KUM00.immo_objekt_id,
     KUM00.konzessionaer_id,
     KUM00.kjmo,
     CAST(RANK() OVER (PARTITION BY CAST(KUM00.mandant_id AS STRING), KUM00.konzessionaer_id, KUM00.mietvertrag_id,
         KUM00.immo_objekt_id ORDER BY KUM00.kjmo IS NULL, KUM00.kjmo) AS BIGNUMERIC) AS kjmo_lfd,
     KUM00.betrag_umsatz AS konz_umsatz
    FROM kfl_production_dbp_view.v_ivs_konzessionaer_umsatz AS KUM00
     INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker AS KER ON KUM00.kjmo = KER.kj_ker_mo_id AND KUM00.kjmo <=
       KER.buchungs_schluss_akt
    WHERE KUM00.betrag_umsatz BETWEEN 0.01 AND 999999999
    QUALIFY CAST(RANK() OVER (PARTITION BY CAST(KUM00.mandant_id AS STRING), KUM00.konzessionaer_id, KUM00.mietvertrag_id
          , KUM00.immo_objekt_id ORDER BY KUM00.kjmo IS NULL, KUM00.kjmo) AS BIGNUMERIC) BETWEEN 1 AND 12) AS kum ON
    ZEIT.kjmo = kum.kjmo
   LEFT JOIN (SELECT mandant_id,
     mietvertrag_id,
     konzessionaer_id,
     dat_vertrag_beginn,
     dat_vertrag_ende,
     dat_bis,
     dat_von
    FROM kfl_production_dbp_view.v_ivs_mietvertrag_per AS MV00) AS mv ON kum.mandant_id = mv.mandant_id AND kum.mietvertrag_id
         = mv.mietvertrag_id AND kum.konzessionaer_id = mv.konzessionaer_id AND ZEIT.max_dat BETWEEN mv.dat_von AND mv.dat_bis
       AND ZEIT.max_dat BETWEEN mv.dat_vertrag_beginn AND mv.dat_vertrag_ende
   INNER JOIN (SELECT mandant_id,
     mietvertrag_id,
     flaeche_id,
     immo_objekt_id,
     NULLIF(dat_flaeche_uebergabe, DATE '1900-01-01') AS dat_flaeche_uebergabe,
     dat_flaeche_rueckgabe,
     miete_betrag,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per
    WHERE miete_betrag BETWEEN 0.01 AND 999999999) AS mvf ON mv.mandant_id = mvf.mandant_id AND mv.mietvertrag_id = mvf
        .mietvertrag_id AND kum.immo_objekt_id = mvf.immo_objekt_id AND ZEIT.max_dat BETWEEN mvf.dat_von AND mvf.dat_bis
       AND ZEIT.max_dat BETWEEN mvf.dat_flaeche_uebergabe AND mvf.dat_flaeche_rueckgabe
   INNER JOIN (SELECT mandant_id,
     immo_objekt_id,
     immo_objekt_bez,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ivs_immo_objekt_per AS IOP) AS iop ON mvf.mandant_id = iop.mandant_id AND mvf.immo_objekt_id
       = iop.immo_objekt_id AND ZEIT.max_dat BETWEEN iop.dat_von AND iop.dat_bis
   INNER JOIN (SELECT mandant_id,
     immo_objekt_id,
     flaeche_id,
     dat_existiert_seit,
     dat_existiert_bis,
     flaeche_groesse,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ivs_flaeche_per AS FL0) AS fl ON mvf.mandant_id = fl.mandant_id AND mvf.flaeche_id =
        fl.flaeche_id AND kum.immo_objekt_id = fl.immo_objekt_id AND ZEIT.max_dat BETWEEN fl.dat_von AND fl.dat_bis AND
     ZEIT.max_dat BETWEEN fl.dat_existiert_seit AND fl.dat_existiert_bis
   LEFT JOIN (SELECT mandant_id,
     wup_id,
     kjmo,
     anzahl_oeff_tage,
     bonanzahl AS anzahl_kunden
    FROM kfl_production_dbp_view.v_wupcal_mo_sum AS WC0
    WHERE nb_id = 0) AS wc ON kum.mandant_id = wc.mandant_id AND iop.immo_objekt_bez = wc.wup_id AND kum.kjmo = wc.kjmo
  GROUP BY kum.mandant_id,
   kum.mietvertrag_id,
   kum.immo_objekt_id,
   kum.konzessionaer_id,
   kum.kjmo,
   kum.kjmo_lfd,
   ZEIT.max_dat) AS kmvk
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON kmvk.mandant_id = KURS.mandant_id AND
   kmvk.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis
GROUP BY kmvk.mandant_id,
 kmvk.mietvertrag_id,
 kmvk.immo_objekt_id,
 kmvk.konzessionaer_id,
 KURS.wrg_id,
 KURS.wrg_typ_id;