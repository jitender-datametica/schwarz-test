CREATE OR REPLACE VIEW dbp_msi_view_immo_materialized.mv_immo_mietvertrag_umsatz_zu_hilf12_2 (mandant_id, mv_intreno,
we_intreno, mo_intreno, kjmo, wrg_id, wrg_typ_id, count_kjmo) AS -- active contracts in national currency

-- old contracts in national currency
 -- active contracts in EUR
 -- old contracts in EUR
 SELECT mandant_id,
 mv_intreno,
 we_intreno,
 mo_intreno,
 kjmo,
 wrg_id,
 wrg_typ_id,
 COUNT(mietvertrag_nr) AS count_kjmo
FROM (SELECT DISTINCT -- v1.branche_id
 V1.mandant_id,
    V1.mietvertrag_nr,
    V9.we_intreno_akt AS we_intreno,
    V9.mv_intreno_akt AS mv_intreno,
    V9.mo_intreno_akt AS mo_intreno,
    V2.kjmo,
    V2.rhythmus_art,
    V2.version,
    V2.wrg_id,
    V6.wrg_typ_id,
    V8.kj,
    V8.akt_kj,
    V8.akt_mo
   FROM dbp_msi_view_immo_materialized.mv_l_mietvertrag_umsatz_konz_hilf_2 AS V1
    INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V2 ON V1.mv_intreno = V2.mv_intreno
     AND V1.mandant_id = V2.mandant_id
    INNER JOIN dbp_msi_view_immo_materialized.mv_mandant_wrg_typ_zu_2 AS V6 ON V1.mandant_id = V6.mandant_id AND V2.wrg_id
        = V6.wrg_id AND V6.wrg_typ_id = 1
    INNER JOIN dbp_msi_view_immo_materialized.mv_l_kj_monat_2 AS V8 ON V2.kjmo = V8.kjmo
    INNER JOIN dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno_zu_hilf_2 AS V9 ON V1.mietvertrag_nr = V9.mietvertrag_nr
       AND V1.mandant_id = V9.mandant_id
   WHERE V2.version = (SELECT MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V11
      WHERE V2.mv_intreno = mv_intreno
       AND V2.kjmo = kjmo
       AND V2.melderegel = melderegel)
    AND V2.nullumsatz <> 'X'
    AND V2.umsatz_netto > 0
    AND V2.mv_intreno = V9.mv_intreno_akt
    AND V9.mandant_id = V2.mandant_id
    AND V2.rhythmus_art = '0001'
   UNION ALL
   SELECT DISTINCT -- v1.branche_id
 V10.mandant_id,
    V10.mietvertrag_nr,
    V90.we_intreno_akt AS we_intreno,
    V90.mv_intreno_akt AS mv_intreno,
    V90.mo_intreno_akt AS mo_intreno,
    V20.kjmo,
    V20.rhythmus_art,
    V20.version,
    V20.wrg_id,
    V60.wrg_typ_id,
    V80.kj,
    V80.akt_kj,
    V80.akt_mo
   FROM dbp_msi_view_immo_materialized.mv_l_mietvertrag_umsatz_konz_hilf_2 AS V10
    INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V20 ON V10.mv_intreno = V20.mv_intreno
       AND V10.mandant_id = V20.mandant_id
    INNER JOIN dbp_msi_view_immo_materialized.mv_mandant_wrg_typ_zu_2 AS V60 ON V10.mandant_id = V60.mandant_id AND V20.wrg_id
        = V60.wrg_id AND V60.wrg_typ_id = 1
    INNER JOIN dbp_msi_view_immo_materialized.mv_l_kj_monat_2 AS V80 ON V20.kjmo = V80.kjmo
    INNER JOIN dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno_zu_hilf_2 AS V90 ON V10.mietvertrag_nr = V90.mietvertrag_nr
       AND V10.mandant_id = V90.mandant_id
   WHERE V20.version = (SELECT MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V11
      WHERE V20.mv_intreno = mv_intreno
       AND V20.kjmo = kjmo
       AND V20.melderegel = melderegel)
    AND V20.nullumsatz <> 'X'
    AND V20.umsatz_netto > 0
     -- and v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id and v2.rhythmus_art='0001'

   UNION ALL
   SELECT DISTINCT -- v1.branche_id
 V12.mandant_id,
    V12.mietvertrag_nr,
    V91.we_intreno_akt AS we_intreno,
    V91.mv_intreno_akt AS mv_intreno,
    V91.mo_intreno_akt AS mo_intreno,
    V21.kjmo,
    V21.rhythmus_art,
    V21.version,
    'EUR' AS wrg_id,
    0 AS wrg_typ_id,
    V81.kj,
    V81.akt_kj,
    V81.akt_mo
   FROM dbp_msi_view_immo_materialized.mv_l_mietvertrag_umsatz_konz_hilf_2 AS V12
    INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V21 ON V12.mv_intreno = V21.mv_intreno
       AND V12.mandant_id = V21.mandant_id
    INNER JOIN dbp_msi_view_immo_materialized.mv_mandant_wrg_typ_zu_2 AS V61 ON V12.mandant_id = V61.mandant_id AND V21.wrg_id
        = V61.wrg_id AND V61.wrg_typ_id = 1
    INNER JOIN dbp_msi_view_immo_materialized.mv_l_kj_monat_2 AS V81 ON V21.kjmo = V81.kjmo
    INNER JOIN dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno_zu_hilf_2 AS V91 ON V12.mietvertrag_nr = V91.mietvertrag_nr
       AND V12.mandant_id = V91.mandant_id
   WHERE V21.version = (SELECT MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V11
      WHERE V21.mv_intreno = mv_intreno
       AND V21.kjmo = kjmo
       AND V21.melderegel = melderegel)
    AND V21.nullumsatz <> 'X'
    AND V21.umsatz_netto > 0
    AND V21.mv_intreno = V91.mv_intreno_akt
    AND V91.mandant_id = V21.mandant_id
    AND V21.rhythmus_art = '0001'
   UNION ALL
   SELECT DISTINCT -- v1.branche_id
 V13.mandant_id,
    V13.mietvertrag_nr,
    V92.we_intreno_akt AS we_intreno,
    V92.mv_intreno_akt AS mv_intreno,
    V92.mo_intreno_akt AS mo_intreno,
    V22.kjmo,
    V22.rhythmus_art,
    V22.version,
    'EUR' AS wrg_id,
    0 AS wrg_typ_id,
    V82.kj,
    V82.akt_kj,
    V82.akt_mo
   FROM dbp_msi_view_immo_materialized.mv_l_mietvertrag_umsatz_konz_hilf_2 AS V13
    INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V22 ON V13.mv_intreno = V22.mv_intreno
       AND V13.mandant_id = V22.mandant_id
    INNER JOIN dbp_msi_view_immo_materialized.mv_mandant_wrg_typ_zu_2 AS V62 ON V13.mandant_id = V62.mandant_id AND V22.wrg_id
        = V62.wrg_id AND V62.wrg_typ_id = 1
    INNER JOIN dbp_msi_view_immo_materialized.mv_l_kj_monat_2 AS V82 ON V22.kjmo = V82.kjmo
    INNER JOIN dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno_zu_hilf_2 AS V92 ON V13.mietvertrag_nr = V92.mietvertrag_nr
       AND V13.mandant_id = V92.mandant_id
   WHERE V22.version = (SELECT MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS V11
      WHERE V22.mv_intreno = mv_intreno
       AND V22.kjmo = kjmo
       AND V22.melderegel = melderegel)
    AND V22.nullumsatz <> 'X'
    AND V22.umsatz_netto > 0
     -- and v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id and v2.rhythmus_art='0001'

     /* UNION ALL

   --active empty contracts
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id
   ,v1.mietvertrag_nr
   ,v9.we_intreno_akt as we_intreno
   ,v9.mv_intreno_akt as mv_intreno
   ,v9.mo_intreno_akt as mo_intreno
   --,v1.partner_id
   --,v1.partner_id as konzessionaer_id
   --,v1.vertragsart_id
   ,v2.kjmo
   --,v2.melderegel
   ,v2.rhythmus_art
   --,v2.umsatz_brutto
   --,v2.umsatz_netto
   --,v2.umsatzkennung
   ,v2.version
   ,v2.wrg_id
   ,v6.wrg_typ_id
   --,v5.objektleiter_id
   , v8.kj
   ,v8.akt_kj
   ,v8.akt_mo


   FROM KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_per_2 AS v1
   left JOIN KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   JOIN KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_mo_zu_per_2 v3
   ON v1.mv_intreno = v3.mv_intreno AND v1.mandant_id = v3.mandant_id
   JOIN KFL_PRODUCTION.dbp_view.v_immo_mietobjekt_2 v4
   ON v3.mandant_id = v4.mandant_id AND v3.mo_intreno = v4.mo_intreno
   --LEFT JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_l_wirtschaftseinheit_2 v5
   --ON v4.we_intreno = v5.we_intreno and v4.mandant_id=v5.mandant_id
   left  JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_mandant_wrg_typ_zu_2 v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id --and v6.wrg_typ_id = 1
   left  JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_l_kj_monat_2 v8
   ON v2.kjmo = v8.kjmo
   join KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_immo_mietvertrag_intreno_2 as v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id

   where v2.mv_intreno is null
   and v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id and v2.rhythmus_art='0001'

   UNION ALL

   --old empty contracts
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id
   ,v1.mietvertrag_nr
   ,v9.we_intreno_akt as we_intreno
   ,v9.mv_intreno_akt as mv_intreno
   ,v9.mo_intreno_akt as mo_intreno
   --,v1.partner_id
   --,v1.partner_id as konzessionaer_id
   --,v1.vertragsart_id
   ,v2.kjmo
   --,v2.melderegel
   ,v2.rhythmus_art
   --,v2.umsatz_brutto
   --,v2.umsatz_netto
   --,v2.umsatzkennung
   ,v2.version
   ,v2.wrg_id
   ,v6.wrg_typ_id
   --,v5.objektleiter_id
   , v8.kj
   ,v8.akt_kj
   ,v8.akt_mo


   FROM KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_per_2 AS v1
   left JOIN KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   JOIN KFL_PRODUCTION.dbp_view.v_immo_mietvertrag_mo_zu_per_2 v3
   ON v1.mv_intreno = v3.mv_intreno AND v1.mandant_id = v3.mandant_id
   JOIN KFL_PRODUCTION.dbp_view.v_immo_mietobjekt_2 v4
   ON v3.mandant_id = v4.mandant_id AND v3.mo_intreno = v4.mo_intreno
   --LEFT JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_l_wirtschaftseinheit_2 v5
   --ON v4.we_intreno = v5.we_intreno and v4.mandant_id=v5.mandant_id
   left  JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_mandant_wrg_typ_zu_2 v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id --and v6.wrg_typ_id = 1
   left  JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_l_kj_monat_2 v8
   ON v2.kjmo = v8.kjmo
   join KFL_PRODUCTION.DBP_MSI_VIEW_IMMO_MATERIALIZED.mv_immo_mietvertrag_intreno_2 as v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id

   where v2.mv_intreno is null
   --and v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id and v2.rhythmus_art='0001' */
     ) AS v18
WHERE rhythmus_art = '0001'
GROUP BY mandant_id,
 mv_intreno,
 we_intreno,
 mo_intreno,
 kjmo,
 wrg_id,
 wrg_typ_id;