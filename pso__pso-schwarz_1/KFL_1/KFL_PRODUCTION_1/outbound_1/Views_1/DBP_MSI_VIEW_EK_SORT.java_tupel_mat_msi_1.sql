CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_tupel_mat_msi_1 AS SELECT T1.mandant_id,
 T1.a425_kjmo AS a425,
 T1.a500_kjwo_update AS a500,
 T1.wrg_id AS a424,
 T1.a5_owg_id AS a5,
 T1.a7_wg_id AS a7,
   CASE
   WHEN T1.a7_wg_id < 10
   THEN '00' || CAST(T1.a7_wg_id AS STRING)
   WHEN T1.a7_wg_id < 100
   THEN '0' || CAST(T1.a7_wg_id AS STRING)
   ELSE CAST(T1.a7_wg_id AS STRING)
   END || CASE
   WHEN T1.wug_id < 10
   THEN '00' || CAST(T1.wug_id AS STRING)
   WHEN T1.wug_id < 100
   THEN '0' || CAST(T1.wug_id AS STRING)
   ELSE CAST(T1.wug_id AS STRING)
   END AS a9,
 T1.wug_id,
 T1.matching_id,
  CASE
  WHEN T1.art_id IS NULL
  THEN 'Nielsen'
  ELSE 'Kaufland'
  END AS a1,
 T1.a58_rang_umsatz_owg AS a58,
 T1.a2_rang_umsatz_wg AS a2,
 T1.a59_rang_absatz_wg AS a59,
  CASE
  WHEN T1.art_id IS NULL
  THEN T1.nielsen_gtin
  ELSE T1.kl_art_id
  END AS a11,
 T1.a450_art_nielsen_nr AS a450,
 T1.nielsen_art_bez AS a12_1,
  CASE
  WHEN T1.art_id IS NULL
  THEN T1.nielsen_art_bez
  ELSE T1.art_bez_deutsch
  END AS a14,
  CASE
  WHEN T1.mandant_id = 1
  THEN CASE
   WHEN T1.a14_art_status_de IS NULL
   THEN 'Potenzial'
   WHEN TRIM(T1.a14_art_status_de) = ''
   THEN 'Aktiv'
   ELSE T1.a14_art_status_de
   END
  WHEN T1.mandant_id > 1
  THEN CASE
   WHEN T1.art_id IS NULL
   THEN 'Nielsen'
   ELSE 'Kaufland'
   END
  ELSE NULL
  END AS a15,
  CASE
  WHEN t10.a50_listungsaktion IS NULL OR TRIM(t10.a50_listungsaktion) = ''
  THEN 0
  ELSE 1
  END AS a3,
 COALESCE(T1.a16_akt_lieferant_id, T1.a446_lieferant_bez_latein) AS a16,
 COALESCE(T1.a16_akt_lieferant_id, T1.lieferant_nielsen) AS lieferant_lieferantenwissen,
 T1.a419_hersteller_id AS a419,
 CASE
   WHEN TRIM(a419_hersteller_id) <> '' AND a419_hersteller_id IS NOT NULL
   THEN
     CASE
       WHEN CAST(a419_hersteller_id AS INT) > 0
       THEN TRIM(a419_hersteller_id)
       ELSE TRIM(a16_akt_lieferant_id)
     END
   WHEN (TRIM(a419_hersteller_id) = '' OR a419_hersteller_id IS NULL) AND
        TRIM(a16_akt_lieferant_id) <> '' AND
        a16_akt_lieferant_id IS NOT NULL
   THEN TRIM(a16_akt_lieferant_id)
   ELSE '-9999'
END AS a421,
  CASE
  WHEN T1.a446_lieferant_bez_latein IS NULL
  THEN ''
  ELSE T1.a446_lieferant_bez_latein
  END AS a446,
  CASE
  WHEN T1.a447_hersteller_bez_latein IS NULL
  THEN ''
  ELSE T1.a447_hersteller_bez_latein
  END AS a447,
  CASE
  WHEN T1.mandant_id > 1
  THEN T1.a446_lieferant_bez_latein
  ELSE CASE
   WHEN TRIM(T1.a419_hersteller_id) = ''
   THEN T1.a446_lieferant_bez_latein
   WHEN ROUND(CAST(T1.a419_hersteller_id AS BIGNUMERIC), 0) > 0
   THEN T1.a447_hersteller_bez_latein
   ELSE T1.a446_lieferant_bez_latein
   END
  END AS a448,
 T1.a60_muki_vk_kz AS a60,
 T1.a61_muki_vk_kl_art_id_verkettung AS a61,
 T1.a389_zek_id AS a389,
 T2.zek_name AS a390,
  CASE
  WHEN T1.a391_disc_pe IS NULL OR T1.a391_disc_pe = 0
  THEN NULL
  ELSE TRIM(SUBSTR(CAST(T1.a391_disc_pe AS STRING), 1, 39))
  END AS a391,
  CASE
  WHEN T1.a392_disc_ohne_etikett IS NULL OR T1.a392_disc_ohne_etikett = 0
  THEN NULL
  ELSE TRIM(SUBSTR(CAST(T1.a392_disc_ohne_etikett AS STRING), 1, 39))
  END AS a392,
 CAST(CASE
    WHEN T1.kassenumsatz_af_kl_absolut_netto = 0
    THEN NULL
    ELSE T1.kassenumsatz_af_kl_absolut_netto
    END / CASE
    WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
    THEN NULL
    ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
    END AS NUMERIC) AS a281,
 ROUND(CAST((T1.kassenumsatz_af_kl_absolut_netto / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
         END - T1.kassenumsatz_af_kl_absolut_netto_vj / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
         END) / CASE
      WHEN CASE
         WHEN T1.kassenumsatz_af_kl_absolut_netto_vj = 0
         THEN NULL
         ELSE T1.kassenumsatz_af_kl_absolut_netto_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
         END = 0
      THEN NULL
      ELSE CASE
        WHEN T1.kassenumsatz_af_kl_absolut_netto_vj = 0
        THEN NULL
        ELSE T1.kassenumsatz_af_kl_absolut_netto_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
        END
      END * 100 AS NUMERIC), 1) AS a285,
 CAST(CASE
    WHEN T1.absatz_af_kl = 0
    THEN NULL
    ELSE T1.absatz_af_kl
    END / CASE
    WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
    THEN NULL
    ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
    END AS NUMERIC) AS a19,
 CAST((CASE
        WHEN T1.absatz_af_kl = 0
        THEN NULL
        ELSE T1.absatz_af_kl
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
        END - CASE
       WHEN CASE
          WHEN T1.absatz_af_kl_vj = 0
          THEN NULL
          ELSE T1.absatz_af_kl_vj
          END / CASE
          WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
          THEN NULL
          ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.absatz_af_kl_vj = 0
         THEN NULL
         ELSE T1.absatz_af_kl_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.absatz_af_kl_vj = 0
        THEN NULL
        ELSE T1.absatz_af_kl_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.absatz_af_kl_vj = 0
       THEN NULL
       ELSE T1.absatz_af_kl_vj
       END / CASE
       WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
       THEN NULL
       ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
       END
     END * 100 AS NUMERIC) AS a265,
 ROUND(CAST(T1.a17_absatz_kl AS NUMERIC), 0) AS a17,
 ROUND(CAST(T1.a76_absatz_sst1 AS NUMERIC), 0) AS a76,
 ROUND(CAST(T1.a78_absatz_sst2 AS NUMERIC), 0) AS a78,
 ROUND(CAST(T1.a80_absatz_sst3 AS NUMERIC), 0) AS a80,
 ROUND(CAST(T1.a82_absatz_sst4 AS NUMERIC), 0) AS a82,
 ROUND(CAST(T1.a84_absatz_sst5 AS NUMERIC), 0) AS a84,
 ROUND(CAST(T1.a86_absatz_sst6 AS NUMERIC), 0) AS a86,
 ROUND(CAST(T1.a88_absatz_sst7 AS NUMERIC), 0) AS a88,
 ROUND(CAST(T1.a62_absatz_ksst1 AS NUMERIC), 0) AS a62,
 ROUND(CAST(T1.a64_absatz_ksst2 AS NUMERIC), 0) AS a64,
 ROUND(CAST(T1.a66_absatz_ksst3 AS NUMERIC), 0) AS a66,
 ROUND(CAST(T1.a68_absatz_ksst4 AS NUMERIC), 0) AS a68,
 ROUND(CAST(T1.a70_absatz_ksst5 AS NUMERIC), 0) AS a70,
 ROUND(CAST(T1.a72_absatz_ksst6 AS NUMERIC), 0) AS a72,
 ROUND(CAST(T1.a74_absatz_ksst7 AS NUMERIC), 0) AS a74,
 ROUND(CAST(T1.a90_absatz_ost_basis AS NUMERIC), 0) AS a90,
 ROUND(CAST(T1.a92_absatz_ost_gross AS NUMERIC), 0) AS a92,
 ROUND(CAST(T1.a94_absatz_sued_ost AS NUMERIC), 0) AS a94,
 ROUND(CAST(T1.a96_absatz_sued_west AS NUMERIC), 0) AS a96,
 ROUND(CAST(T1.a98_absatz_west AS NUMERIC), 0) AS a98,
 ROUND(CAST(T1.a100_absatz_nord AS NUMERIC), 0) AS a100,
 CAST(CASE
    WHEN T1.a76_absatz_sst1 = 0
    THEN NULL
    ELSE T1.a76_absatz_sst1
    END / CASE
    WHEN T1.markt_wochen_sst1 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst1
    END AS NUMERIC) AS a77,
 CAST(CASE
    WHEN T1.a78_absatz_sst2 = 0
    THEN NULL
    ELSE T1.a78_absatz_sst2
    END / CASE
    WHEN T1.markt_wochen_sst2 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst2
    END AS NUMERIC) AS a79,
 CAST(CASE
    WHEN T1.a80_absatz_sst3 = 0
    THEN NULL
    ELSE T1.a80_absatz_sst3
    END / CASE
    WHEN T1.markt_wochen_sst3 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst3
    END AS NUMERIC) AS a81,
 CAST(CASE
    WHEN T1.a82_absatz_sst4 = 0
    THEN NULL
    ELSE T1.a82_absatz_sst4
    END / CASE
    WHEN T1.markt_wochen_sst4 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst4
    END AS NUMERIC) AS a83,
 CAST(CASE
    WHEN T1.a84_absatz_sst5 = 0
    THEN NULL
    ELSE T1.a84_absatz_sst5
    END / CASE
    WHEN T1.markt_wochen_sst5 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst5
    END AS NUMERIC) AS a85,
 CAST(CASE
    WHEN T1.a86_absatz_sst6 = 0
    THEN NULL
    ELSE T1.a86_absatz_sst6
    END / CASE
    WHEN T1.markt_wochen_sst6 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst6
    END AS NUMERIC) AS a87,
 CAST(CASE
    WHEN T1.a88_absatz_sst7 = 0
    THEN NULL
    ELSE T1.a88_absatz_sst7
    END / CASE
    WHEN T1.markt_wochen_sst7 = 0
    THEN NULL
    ELSE T1.markt_wochen_sst7
    END AS NUMERIC) AS a89,
 CAST(CASE
    WHEN T1.a62_absatz_ksst1 = 0
    THEN NULL
    ELSE T1.a62_absatz_ksst1
    END / CASE
    WHEN T1.markt_wochen_ksst1 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst1
    END AS NUMERIC) AS a63,
 CAST(CASE
    WHEN T1.a64_absatz_ksst2 = 0
    THEN NULL
    ELSE T1.a64_absatz_ksst2
    END / CASE
    WHEN T1.markt_wochen_ksst2 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst2
    END AS NUMERIC) AS a65,
 CAST(CASE
    WHEN T1.a66_absatz_ksst3 = 0
    THEN NULL
    ELSE T1.a66_absatz_ksst3
    END / CASE
    WHEN T1.markt_wochen_ksst3 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst3
    END AS NUMERIC) AS a67,
 CAST(CASE
    WHEN T1.a68_absatz_ksst4 = 0
    THEN NULL
    ELSE T1.a68_absatz_ksst4
    END / CASE
    WHEN T1.markt_wochen_ksst4 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst4
    END AS NUMERIC) AS a69,
 CAST(CASE
    WHEN T1.a70_absatz_ksst5 = 0
    THEN NULL
    ELSE T1.a70_absatz_ksst5
    END / CASE
    WHEN T1.markt_wochen_ksst5 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst5
    END AS NUMERIC) AS a71,
 CAST(CASE
    WHEN T1.a72_absatz_ksst6 = 0
    THEN NULL
    ELSE T1.a72_absatz_ksst6
    END / CASE
    WHEN T1.markt_wochen_ksst6 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst6
    END AS NUMERIC) AS a73,
 CAST(CASE
    WHEN T1.a74_absatz_ksst7 = 0
    THEN NULL
    ELSE T1.a74_absatz_ksst7
    END / CASE
    WHEN T1.markt_wochen_ksst7 = 0
    THEN NULL
    ELSE T1.markt_wochen_ksst7
    END AS NUMERIC) AS a75,
 CAST(CASE
    WHEN T1.a90_absatz_ost_basis = 0
    THEN NULL
    ELSE T1.a90_absatz_ost_basis
    END / CASE
    WHEN T1.markt_wochen_ost_basis = 0
    THEN NULL
    ELSE T1.markt_wochen_ost_basis
    END AS NUMERIC) AS a91,
 CAST(CASE
    WHEN T1.a92_absatz_ost_gross = 0
    THEN NULL
    ELSE T1.a92_absatz_ost_gross
    END / CASE
    WHEN T1.markt_wochen_ost_gross = 0
    THEN NULL
    ELSE T1.markt_wochen_ost_gross
    END AS NUMERIC) AS a93,
 CAST(CASE
    WHEN T1.a94_absatz_sued_ost = 0
    THEN NULL
    ELSE T1.a94_absatz_sued_ost
    END / CASE
    WHEN T1.markt_wochen_sued_ost = 0
    THEN NULL
    ELSE T1.markt_wochen_sued_ost
    END AS NUMERIC) AS a95,
 CAST(CASE
    WHEN T1.a96_absatz_sued_west = 0
    THEN NULL
    ELSE T1.a96_absatz_sued_west
    END / CASE
    WHEN T1.markt_wochen_sued_west = 0
    THEN NULL
    ELSE T1.markt_wochen_sued_west
    END AS NUMERIC) AS a97,
 CAST(CASE
    WHEN T1.a98_absatz_west = 0
    THEN NULL
    ELSE T1.a98_absatz_west
    END / CASE
    WHEN T1.markt_wochen_west = 0
    THEN NULL
    ELSE T1.markt_wochen_west
    END AS NUMERIC) AS a99,
 CAST(CASE
    WHEN T1.a100_absatz_nord = 0
    THEN NULL
    ELSE T1.a100_absatz_nord
    END / CASE
    WHEN T1.markt_wochen_nord = 0
    THEN NULL
    ELSE T1.markt_wochen_nord
    END AS NUMERIC) AS a101,
 ROUND(CAST(CAST(T1.anzahl_markt_wochen_kombis_abverkauf_mit_listung AS NUMERIC) / CASE
      WHEN T1.anzahl_markt_wochen_kombis_listung = 0
      THEN NULL
      ELSE T1.anzahl_markt_wochen_kombis_listung
      END * 100 AS NUMERIC), 1) AS a360,
 ROUND(CAST(T1.a31_vk_brutto_kl_pk_1 AS NUMERIC), 2) AS a31,
 ROUND(CAST(T1.a333_vk_brutto_kl_pk_2 AS NUMERIC), 2) AS a333,
 ROUND(CAST(T1.a54_vk_brutto_kl_pk_3 AS NUMERIC), 2) AS a54,
 ROUND(CAST(T1.a334_vk_brutto_kl_pk_4 AS NUMERIC), 2) AS a334,
 ROUND(CAST(T1.a432_vk_brutto_kl_pk_5 AS NUMERIC), 2) AS a432,
 ROUND(CAST(T1.a433_vk_brutto_kl_pk_6 AS NUMERIC), 2) AS a433,
 ROUND(CAST(T1.a434_vk_brutto_kl_pk_7 AS NUMERIC), 2) AS a434,
 ROUND(CAST(T1.a435_vk_brutto_kl_pk_8 AS NUMERIC), 2) AS a435,
 ROUND(CAST(T1.a436_vk_brutto_kl_pk_9 AS NUMERIC), 2) AS a436,
 ROUND(CAST(T1.a437_vk_brutto_kl_pk_10 AS NUMERIC), 2) AS a437,
 ROUND(CAST(T1.a30_kb_olk_ek4ndz_stamm AS NUMERIC), 2) AS a30,
 CAST(CASE
     WHEN T1.a31_vk_brutto_kl_pk_1 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a31_vk_brutto_kl_pk_1 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a31_vk_brutto_kl_pk_1 = 0
     THEN NULL
     ELSE T1.a31_vk_brutto_kl_pk_1
     END * 100 AS NUMERIC) AS a335,
 CAST(CASE
     WHEN T1.a333_vk_brutto_kl_pk_2 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a333_vk_brutto_kl_pk_2 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a333_vk_brutto_kl_pk_2 = 0
     THEN NULL
     ELSE T1.a333_vk_brutto_kl_pk_2
     END * 100 AS NUMERIC) AS a438,
 CAST(CASE
     WHEN T1.a54_vk_brutto_kl_pk_3 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a54_vk_brutto_kl_pk_3 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a54_vk_brutto_kl_pk_3 = 0
     THEN NULL
     ELSE T1.a54_vk_brutto_kl_pk_3
     END * 100 AS NUMERIC) AS a336,
 CAST(CASE
     WHEN T1.a334_vk_brutto_kl_pk_4 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a334_vk_brutto_kl_pk_4 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a334_vk_brutto_kl_pk_4 = 0
     THEN NULL
     ELSE T1.a334_vk_brutto_kl_pk_4
     END * 100 AS NUMERIC) AS a337,
 CAST(CASE
     WHEN T1.a432_vk_brutto_kl_pk_5 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a432_vk_brutto_kl_pk_5 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a432_vk_brutto_kl_pk_5 = 0
     THEN NULL
     ELSE T1.a432_vk_brutto_kl_pk_5
     END * 100 AS NUMERIC) AS a439,
 CAST(CASE
     WHEN T1.a433_vk_brutto_kl_pk_6 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a433_vk_brutto_kl_pk_6 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a433_vk_brutto_kl_pk_6 = 0
     THEN NULL
     ELSE T1.a433_vk_brutto_kl_pk_6
     END * 100 AS NUMERIC) AS a440,
 CAST(CASE
     WHEN T1.a434_vk_brutto_kl_pk_7 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a434_vk_brutto_kl_pk_7 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a434_vk_brutto_kl_pk_7 = 0
     THEN NULL
     ELSE T1.a434_vk_brutto_kl_pk_7
     END * 100 AS NUMERIC) AS a441,
 CAST(CASE
     WHEN T1.a435_vk_brutto_kl_pk_8 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a435_vk_brutto_kl_pk_8 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a435_vk_brutto_kl_pk_8 = 0
     THEN NULL
     ELSE T1.a435_vk_brutto_kl_pk_8
     END * 100 AS NUMERIC) AS a338,
 CAST(CASE
     WHEN T1.a436_vk_brutto_kl_pk_9 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a436_vk_brutto_kl_pk_9 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a436_vk_brutto_kl_pk_9 = 0
     THEN NULL
     ELSE T1.a436_vk_brutto_kl_pk_9
     END * 100 AS NUMERIC) AS a442,
 CAST(CASE
     WHEN T1.a437_vk_brutto_kl_pk_10 - T1.a30_kb_olk_ek4ndz_stamm = 0
     THEN NULL
     ELSE T1.a437_vk_brutto_kl_pk_10 - T1.a30_kb_olk_ek4ndz_stamm
     END / CASE
     WHEN T1.a437_vk_brutto_kl_pk_10 = 0
     THEN NULL
     ELSE T1.a437_vk_brutto_kl_pk_10
     END * 100 AS NUMERIC) AS a443,
 ROUND(CAST(T1.a23_rohertrag_ekmep_olk_4n AS NUMERIC), 0) AS a23,
 ROUND(CAST((T1.a21_kassenumsatz_kl_absolut_netto - T1.a23_rohertrag_ekmep_olk_4n) / CASE
     WHEN T1.a17_absatz_kl = 0
     THEN NULL
     ELSE T1.a17_absatz_kl
     END AS NUMERIC), 2) AS a29,
 t10.a51_listung_sst_pflege AS a51,
 t10.a52_listung_k_sst_pflege AS a52,
  CASE
  WHEN t10.a426_ost_basis_pflege = 'X'
  THEN t10.a426_ost_basis_pflege
  ELSE NULL
  END AS a426,
  CASE
  WHEN t10.a427_ost_gross_pflege = 'X'
  THEN t10.a427_ost_gross_pflege
  ELSE NULL
  END AS a427,
  CASE
  WHEN t10.a428_sued_ost_pflege = 'X'
  THEN t10.a428_sued_ost_pflege
  ELSE NULL
  END AS a428,
  CASE
  WHEN t10.a429_sued_west_pflege = 'X'
  THEN t10.a429_sued_west_pflege
  ELSE NULL
  END AS a429,
  CASE
  WHEN t10.a430_west_pflege = 'X'
  THEN t10.a430_west_pflege
  ELSE NULL
  END AS a430,
  CASE
  WHEN t10.a431_nord_pflege = 'X'
  THEN t10.a431_nord_pflege
  ELSE NULL
  END AS a431,
 t10.a50_listungsaktion AS a50,
  CASE
  WHEN t10.a50_listungsaktion = '0'
  THEN 'keine Listungsaktion'
  WHEN t10.a50_listungsaktion = '1'
  THEN 'keine Veränderung'
  WHEN t10.a50_listungsaktion = '2'
  THEN 'nicht möglich'
  WHEN t10.a50_listungsaktion = '3'
  THEN 'SOLL-Listung = IST-Listung'
  WHEN t10.a50_listungsaktion = '4'
  THEN 'Neulistung KL-Artikel_1'
  WHEN t10.a50_listungsaktion = '5'
  THEN 'Einlistung Kauflandartikel'
  WHEN t10.a50_listungsaktion = '6'
  THEN 'Einlistung Potenzialartikel'
  WHEN t10.a50_listungsaktion = '7'
  THEN 'Auslistung'
  WHEN t10.a50_listungsaktion = '8'
  THEN 'Listung erweitern'
  WHEN t10.a50_listungsaktion = '9'
  THEN 'Listung reduzieren'
  WHEN t10.a50_listungsaktion = '10'
  THEN 'Listung erweitern und reduzieren'
  WHEN t10.a50_listungsaktion = '11'
  THEN 'Listung reduzieren und erweitern'
  WHEN t10.a50_listungsaktion = '12'
  THEN 'Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'
  WHEN t10.a50_listungsaktion = '13'
  THEN 'Nielsen Eigenmarke => nicht durch STP, immer gefüllt'
  ELSE NULL
  END AS a50_desc,
 t10.a411_stk_rohertrag_pflege AS a411,
  CASE
  WHEN t10.a415_kannibalisierungsfaktor > 0
  THEN ROUND(CAST(t10.a412_umsatz_brutto_hochrechnung * t10.a415_kannibalisierungsfaktor AS NUMERIC), 0)
  ELSE ROUND(CAST(CAST(t10.a412_umsatz_brutto_hochrechnung AS NUMERIC) AS NUMERIC), 0)
  END AS a412,
  CASE
  WHEN t10.a415_kannibalisierungsfaktor > 0
  THEN ROUND(CAST(t10.a413_absatz_hochrechnung * t10.a415_kannibalisierungsfaktor AS NUMERIC), 0)
  ELSE ROUND(CAST(CAST(t10.a413_absatz_hochrechnung AS NUMERIC) AS NUMERIC), 0)
  END AS a413,
  CASE
  WHEN t10.a415_kannibalisierungsfaktor > 0
  THEN ROUND(CAST(t10.a414_rohertrag_hochrechnung * t10.a415_kannibalisierungsfaktor AS NUMERIC), 0)
  ELSE ROUND(CAST(CAST(t10.a414_rohertrag_hochrechnung AS NUMERIC) AS NUMERIC), 0)
  END AS a414,
 ROUND(CAST(T1.a36_gewichtete_distribution_nielsen AS NUMERIC), 1) AS a36,
 ROUND(CAST(T1.a32_umsatz_anteil_wgi_nielsen AS NUMERIC), 1) AS a32,
 ROUND(CAST(T1.a33_umsatz_anteil_wgi_kumuliert_nielsen AS NUMERIC), 1) AS a33,
 ROUND(CAST(T1.a34_vk_brutto_durchschnitt_nielsen AS NUMERIC), 2) AS a34,
 ROUND(CAST(T1.a35_umsatz_nielsen AS NUMERIC), 0) AS a35,
  CASE
  WHEN T1.mandant_id = 1
  THEN T1.anz_wochen_de_anz_monate_kmo_nielsen
  ELSE NULL
  END AS a378,
  CASE
  WHEN T1.mandant_id > 1
  THEN T1.anz_wochen_de_anz_monate_kmo_nielsen
  ELSE NULL
  END AS a379,
 ROUND(CAST(T1.a376_kl_marktanteil_wg_nielsen AS NUMERIC), 1) AS a376,
 T1.a380_marktanteilbewertung_nielsen AS a380,
 CAST(T1.a377_durchschnitt_anz_maerkte_nielsen AS NUMERIC) AS a377,
 ROUND(CAST(T1.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen AS NUMERIC), 0) AS a383,
 ROUND(CAST(T1.a384_durchschn_preis_einheit_gl_normiert_nielsen AS NUMERIC), 2) AS a384,
 ROUND(CAST(T1.a385_numerische_distribution_nielsen AS NUMERIC), 1) AS a385,
 T1.a386_inhaltsmengen_nielsen AS a386,
 T1.a387_duft_geschmack_nielsen AS a387,
 T1.a388_einheit_nielsen AS a388,
 T1.a381_preislagenverteilung AS a381,
  CASE
  WHEN T1.mandant_id > 1
  THEN T1.a39_listung_sst_mvke
  ELSE CASE
   WHEN T1.a39_listung_sst_mvke IN ('N/A', NULL)
   THEN ''
   ELSE 'K' || T1.a39_listung_sst_mvke
   END
  END AS a39,
 T1.a38_listung_k_sst_mvke AS a38,
 T1.a40_ost_basis AS a40,
 T1.a41_ost_gross AS a41,
 T1.a42_sued_ost AS a42,
 T1.a43_sued_west AS a43,
 T1.a44_west AS a44,
 T1.a45_nord AS a45,
  CASE
  WHEN T1.art_id IS NULL
  THEN NULL
  ELSE T1.a37_listung_erster_markt
  END AS a37,
  CASE
  WHEN T1.a59_anz_maerkte_sst = 0
  THEN NULL
  ELSE T1.a59_anz_maerkte_sst
  END AS a56,
  CASE
  WHEN T1.a449_anz_maerkte_k_sst = 0
  THEN NULL
  ELSE T1.a449_anz_maerkte_k_sst
  END AS a449,
  CASE
  WHEN T1.a46_max_anz_maerkte_sst = 0
  THEN NULL
  ELSE T1.a46_max_anz_maerkte_sst
  END AS a46,
  CASE
  WHEN T1.a47_max_anz_maerkte_k_sst = 0
  THEN NULL
  ELSE T1.a47_max_anz_maerkte_k_sst
  END AS a47,
  CASE
  WHEN T1.a53_anz_maerkte_listung_gesamt = 0
  THEN NULL
  ELSE T1.a53_anz_maerkte_listung_gesamt
  END AS a53,
  CASE
  WHEN T1.a57_anz_maerkte_listung_einzel = 0
  THEN NULL
  ELSE T1.a57_anz_maerkte_listung_einzel
  END AS a57,
  CASE
  WHEN T1.mandant_id = 1 AND T1.anz_maerkte_baustein_sonstige > 0
  THEN T1.anz_maerkte_baustein_sonstige
  ELSE NULL
  END AS a444,
  CASE
  WHEN T1.mandant_id > 1 AND T1.anz_maerkte_baustein_sonstige > 0
  THEN T1.anz_maerkte_baustein_sonstige
  ELSE NULL
  END AS a55,
 ROUND(CAST(T1.a53_anz_maerkte_listung_gesamt - CAST(CASE
       WHEN T1.a46_max_anz_maerkte_sst IS NULL
       THEN '0'
       ELSE CAST(T1.a46_max_anz_maerkte_sst AS STRING)
       END AS FLOAT64) - CAST(CASE
      WHEN T1.a47_max_anz_maerkte_k_sst IS NULL
      THEN '0'
      ELSE CAST(T1.a47_max_anz_maerkte_k_sst AS STRING)
      END AS FLOAT64) AS NUMERIC), 0) AS a48,
 CAST(CASE
    WHEN T1.absatz_sa_kl = 0
    THEN NULL
    ELSE T1.absatz_sa_kl
    END / CASE
    WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
    THEN NULL
    ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
    END AS NUMERIC) AS a261,
 CAST((CASE
        WHEN T1.absatz_sa_kl = 0
        THEN NULL
        ELSE T1.absatz_sa_kl
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
        END - CASE
       WHEN CASE
          WHEN T1.absatz_sa_kl_vj = 0
          THEN NULL
          ELSE T1.absatz_sa_kl_vj
          END / CASE
          WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
          THEN NULL
          ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.absatz_sa_kl_vj = 0
         THEN NULL
         ELSE T1.absatz_sa_kl_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.absatz_sa_kl_vj = 0
        THEN NULL
        ELSE T1.absatz_sa_kl_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.absatz_sa_kl_vj = 0
       THEN NULL
       ELSE T1.absatz_sa_kl_vj
       END / CASE
       WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
       THEN NULL
       ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
       END
     END * 100 AS NUMERIC) AS a269,
 CAST(CASE
     WHEN T1.absatz_sa_kl = 0
     THEN NULL
     ELSE T1.absatz_sa_kl
     END / CASE
     WHEN T1.a17_absatz_kl = 0
     THEN NULL
     ELSE T1.a17_absatz_kl
     END * 100 AS NUMERIC) AS a20,
 CAST(CASE
    WHEN CAST(T1.anz_bons_af AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(T1.anz_bons_af AS NUMERIC)
    END / CASE
    WHEN CAST(T1.anz_bons_gesamt AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(T1.anz_bons_gesamt AS NUMERIC)
    END AS NUMERIC) AS a348,
 CAST(CASE
    WHEN CAST(T1.anz_bons_sa AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(T1.anz_bons_sa AS NUMERIC)
    END / CASE
    WHEN CAST(T1.anz_bons_gesamt AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(T1.anz_bons_gesamt AS NUMERIC)
    END AS NUMERIC) AS a352,
 ROUND(CAST((T1.a23_rohertrag_ekmep_olk_4n - T1.rohertrag_ekmep_olk_4n_vj) / CASE
      WHEN T1.rohertrag_ekmep_olk_4n_vj = 0
      THEN NULL
      ELSE T1.rohertrag_ekmep_olk_4n_vj
      END * 100 AS NUMERIC), 1) AS a24,
  CASE
  WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
  THEN 0
  ELSE CAST(CASE
     WHEN T1.rohertrag_ekmep_olk_4n_af = 0
     THEN NULL
     ELSE T1.rohertrag_ekmep_olk_4n_af
     END / CASE
     WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
     THEN NULL
     ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
     END AS NUMERIC)
  END AS a293,
  CASE
  WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
  THEN 0
  ELSE CAST(CASE
     WHEN T1.rohertrag_ekmep_olk_4n_sa = 0
     THEN NULL
     ELSE T1.rohertrag_ekmep_olk_4n_sa
     END / CASE
     WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
     THEN NULL
     ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
     END AS NUMERIC)
  END AS a297,
  CASE
  WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
  THEN 0
  ELSE CAST((CASE
         WHEN T1.rohertrag_ekmep_olk_4n_af = 0
         THEN NULL
         ELSE T1.rohertrag_ekmep_olk_4n_af
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af
         END - CASE
        WHEN CASE
           WHEN T1.rohertrag_ekmep_olk_4n_af_vj = 0
           THEN NULL
           ELSE T1.rohertrag_ekmep_olk_4n_af_vj
           END / CASE
           WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
           THEN NULL
           ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
           END = 0
        THEN NULL
        ELSE CASE
          WHEN T1.rohertrag_ekmep_olk_4n_af_vj = 0
          THEN NULL
          ELSE T1.rohertrag_ekmep_olk_4n_af_vj
          END / CASE
          WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
          THEN NULL
          ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
          END
        END) / CASE
      WHEN CASE
         WHEN T1.rohertrag_ekmep_olk_4n_af_vj = 0
         THEN NULL
         ELSE T1.rohertrag_ekmep_olk_4n_af_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
         END = 0
      THEN NULL
      ELSE CASE
        WHEN T1.rohertrag_ekmep_olk_4n_af_vj = 0
        THEN NULL
        ELSE T1.rohertrag_ekmep_olk_4n_af_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_af_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_af_vj
        END
      END * 100 AS NUMERIC)
  END AS a301,
 CAST((CASE
        WHEN T1.rohertrag_ekmep_olk_4n_sa = 0
        THEN NULL
        ELSE T1.rohertrag_ekmep_olk_4n_sa
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
        END - CASE
       WHEN CASE
          WHEN T1.rohertrag_ekmep_olk_4n_sa_vj = 0
          THEN NULL
          ELSE T1.rohertrag_ekmep_olk_4n_sa_vj
          END / CASE
          WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
          THEN NULL
          ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.rohertrag_ekmep_olk_4n_sa_vj = 0
         THEN NULL
         ELSE T1.rohertrag_ekmep_olk_4n_sa_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.rohertrag_ekmep_olk_4n_sa_vj = 0
        THEN NULL
        ELSE T1.rohertrag_ekmep_olk_4n_sa_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.rohertrag_ekmep_olk_4n_sa_vj = 0
       THEN NULL
       ELSE T1.rohertrag_ekmep_olk_4n_sa_vj
       END / CASE
       WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
       THEN NULL
       ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
       END
     END * 100 AS NUMERIC) AS a305,
 CAST(CASE
    WHEN T1.kassenumsatz_af_kl_absolut_brutto = 0
    THEN NULL
    ELSE T1.kassenumsatz_af_kl_absolut_brutto
    END / CASE
    WHEN T1.absatz_af_kl = 0
    THEN NULL
    ELSE T1.absatz_af_kl
    END AS NUMERIC) AS a372,
 CAST(CASE
     WHEN T1.a23_rohertrag_ekmep_olk_4n = 0
     THEN NULL
     ELSE T1.a23_rohertrag_ekmep_olk_4n
     END / CASE
     WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
     THEN NULL
     ELSE T1.a21_kassenumsatz_kl_absolut_netto
     END * 100 AS NUMERIC) AS a25,
 CAST(CASE
     WHEN T1.rohertrag_ekmep_olk_4n_af = 0
     THEN NULL
     ELSE T1.rohertrag_ekmep_olk_4n_af
     END / CASE
     WHEN T1.kassenumsatz_af_kl_absolut_netto = 0
     THEN NULL
     ELSE T1.kassenumsatz_af_kl_absolut_netto
     END * 100 AS NUMERIC) AS a26,
 CAST(CASE
     WHEN T1.rohertrag_ekmep_olk_4n_sa = 0
     THEN NULL
     ELSE T1.rohertrag_ekmep_olk_4n_sa
     END / CASE
     WHEN T1.kassenumsatz_sa_kl_absolut_netto = 0
     THEN NULL
     ELSE T1.kassenumsatz_sa_kl_absolut_netto
     END * 100 AS NUMERIC) AS a309,
 CAST(CASE
     WHEN T1.a17_absatz_kl - T1.absatz_kl_vj = 0
     THEN NULL
     ELSE T1.a17_absatz_kl - T1.absatz_kl_vj
     END / CASE
     WHEN T1.absatz_kl_vj = 0
     THEN NULL
     ELSE T1.absatz_kl_vj
     END * 100 AS NUMERIC) AS a18,
 ROUND(CAST(T1.a21_kassenumsatz_kl_absolut_netto AS NUMERIC), 0) AS a21,
 CAST(CASE
    WHEN T1.kassenumsatz_sa_kl_absolut_netto = 0
    THEN NULL
    ELSE T1.kassenumsatz_sa_kl_absolut_netto
    END / CASE
    WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
    THEN NULL
    ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
    END AS NUMERIC) AS a277,
 CAST((CASE
        WHEN T1.kassenumsatz_sa_kl_absolut_netto = 0
        THEN NULL
        ELSE T1.kassenumsatz_sa_kl_absolut_netto
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa
        END - CASE
       WHEN CASE
          WHEN T1.kassenumsatz_sa_kl_absolut_netto_vj = 0
          THEN NULL
          ELSE T1.kassenumsatz_sa_kl_absolut_netto_vj
          END / CASE
          WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
          THEN NULL
          ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.kassenumsatz_sa_kl_absolut_netto_vj = 0
         THEN NULL
         ELSE T1.kassenumsatz_sa_kl_absolut_netto_vj
         END / CASE
         WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
         THEN NULL
         ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.kassenumsatz_sa_kl_absolut_netto_vj = 0
        THEN NULL
        ELSE T1.kassenumsatz_sa_kl_absolut_netto_vj
        END / CASE
        WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
        THEN NULL
        ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.kassenumsatz_sa_kl_absolut_netto_vj = 0
       THEN NULL
       ELSE T1.kassenumsatz_sa_kl_absolut_netto_vj
       END / CASE
       WHEN T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0
       THEN NULL
       ELSE T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj
       END
     END * 100 AS NUMERIC) AS a289,
 CAST(CASE
     WHEN T1.a21_kassenumsatz_kl_absolut_netto - T1.kassenumsatz_kl_absolut_netto_vj = 0
     THEN NULL
     ELSE T1.a21_kassenumsatz_kl_absolut_netto - T1.kassenumsatz_kl_absolut_netto_vj
     END / CASE
     WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
     THEN NULL
     ELSE T1.kassenumsatz_kl_absolut_netto_vj
     END * 100 AS NUMERIC) AS a22,
 ROUND(CAST(T1.a273_kassenumsatz_kl_absolut_brutto AS NUMERIC), 0) AS a273,
 ROUND(CAST(T1.a27_totalabschriften_wert_netto_absolut AS NUMERIC), 0) AS a27,
 ROUND(CAST(T1.a313_preisabschriften_preisanderungen_wert_netto_absolut AS NUMERIC), 0) AS a313,
 CAST(CASE
     WHEN T1.a313_preisabschriften_preisanderungen_wert_netto_absolut = 0
     THEN NULL
     ELSE T1.a313_preisabschriften_preisanderungen_wert_netto_absolut
     END / CASE
     WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
     THEN NULL
     ELSE T1.a21_kassenumsatz_kl_absolut_netto
     END * 100 AS NUMERIC) AS a317,
 CAST(CASE
     WHEN T1.a27_totalabschriften_wert_netto_absolut = 0
     THEN NULL
     ELSE T1.a27_totalabschriften_wert_netto_absolut
     END / CASE
     WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
     THEN NULL
     ELSE T1.a21_kassenumsatz_kl_absolut_netto
     END * 100 AS NUMERIC) AS a28,
 CAST((CASE
        WHEN T1.a27_totalabschriften_wert_netto_absolut = 0
        THEN NULL
        ELSE T1.a27_totalabschriften_wert_netto_absolut
        END / CASE
        WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
        THEN NULL
        ELSE T1.a21_kassenumsatz_kl_absolut_netto
        END - CASE
       WHEN CASE
          WHEN T1.totalabschriften_wert_netto_absolut_vj = 0
          THEN NULL
          ELSE T1.totalabschriften_wert_netto_absolut_vj
          END / CASE
          WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
          THEN NULL
          ELSE T1.kassenumsatz_kl_absolut_netto_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.totalabschriften_wert_netto_absolut_vj = 0
         THEN NULL
         ELSE T1.totalabschriften_wert_netto_absolut_vj
         END / CASE
         WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
         THEN NULL
         ELSE T1.kassenumsatz_kl_absolut_netto_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.totalabschriften_wert_netto_absolut_vj = 0
        THEN NULL
        ELSE T1.totalabschriften_wert_netto_absolut_vj
        END / CASE
        WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
        THEN NULL
        ELSE T1.kassenumsatz_kl_absolut_netto_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.totalabschriften_wert_netto_absolut_vj = 0
       THEN NULL
       ELSE T1.totalabschriften_wert_netto_absolut_vj
       END / CASE
       WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
       THEN NULL
       ELSE T1.kassenumsatz_kl_absolut_netto_vj
       END
     END * 100 AS NUMERIC) AS a325,
 CAST((CASE
        WHEN T1.a313_preisabschriften_preisanderungen_wert_netto_absolut = 0
        THEN NULL
        ELSE T1.a313_preisabschriften_preisanderungen_wert_netto_absolut
        END / CASE
        WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
        THEN NULL
        ELSE T1.a21_kassenumsatz_kl_absolut_netto
        END - CASE
       WHEN CASE
          WHEN T1.preisabschriften_preisanderungen_wert_netto_absolut_vj = 0
          THEN NULL
          ELSE T1.preisabschriften_preisanderungen_wert_netto_absolut_vj
          END / CASE
          WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
          THEN NULL
          ELSE T1.kassenumsatz_kl_absolut_netto_vj
          END = 0
       THEN NULL
       ELSE CASE
         WHEN T1.preisabschriften_preisanderungen_wert_netto_absolut_vj = 0
         THEN NULL
         ELSE T1.preisabschriften_preisanderungen_wert_netto_absolut_vj
         END / CASE
         WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
         THEN NULL
         ELSE T1.kassenumsatz_kl_absolut_netto_vj
         END
       END) / CASE
     WHEN CASE
        WHEN T1.preisabschriften_preisanderungen_wert_netto_absolut_vj = 0
        THEN NULL
        ELSE T1.preisabschriften_preisanderungen_wert_netto_absolut_vj
        END / CASE
        WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
        THEN NULL
        ELSE T1.kassenumsatz_kl_absolut_netto_vj
        END = 0
     THEN NULL
     ELSE CASE
       WHEN T1.preisabschriften_preisanderungen_wert_netto_absolut_vj = 0
       THEN NULL
       ELSE T1.preisabschriften_preisanderungen_wert_netto_absolut_vj
       END / CASE
       WHEN T1.kassenumsatz_kl_absolut_netto_vj = 0
       THEN NULL
       ELSE T1.kassenumsatz_kl_absolut_netto_vj
       END
     END * 100 AS NUMERIC) AS a329,
 ROUND(CAST(T3.d423_fanquote * 100 AS NUMERIC), 1) AS d423,
 T3.a509_anz_kaeufer AS a509,
  CASE
  WHEN T1.mandant_id > 1
  THEN T1.a402_kolli_la
  ELSE SUBSTR(CAST(ROUND(CAST(ROUND(1 / CAST(CASE
          WHEN CAST(REPLACE(T1.a402_kolli_la, ' ', '') AS FLOAT64) = 0
          THEN NULL
          ELSE REPLACE(T1.a402_kolli_la, ' ', '')
          END AS FLOAT64)) AS NUMERIC), 0) AS STRING), 1, 100)
  END AS a402,
  CASE
  WHEN T1.mandant_id > 1
  THEN T1.a401_kolli_bst
  ELSE SUBSTR(CAST(ROUND(CAST(ROUND(1 / CAST(CASE
          WHEN CAST(REPLACE(T1.a401_kolli_bst, ' ', '') AS FLOAT64) = 0
          THEN NULL
          ELSE REPLACE(T1.a401_kolli_bst, ' ', '')
          END AS FLOAT64)) AS NUMERIC), 0) AS STRING), 1, 100)
  END AS a401,
 T1.a403_restlaufzeit_zl AS a403,
 T1.a404_restlaufzeit_dz AS a404,
 T1.a405_basismengeneinheit AS a405,
  CASE
  WHEN T1.art_id IS NULL
  THEN NULL
  ELSE T1.a406_letzte_listungsanderung_sst_ksst
  END AS a406,
 T1.a407_verhandler AS a407,
 T1.a408_display_komponente_kz AS a408,
 T1.a409_kl_art_id_display AS a409,
 T1.a416_artikelrolle_id AS a416,
 T1.a339_umsatzsteuer AS a339,
 T1.a393_vegan AS a393,
 T1.a394_gluten AS a394,
 T1.a395_bio AS a395,
  CASE
  WHEN T1.art_id IS NOT NULL
  THEN T1.a396_eigenmarke
  ELSE CASE
   WHEN T1.eigenmarke_fg_nielsen = 1
   THEN 'anonymized'
   ELSE 'Brand_1'
   END
  END AS a396,
 T1.a397_tierwohl AS a397,
 T1.a398_posten_food AS a398,
 T1.a399_posten_nonfood AS a399,
 T1.a400_lcf AS a400,
 ROUND(CAST(t10.a415_kannibalisierungsfaktor AS NUMERIC), 1) AS a415,
 T1.art_id,
 T1.nielsen_gtin,
 T1.nielsen_art_bez,
 T4.cherrypicker_quote AS a356,
 T4.kolliabverkaufsquote AS a368,
 T4.restbon AS a364,
 CAST(T4.index_af_id AS STRING) AS a340,
 CAST(T4.index_sa_id AS STRING) AS a344,
 ROUND(CAST(T1.a27_totalabschriften_wert_netto_absolut / CASE
      WHEN T1.a21_kassenumsatz_kl_absolut_netto = 0
      THEN NULL
      ELSE T1.a21_kassenumsatz_kl_absolut_netto
      END / CASE
     WHEN T1.totalabschriften_wert_netto_absolut_wg / CASE
        WHEN T1.kassenumsatz_kl_absolut_netto_wg = 0
        THEN NULL
        ELSE T1.kassenumsatz_kl_absolut_netto_wg
        END = 0
     THEN NULL
     ELSE T1.totalabschriften_wert_netto_absolut_wg / CASE
       WHEN T1.kassenumsatz_kl_absolut_netto_wg = 0
       THEN NULL
       ELSE T1.kassenumsatz_kl_absolut_netto_wg
       END
     END AS NUMERIC), 2) AS a321,
 T5.h452_herstellerwissen,
 T6.f49_produktwissen,
 T7.c410_lieferantenwissen,
 COALESCE(t8.tupel_bez, T1.nielsen_art_bez) AS a12,
 COALESCE(t8.tupel_bez_de, T1.nielsen_art_bez) AS a12_de,
 COALESCE(t8.tupel_bez_cz, T1.nielsen_art_bez) AS a12_cz,
 COALESCE(t8.tupel_bez_sk, T1.nielsen_art_bez) AS a12_sk,
 COALESCE(t8.tupel_bez_hr, T1.nielsen_art_bez) AS a12_hr,
 COALESCE(t8.tupel_bez_pl, T1.nielsen_art_bez) AS a12_pl,
 COALESCE(t8.tupel_bez_ro, T1.nielsen_art_bez) AS a12_ro,
 COALESCE(t8.tupel_bez_bg, T1.nielsen_art_bez) AS a12_bg,
 T9.tupel_tag
FROM kfl_production_dbp_msi_v_view.v_tupel_mat_1 AS T1_1
 LEFT JOIN kfl_production_dbp_view.v_zek_1 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.a389_zek_id = T2.zek_id
 LEFT JOIN kfl_production_dbp_view.v_fanquote_1 AS T3 ON T1.mandant_id = T3.mandant_id AND T1.matching_id = T3.matching_id
     AND T1.a500_kjwo_update = T3.kjwo_update
 LEFT JOIN kfl_production_dbp_view.v_sortiment_leistung_1 AS T4 ON T1.mandant_id = T4.mandant_id AND T1.a425_kjmo = T4.kjmo
      AND T1.a500_kjwo_update = T4.kjwo_update AND T1.matching_id = T4.matching_id
 LEFT JOIN kfl_production_dbp_msi_v_view.v_herstellerwissen_1 AS T5 ON T1.mandant_id = T5.mandant_id AND T1.a419_hersteller_id
    = CAST(T5.gp_id AS STRING)
 LEFT JOIN kfl_production_dbp_msi_v_view.v_produktwissen_1 AS T6 ON T1.mandant_id = T6.mandant_id AND T1.matching_id = T6
   .matching_id
 LEFT JOIN kfl_production_dbp_msi_v_view.v_lieferantenwissen_1 AS T7 ON T1.mandant_id = T2.mandant_id AND COALESCE(T1.a16_akt_lieferant_id
    , T1.lieferant_nielsen) = T7.lieferant
 LEFT JOIN (SELECT mandant_id,
   matching_id,
   kjwo_update,
   MAX(CASE
     WHEN spr_id = 22
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez,
   MAX(CASE
     WHEN spr_id = 22
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_de,
   MAX(CASE
     WHEN spr_id = 124
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_cz,
   MAX(CASE
     WHEN spr_id = 108
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_sk,
   MAX(CASE
     WHEN spr_id = 65
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_hr,
   MAX(CASE
     WHEN spr_id = 90
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_pl,
   MAX(CASE
     WHEN spr_id = 95
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_ro,
   MAX(CASE
     WHEN spr_id = 18
     THEN tupel_bez
     ELSE NULL
     END) AS tupel_bez_bg
  FROM kfl_production_dbp_view.v_tupel_spr_zu_1
  GROUP BY mandant_id,
   matching_id,
   kjwo_update) AS t8 ON T1.mandant_id = t8.mandant_id AND T1.matching_id = t8.matching_id AND T1.a500_kjwo_update = t8
   .kjwo_update
 LEFT JOIN kfl_production_dbp_msi_v_view.v_tupel_tags_1 AS T9 ON T1.mandant_id = T9.mandant_id AND T1.matching_id = T9.matching_id
   
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_msi_data.tupel_mat_forecast_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(a500_kjwo_update AS STRING), CAST(matching_id AS STRING)
        ORDER BY execution_timestamp IS NULL DESC, execution_timestamp DESC)) = 1) AS t10 ON T1.mandant_id = t10.mandant_id
     AND T1.a500_kjwo_update = t10.a500_kjwo_update AND T1.matching_id = t10.matching_id;