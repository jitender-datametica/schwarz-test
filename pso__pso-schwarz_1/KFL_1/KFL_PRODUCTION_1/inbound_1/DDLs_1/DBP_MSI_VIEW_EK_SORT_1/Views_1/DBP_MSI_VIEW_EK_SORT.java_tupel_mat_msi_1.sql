CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.JAVA_TUPEL_MAT_MSI_1
AS
SELECT
t1.mandant_id,
A425_kjmo AS A425,
t1.A500_kjwo_update AS A500,
t1.wrg_id AS A424,
A5_owg_id AS A5,
A7_wg_id AS A7,
CASE
WHEN a7_wg_id < 10 THEN '00' || CAST(a7_wg_id AS VARCHAR(3))
WHEN a7_wg_id < 100 THEN '0' || CAST(a7_wg_id AS VARCHAR(3))
ELSE CAST(a7_wg_id AS VARCHAR(3)) END || CASE
WHEN t1.wug_id < 10 THEN '00' || CAST(t1.wug_id AS VARCHAR(3))
WHEN t1.wug_id < 100 THEN '0' || CAST(t1.wug_id AS VARCHAR(3))
ELSE CAST(t1.wug_id AS VARCHAR(3)) END  A9,
t1.wug_id AS wug_id,
t1.matching_id,
CASE
WHEN t1.art_id IS NULL THEN 'Nielsen'
ELSE 'Kaufland' END AS A1,
A58_rang_umsatz_owg AS A58,
A2_rang_umsatz_wg AS A2,
A59_rang_absatz_wg AS A59,
CASE
WHEN t1.art_id IS NULL THEN nielsen_gtin
ELSE t1.kl_art_id END AS A11,
A450_art_nielsen_nr AS A450,
t1.nielsen_art_bez AS A12_1,
CASE
WHEN t1.art_id IS NULL THEN t1.nielsen_art_bez
ELSE art_bez_deutsch END AS A14,
CASE
WHEN t1.mandant_id=1 THEN CASE
WHEN TRIM(a14_art_status_de) IS NULL THEN 'Potenzial'
WHEN TRIM(a14_art_status_de) = '' THEN 'Aktiv'
ELSE a14_art_status_de END
WHEN t1.mandant_id >1 THEN CASE
WHEN t1.art_id IS NULL THEN 'Nielsen'
ELSE 'Kaufland' END END AS A15 --as artikelstatus_inkl_nielsen 
,
CASE
WHEN t10.A50_listungsaktion IS NULL OR TRIM(t10.A50_listungsaktion) = '' THEN 0
ELSE 1 END AS A3 --pflegestatus
,
COALESCE(A16_akt_lieferant_id, A446_lieferant_bez_latein) AS A16 -- a446 added in the key of attribute Lieferant
,
COALESCE(A16_akt_lieferant_id,lieferant_nielsen) AS lieferant_lieferantenwissen,
A419_hersteller_id AS A419
,CASE
   WHEN TRIM(a419_hersteller_id) <> '' AND a419_hersteller_id IS NOT NULL
   THEN
     CASE
       WHEN CAST(a419_hersteller_id AS INT) > 0
       THEN TRIM(a419_hersteller_id)
       ELSE TRIM(A16_akt_lieferant_id)
     END
   WHEN (TRIM(a419_hersteller_id) = '' OR a419_hersteller_id IS NULL) AND
        TRIM(A16_akt_lieferant_id) <> '' AND
        A16_akt_lieferant_id IS NOT NULL
   THEN TRIM(A16_akt_lieferant_id)
   ELSE '-9999'
END AS A421
,CASE
WHEN A446_lieferant_bez_latein IS NULL THEN ''
ELSE A446_lieferant_bez_latein END AS A446
--,A420_hersteller_bez_land AS A420
,CASE
WHEN A447_hersteller_bez_latein IS NULL THEN ''
ELSE A447_hersteller_bez_latein END AS A447
--,A446_lieferant_bez_latein AS A422 --löschen wenn Entwicklung im SL fertig, Stand 25.09.2020 - gelöscht am 30.09.2020
,CASE
   WHEN t1.mandant_id > 1 
   THEN A446_lieferant_bez_latein
   ELSE CASE
          WHEN TRIM(a419_hersteller_id) = ''
          THEN A446_lieferant_bez_latein
          WHEN CAST(a419_hersteller_id AS INT) >0 
          THEN A447_hersteller_bez_latein
          ELSE A446_lieferant_bez_latein 
        END 
 END AS A448 --geändert 30.09.2020 sgro2903
,A60_muki_vk_kz AS A60,
A61_muki_vk_kl_art_id_verkettung AS A61,
A389_zek_id AS A389,
t2.zek_name AS A390
,CASE
WHEN A391_disc_pe = 0 OR A391_disc_pe IS NULL THEN NULL
-- ALT funktioniert auf SF nicht mehr. da Leerstring keine Zahl ist 
--WHEN A391_disc_pe IN (0,'') THEN ''
ELSE TRIM (A391_disc_pe) END AS A391
,CASE
WHEN A392_disc_ohne_etikett = 0 OR A392_disc_ohne_etikett IS NULL THEN NULL
-- ALT funktioniert auf SF nicht mehr. da Leerstring keine Zahl ist 
--WHEN A392_disc_ohne_etikett IN (0,'') THEN ''
ELSE TRIM (A392_disc_ohne_etikett) END AS A392,
CAST (CASE
WHEN kassenumsatz_af_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,1)) AS A281,
CAST (((kassenumsatz_af_kl_absolut_netto / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END)-(kassenumsatz_af_kl_absolut_netto_vj / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END))/ CASE
WHEN (CASE
WHEN kassenumsatz_af_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) = 0 THEN NULL
ELSE (CASE
WHEN kassenumsatz_af_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) AS A285,
CAST (CASE
WHEN absatz_af_kl = 0 THEN NULL
ELSE absatz_af_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,1)) AS A19,
CAST (((CASE
WHEN absatz_af_kl = 0 THEN NULL
ELSE absatz_af_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END)- CASE
WHEN CASE
WHEN absatz_af_kl_vj = 0 THEN NULL
ELSE absatz_af_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END = 0 THEN NULL
ELSE CASE
WHEN absatz_af_kl_vj = 0 THEN NULL
ELSE absatz_af_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END END)/ CASE
WHEN (CASE
WHEN absatz_af_kl_vj = 0 THEN NULL
ELSE absatz_af_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) = 0 THEN NULL
ELSE (CASE
WHEN absatz_af_kl_vj = 0 THEN NULL
ELSE absatz_af_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) AS A265,
CAST (A17_absatz_kl AS DEC (18,0)) AS A17,
CAST (A76_absatz_sst1 AS DEC (18,0)) AS A76,
CAST (A78_absatz_sst2 AS DEC (18,0)) AS A78,
CAST (A80_absatz_sst3 AS DEC (18,0)) AS A80,
CAST (A82_absatz_sst4 AS DEC (18,0)) AS A82,
CAST (A84_absatz_sst5 AS DEC (18,0)) AS A84,
CAST (A86_absatz_sst6 AS DEC (18,0)) AS A86,
CAST (A88_absatz_sst7 AS DEC (18,0)) AS A88,
CAST (A62_absatz_ksst1 AS DEC (18,0)) AS A62,
CAST (A64_absatz_ksst2 AS DEC (18,0)) AS A64,
CAST (A66_absatz_ksst3 AS DEC (18,0)) AS A66,
CAST (A68_absatz_ksst4 AS DEC (18,0)) AS A68,
CAST (A70_absatz_ksst5 AS DEC (18,0)) AS A70,
CAST (A72_absatz_ksst6 AS DEC (18,0)) AS A72,
CAST (A74_absatz_ksst7 AS DEC (18,0)) AS A74,
CAST (A90_absatz_ost_basis AS DEC (18,0)) AS A90,
CAST (A92_absatz_ost_gross AS DEC (18,0)) AS A92,
CAST (A94_absatz_sued_ost AS DEC (18,0)) AS A94,
CAST (A96_absatz_sued_west AS DEC (18,0)) AS A96,
CAST (A98_absatz_west AS DEC (18,0)) AS A98,
CAST (A100_absatz_nord AS DEC (18,0)) AS A100,
CAST (CASE
WHEN A76_absatz_sst1 = 0 THEN NULL
ELSE A76_absatz_sst1 END / CASE
WHEN markt_wochen_sst1 = 0 THEN NULL
ELSE markt_wochen_sst1 END AS DEC (18,1)) AS A77,
CAST (CASE
WHEN A78_absatz_sst2 = 0 THEN NULL
ELSE A78_absatz_sst2 END / CASE
WHEN markt_wochen_sst2 = 0 THEN NULL
ELSE markt_wochen_sst2 END AS DEC (18,1)) AS A79,
CAST (CASE
WHEN A80_absatz_sst3 = 0 THEN NULL
ELSE A80_absatz_sst3 END / CASE
WHEN markt_wochen_sst3 = 0 THEN NULL
ELSE markt_wochen_sst3 END AS DEC (18,1)) AS A81,
CAST (CASE
WHEN A82_absatz_sst4 = 0 THEN NULL
ELSE A82_absatz_sst4 END / CASE
WHEN markt_wochen_sst4 = 0 THEN NULL
ELSE markt_wochen_sst4 END AS DEC (18,1)) AS A83,
CAST (CASE
WHEN A84_absatz_sst5 = 0 THEN NULL
ELSE A84_absatz_sst5 END / CASE
WHEN markt_wochen_sst5 = 0 THEN NULL
ELSE markt_wochen_sst5 END AS DEC (18,1)) AS A85,
CAST (CASE
WHEN A86_absatz_sst6 = 0 THEN NULL
ELSE A86_absatz_sst6 END / CASE
WHEN markt_wochen_sst6 = 0 THEN NULL
ELSE markt_wochen_sst6 END AS DEC (18,1)) AS A87,
CAST (CASE
WHEN A88_absatz_sst7 = 0 THEN NULL
ELSE A88_absatz_sst7 END / CASE
WHEN markt_wochen_sst7 = 0 THEN NULL
ELSE markt_wochen_sst7 END AS DEC (18,1)) AS A89,
CAST (CASE
WHEN A62_absatz_ksst1 = 0 THEN NULL
ELSE A62_absatz_ksst1 END / CASE
WHEN markt_wochen_ksst1 = 0 THEN NULL
ELSE markt_wochen_ksst1 END AS DEC (18,1)) AS A63,
CAST (CASE
WHEN A64_absatz_ksst2 = 0 THEN NULL
ELSE A64_absatz_ksst2 END / CASE
WHEN markt_wochen_ksst2 = 0 THEN NULL
ELSE markt_wochen_ksst2 END AS DEC (18,1)) AS A65,
CAST (CASE
WHEN A66_absatz_ksst3 = 0 THEN NULL
ELSE A66_absatz_ksst3 END / CASE
WHEN markt_wochen_ksst3 = 0 THEN NULL
ELSE markt_wochen_ksst3 END AS DEC (18,1)) AS A67,
CAST (CASE
WHEN A68_absatz_ksst4 = 0 THEN NULL
ELSE A68_absatz_ksst4 END / CASE
WHEN markt_wochen_ksst4 = 0 THEN NULL
ELSE markt_wochen_ksst4 END AS DEC (18,1)) AS A69,
CAST (CASE
WHEN A70_absatz_ksst5 = 0 THEN NULL
ELSE A70_absatz_ksst5 END / CASE
WHEN markt_wochen_ksst5 = 0 THEN NULL
ELSE markt_wochen_ksst5 END AS DEC (18,1)) AS A71,
CAST (CASE
WHEN A72_absatz_ksst6 = 0 THEN NULL
ELSE A72_absatz_ksst6 END / CASE
WHEN markt_wochen_ksst6 = 0 THEN NULL
ELSE markt_wochen_ksst6 END AS DEC (18,1)) AS A73,
CAST (CASE
WHEN A74_absatz_ksst7 = 0 THEN NULL
ELSE A74_absatz_ksst7 END / CASE
WHEN markt_wochen_ksst7 = 0 THEN NULL
ELSE markt_wochen_ksst7 END AS DEC (18,1)) AS A75,
CAST (CASE
WHEN A90_absatz_ost_basis = 0 THEN NULL
ELSE A90_absatz_ost_basis END / CASE
WHEN markt_wochen_ost_basis = 0 THEN NULL
ELSE markt_wochen_ost_basis END AS DEC (18,1)) AS A91,
CAST (CASE
WHEN A92_absatz_ost_gross = 0 THEN NULL
ELSE A92_absatz_ost_gross END / CASE
WHEN markt_wochen_ost_gross = 0 THEN NULL
ELSE markt_wochen_ost_gross END AS DEC (18,1)) AS A93,
CAST (CASE
WHEN A94_absatz_sued_ost = 0 THEN NULL
ELSE A94_absatz_sued_ost END / CASE
WHEN markt_wochen_sued_ost = 0 THEN NULL
ELSE markt_wochen_sued_ost END AS DEC (18,1)) AS A95,
CAST (CASE
WHEN A96_absatz_sued_west = 0 THEN NULL
ELSE A96_absatz_sued_west END / CASE
WHEN markt_wochen_sued_west = 0 THEN NULL
ELSE markt_wochen_sued_west END AS DEC (18,1)) AS A97,
CAST (CASE
WHEN A98_absatz_west = 0 THEN NULL
ELSE A98_absatz_west END / CASE
WHEN markt_wochen_west = 0 THEN NULL
ELSE markt_wochen_west END AS DEC (18,1)) AS A99,
CAST (CASE
WHEN A100_absatz_nord = 0 THEN NULL
ELSE A100_absatz_nord END / CASE
WHEN markt_wochen_nord = 0 THEN NULL
ELSE markt_wochen_nord END AS DEC (18,1)) AS A101,
CAST (CAST(anzahl_markt_wochen_kombis_abverkauf_mit_listung AS DEC (18,4)) / CASE
WHEN anzahl_markt_wochen_kombis_listung = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_listung END *100 AS DEC (18,1)) AS A360,
CAST (A31_vk_brutto_kl_pk_1 AS DEC (18,2)) AS A31,
CAST (A333_vk_brutto_kl_pk_2 AS DEC (18,2)) AS A333,
CAST (A54_vk_brutto_kl_pk_3 AS DEC (18,2)) AS A54,
CAST (A334_vk_brutto_kl_pk_4 AS DEC (18,2)) AS A334,
CAST (A432_vk_brutto_kl_pk_5 AS DEC (18,2)) AS A432,
CAST (A433_vk_brutto_kl_pk_6 AS DEC (18,2)) AS A433,
CAST (A434_vk_brutto_kl_pk_7 AS DEC (18,2)) AS A434,
CAST (A435_vk_brutto_kl_pk_8 AS DEC (18,2)) AS A435,
CAST (A436_vk_brutto_kl_pk_9 AS DEC (18,2)) AS A436,
CAST (A437_vk_brutto_kl_pk_10 AS DEC (18,2)) AS A437,
CAST (A30_KB_oLK_EK4ndz_Stamm AS DEC (18,2)) AS A30,
CAST(CASE
WHEN (A31_vk_brutto_kl_pk_1 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A31_vk_brutto_kl_pk_1 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A31_vk_brutto_kl_pk_1 = 0 THEN NULL
ELSE A31_vk_brutto_kl_pk_1 END * 100 AS DEC (18,2)) AS A335,
CAST(CASE
WHEN (A333_vk_brutto_kl_pk_2 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A333_vk_brutto_kl_pk_2 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A333_vk_brutto_kl_pk_2 = 0 THEN NULL
ELSE A333_vk_brutto_kl_pk_2 END * 100 AS DEC (18,2)) AS A438,
CAST(CASE
WHEN (A54_vk_brutto_kl_pk_3 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A54_vk_brutto_kl_pk_3 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A54_vk_brutto_kl_pk_3 = 0 THEN NULL
ELSE A54_vk_brutto_kl_pk_3 END * 100 AS DEC (18,2)) AS A336,
CAST(CASE
WHEN (A334_vk_brutto_kl_pk_4 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A334_vk_brutto_kl_pk_4 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A334_vk_brutto_kl_pk_4 = 0 THEN NULL
ELSE A334_vk_brutto_kl_pk_4 END * 100 AS DEC (18,2)) AS A337,
CAST(CASE
WHEN (A432_vk_brutto_kl_pk_5 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A432_vk_brutto_kl_pk_5 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A432_vk_brutto_kl_pk_5 = 0 THEN NULL
ELSE A432_vk_brutto_kl_pk_5 END * 100 AS DEC (18,2)) AS A439,
CAST(CASE
WHEN (A433_vk_brutto_kl_pk_6 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A433_vk_brutto_kl_pk_6 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A433_vk_brutto_kl_pk_6 = 0 THEN NULL
ELSE A433_vk_brutto_kl_pk_6 END * 100 AS DEC (18,2)) AS A440,
CAST(CASE
WHEN (A434_vk_brutto_kl_pk_7 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A434_vk_brutto_kl_pk_7 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A434_vk_brutto_kl_pk_7 = 0 THEN NULL
ELSE A434_vk_brutto_kl_pk_7 END * 100 AS DEC (18,2)) AS A441,
CAST(CASE
WHEN (A435_vk_brutto_kl_pk_8 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A435_vk_brutto_kl_pk_8 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A435_vk_brutto_kl_pk_8 = 0 THEN NULL
ELSE A435_vk_brutto_kl_pk_8 END * 100 AS DEC (18,2)) AS A338,
CAST(CASE
WHEN (A436_vk_brutto_kl_pk_9 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A436_vk_brutto_kl_pk_9 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A436_vk_brutto_kl_pk_9 = 0 THEN NULL
ELSE A436_vk_brutto_kl_pk_9 END * 100 AS DEC (18,2)) AS A442,
CAST(CASE
WHEN (A437_vk_brutto_kl_pk_10 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A437_vk_brutto_kl_pk_10 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A437_vk_brutto_kl_pk_10 = 0 THEN NULL
ELSE A437_vk_brutto_kl_pk_10 END * 100 AS DEC (18,2)) AS A443,
CAST (A23_rohertrag_ekmep_olk_4n AS DEC (18,0)) AS A23,
CAST ((A21_kassenumsatz_kl_absolut_netto - A23_rohertrag_ekmep_olk_4n)  / CASE
WHEN A17_absatz_kl = 0 THEN NULL
ELSE A17_absatz_kl END AS DEC (18,2)) AS A29,
t10.A51_listung_sst_pflege AS A51,
t10.A52_listung_k_sst_pflege AS A52,
CASE
WHEN t10.A426_ost_basis_pflege = 'X' THEN t10.A426_ost_basis_pflege
ELSE NULL END AS A426,
CASE
WHEN t10.A427_ost_gross_pflege = 'X' THEN t10.A427_ost_gross_pflege
ELSE NULL END AS A427,
CASE
WHEN t10.A428_sued_ost_pflege = 'X' THEN  t10.A428_sued_ost_pflege
ELSE NULL END AS A428,
CASE
WHEN t10.A429_sued_west_pflege = 'X' THEN t10.A429_sued_west_pflege
ELSE NULL END  AS A429,
CASE
WHEN t10.A430_west_pflege = 'X' THEN t10.A430_west_pflege
ELSE NULL END AS A430,
CASE
WHEN t10.A431_nord_pflege = 'X' THEN t10.A431_nord_pflege
ELSE NULL END AS A431,
t10.A50_listungsaktion AS A50,
CASE
WHEN t10.A50_listungsaktion = '0' THEN 'keine Listungsaktion'
WHEN t10.A50_listungsaktion = '1' THEN 'keine Veränderung'
WHEN t10.A50_listungsaktion = '2' THEN 'nicht möglich'
WHEN t10.A50_listungsaktion = '3' THEN 'SOLL-Listung = IST-Listung'
WHEN t10.A50_listungsaktion = '4' THEN 'Neulistung KL-Artikel_1'
WHEN t10.A50_listungsaktion = '5' THEN 'Einlistung Kauflandartikel'
WHEN t10.A50_listungsaktion = '6' THEN 'Einlistung Potenzialartikel'
WHEN t10.A50_listungsaktion = '7' THEN 'Auslistung'
WHEN t10.A50_listungsaktion = '8' THEN 'Listung erweitern'
WHEN t10.A50_listungsaktion = '9' THEN 'Listung reduzieren'
WHEN t10.A50_listungsaktion = '10' THEN 'Listung erweitern und reduzieren'
WHEN t10.A50_listungsaktion = '11' THEN 'Listung reduzieren und erweitern'
WHEN t10.A50_listungsaktion = '12' THEN 'Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'
WHEN t10.A50_listungsaktion = '13' THEN 'Nielsen Eigenmarke => nicht durch STP, immer gefüllt' END AS A50_desc
--CAST(NULLIF(t10.A411_stk_rohertrag_pflege,'') AS DEC (18,2)) AS A411,
,t10.A411_stk_rohertrag_pflege AS A411
,CASE
WHEN t10.A415_kannibalisierungsfaktor>0 THEN CAST (t10.A412_umsatz_brutto_hochrechnung*t10.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t10.A412_umsatz_brutto_hochrechnung*1 AS DEC (18,0)) END AS A412,
CASE
WHEN t10.A415_kannibalisierungsfaktor>0 THEN CAST (t10.A413_absatz_hochrechnung*t10.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t10.A413_absatz_hochrechnung*1 AS DEC (18,0)) END AS A413,
CASE
WHEN t10.A415_kannibalisierungsfaktor>0 THEN CAST (t10.A414_rohertrag_hochrechnung*t10.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t10.A414_rohertrag_hochrechnung*1 AS DEC (18,0)) END AS A414,
CAST (A36_gewichtete_distribution_nielsen AS DEC (18,1)) AS A36,
CAST (A32_umsatz_anteil_wgi_nielsen AS DEC (18,1)) AS A32,
CAST (A33_umsatz_anteil_wgi_kumuliert_nielsen AS DEC (18,1)) AS A33,
CAST (A34_vk_brutto_durchschnitt_nielsen AS DEC (18,2)) AS A34,
CAST (A35_umsatz_nielsen AS DEC (18,0)) AS A35,
CASE
WHEN t1.mandant_id = 1 THEN anz_wochen_de_anz_monate_kmo_nielsen
ELSE NULL END AS A378,
CASE
WHEN t1.mandant_id > 1 THEN anz_wochen_de_anz_monate_kmo_nielsen
ELSE NULL END AS A379,
CAST (A376_kl_marktanteil_wg_nielsen AS DEC (18,1)) AS A376,
A380_marktanteilbewertung_nielsen AS A380,
CAST (A377_durchschnitt_anz_maerkte_nielsen AS DEC (18,1)) AS A377,
CAST (A383_sales_units_verkaufseinheiten_Gl_in_1000_normiert_nielsen AS DEC (18,0)) AS A383,
CAST (A384_durchschn_preis_einheit_gl_normiert_nielsen AS DEC (18,2)) AS A384,
CAST (A385_numerische_distribution_nielsen AS DEC (18,1)) AS A385,
A386_inhaltsmengen_nielsen AS A386,
A387_duft_geschmack_nielsen AS A387,
A388_einheit_nielsen AS A388,
A381_preislagenverteilung AS A381,
CASE
WHEN t1.mandant_id >1 THEN A39_listung_sst_mvke
ELSE CASE
WHEN A39_listung_sst_mvke IN ('N/A',NULL) THEN ''
ELSE 'K' || A39_listung_sst_mvke END END AS A39,
A38_listung_k_sst_mvke AS A38,
A40_ost_basis AS A40,
A41_ost_gross AS A41,
A42_sued_ost AS A42,
A43_sued_west AS A43,
A44_west AS A44,
A45_nord AS A45,
CASE
WHEN t1.art_id IS NULL THEN NULL
ELSE A37_listung_erster_markt END AS A37,
CASE
WHEN A59_anz_maerkte_sst = 0 THEN NULL
ELSE A59_anz_maerkte_sst END AS A56,
CASE
WHEN A449_anz_maerkte_k_sst = 0 THEN NULL
ELSE A449_anz_maerkte_k_sst END AS A449,
CASE
WHEN A46_max_anz_maerkte_sst = 0 THEN NULL
ELSE A46_max_anz_maerkte_sst END AS A46,
CASE
WHEN A47_max_anz_maerkte_k_sst = 0 THEN NULL
ELSE A47_max_anz_maerkte_k_sst END AS A47,
CASE
WHEN A53_anz_maerkte_listung_gesamt = 0 THEN NULL
ELSE A53_anz_maerkte_listung_gesamt END AS A53,
CASE
WHEN A57_anz_maerkte_listung_einzel = 0 THEN NULL
ELSE A57_anz_maerkte_listung_einzel END AS A57,
CASE
WHEN t1.mandant_id = 1 AND t1.anz_maerkte_baustein_sonstige >0 THEN t1.anz_maerkte_baustein_sonstige
ELSE NULL END AS A444,
CASE
WHEN t1.mandant_id > 1 AND t1.anz_maerkte_baustein_sonstige >0 THEN t1.anz_maerkte_baustein_sonstige
ELSE NULL END AS A55,
CAST (A53_anz_maerkte_listung_gesamt - CASE
WHEN A46_max_anz_maerkte_sst IS NULL THEN '0'
ELSE A46_max_anz_maerkte_sst END - CASE
WHEN A47_max_anz_maerkte_k_sst IS NULL THEN '0'
ELSE A47_max_anz_maerkte_k_sst END AS DEC (18,0)) AS A48,
CAST (CASE
WHEN absatz_sa_kl = 0 THEN NULL
ELSE absatz_sa_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,1)) AS A261,
CAST (((CASE
WHEN absatz_sa_kl = 0 THEN NULL
ELSE absatz_sa_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END)- CASE
WHEN CASE
WHEN absatz_sa_kl_vj = 0 THEN NULL
ELSE absatz_sa_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END = 0 THEN NULL
ELSE CASE
WHEN absatz_sa_kl_vj = 0 THEN NULL
ELSE absatz_sa_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END END)/ CASE
WHEN (CASE
WHEN absatz_sa_kl_vj = 0 THEN NULL
ELSE absatz_sa_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) = 0 THEN NULL
ELSE (CASE
WHEN absatz_sa_kl_vj = 0 THEN NULL
ELSE absatz_sa_kl_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,1)) AS A269,
CAST (CASE
WHEN absatz_sa_kl = 0 THEN NULL
ELSE absatz_sa_kl END / CASE
WHEN A17_absatz_kl = 0 THEN NULL
ELSE A17_absatz_kl END * 100 AS DEC (18,1)) AS A20,
CAST(CASE
WHEN CAST(anz_bons_af AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_af AS DECIMAL(18,4)) END / CASE
WHEN CAST(anz_bons_gesamt AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_gesamt AS DECIMAL(18,4)) END AS DEC (18,4))  AS A348,
CAST(CASE
WHEN CAST(anz_bons_sa AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_sa AS DECIMAL(18,4)) END / CASE
WHEN CAST(anz_bons_gesamt AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_gesamt AS DECIMAL(18,4)) END AS DEC (18,4)) AS A352,
CAST ((A23_rohertrag_ekmep_olk_4n - rohertrag_ekmep_olk_4n_vj) / CASE
WHEN rohertrag_ekmep_olk_4n_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_vj END *100 AS DEC (18,1)) AS A24,
CASE
WHEN A21_kassenumsatz_kl_absolut_netto=0 THEN 0
ELSE CAST (CASE
WHEN rohertrag_ekmep_olk_4n_af = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,2)) END AS A293,
CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa=0 THEN 0
ELSE CAST (CASE
WHEN rohertrag_ekmep_olk_4n_sa = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,2)) END AS A297,
CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af=0 THEN 0
ELSE  CAST (((CASE
WHEN rohertrag_ekmep_olk_4n_af = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END)- CASE
WHEN CASE
WHEN rohertrag_ekmep_olk_4n_af_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END = 0 THEN NULL
ELSE CASE
WHEN rohertrag_ekmep_olk_4n_af_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END END)/ CASE
WHEN (CASE
WHEN rohertrag_ekmep_olk_4n_af_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) = 0 THEN NULL
ELSE (CASE
WHEN rohertrag_ekmep_olk_4n_af_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) END AS A301,
CAST (((CASE
WHEN rohertrag_ekmep_olk_4n_sa = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END)- CASE
WHEN CASE
WHEN rohertrag_ekmep_olk_4n_sa_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END = 0 THEN NULL
ELSE CASE
WHEN rohertrag_ekmep_olk_4n_sa_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END END)/ CASE
WHEN (CASE
WHEN rohertrag_ekmep_olk_4n_sa_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) = 0 THEN NULL
ELSE (CASE
WHEN rohertrag_ekmep_olk_4n_sa_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,1)) AS A305,
CAST (CASE
WHEN kassenumsatz_af_kl_absolut_brutto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_brutto END / CASE
WHEN absatz_af_kl = 0 THEN NULL
ELSE absatz_af_kl END AS DEC (18,2)) AS A372,
CAST ((CASE
WHEN A23_rohertrag_ekmep_olk_4n = 0 THEN NULL
ELSE A23_rohertrag_ekmep_olk_4n END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END)*100 AS DEC (18,2)) AS A25,
CAST ((CASE
WHEN rohertrag_ekmep_olk_4n_af = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af END / CASE
WHEN kassenumsatz_af_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto END)*100 AS DEC (18,2)) AS A26,
CAST ((CASE
WHEN rohertrag_ekmep_olk_4n_sa = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa END / CASE
WHEN kassenumsatz_sa_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto END)*100 AS DEC (18,2)) AS A309,
CAST (CASE
WHEN (A17_absatz_kl - absatz_kl_vj) = 0 THEN NULL
ELSE (A17_absatz_kl - absatz_kl_vj) END / CASE
WHEN absatz_kl_vj = 0 THEN NULL
ELSE absatz_kl_vj END * 100 AS DEC (18,1)) AS A18,
CAST (A21_kassenumsatz_kl_absolut_netto AS DEC (18,0)) AS A21,
CAST (CASE
WHEN kassenumsatz_sa_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,2)) AS A277,
CAST (((CASE
WHEN kassenumsatz_sa_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END)- CASE
WHEN CASE
WHEN kassenumsatz_sa_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END = 0 THEN NULL
ELSE CASE
WHEN kassenumsatz_sa_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END END)/ CASE
WHEN (CASE
WHEN kassenumsatz_sa_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) = 0 THEN NULL
ELSE (CASE
WHEN kassenumsatz_sa_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto_vj END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa_vj = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,2)) AS A289,
CAST (CASE
WHEN (A21_kassenumsatz_kl_absolut_netto - kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE (A21_kassenumsatz_kl_absolut_netto - kassenumsatz_kl_absolut_netto_vj) END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END * 100 AS DEC (18,1)) AS A22,
CAST (A273_kassenumsatz_kl_absolut_brutto AS DEC (18,0)) AS A273,
CAST (A27_totalabschriften_wert_netto_absolut AS DEC (18,0)) AS A27,
CAST (A313_preisabschriften_preisanderungen_wert_netto_absolut AS DEC (18,0)) AS A313,
CAST (CASE
WHEN A313_preisabschriften_preisanderungen_wert_netto_absolut = 0 THEN NULL
ELSE A313_preisabschriften_preisanderungen_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END * 100 AS DEC (18,1)) AS A317,
CAST (CASE
WHEN A27_totalabschriften_wert_netto_absolut = 0 THEN NULL
ELSE A27_totalabschriften_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END * 100 AS DEC (18,1)) AS A28,
CAST (((CASE
WHEN A27_totalabschriften_wert_netto_absolut = 0 THEN NULL
ELSE A27_totalabschriften_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END) - CASE
WHEN CASE
WHEN totalabschriften_wert_netto_absolut_vj = 0 THEN NULL
ELSE totalabschriften_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END = 0 THEN NULL
ELSE CASE
WHEN totalabschriften_wert_netto_absolut_vj = 0 THEN NULL
ELSE totalabschriften_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END END) / CASE
WHEN (CASE
WHEN totalabschriften_wert_netto_absolut_vj = 0 THEN NULL
ELSE totalabschriften_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END) = 0 THEN NULL
ELSE (CASE
WHEN totalabschriften_wert_netto_absolut_vj = 0 THEN NULL
ELSE totalabschriften_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END) END * 100 AS DEC (18,1)) AS A325,
CAST ((((CASE
WHEN A313_preisabschriften_preisanderungen_wert_netto_absolut = 0 THEN NULL
ELSE A313_preisabschriften_preisanderungen_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END) - CASE
WHEN CASE
WHEN preisabschriften_preisanderungen_wert_netto_absolut_vj = 0 THEN NULL
ELSE preisabschriften_preisanderungen_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END = 0 THEN NULL
ELSE CASE
WHEN preisabschriften_preisanderungen_wert_netto_absolut_vj = 0 THEN NULL
ELSE preisabschriften_preisanderungen_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END END) / CASE
WHEN (CASE
WHEN preisabschriften_preisanderungen_wert_netto_absolut_vj = 0 THEN NULL
ELSE preisabschriften_preisanderungen_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END) = 0 THEN NULL
ELSE (CASE
WHEN preisabschriften_preisanderungen_wert_netto_absolut_vj = 0 THEN NULL
ELSE preisabschriften_preisanderungen_wert_netto_absolut_vj END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END) END) * 100 AS DEC (18,1)) AS A329,
CAST (D423_fanquote*100 AS DEC (18,1)) AS D423,
t3.A509_anz_kaeufer AS A509
,CASE WHEN t1.mandant_id > 1 
      THEN t1.A402_kolli_la  
      ELSE CAST (ROUND((1 / CASE WHEN REPLACE(A402_kolli_la,' ','') = 0 
      THEN NULL 
      ELSE REPLACE(A402_kolli_la,' ','') END)) AS DEC(18,0)) END AS A402
,CASE WHEN t1.mandant_id > 1 
      THEN t1.A401_kolli_bst 
      ELSE CAST (ROUND((1 / CASE WHEN REPLACE(A401_kolli_bst,' ','') = 0 
      THEN NULL 
      ELSE REPLACE(A401_kolli_bst,' ','') END)) AS DEC (18,0)) END AS A401,
A403_restlaufzeit_zl AS A403,
A404_restlaufzeit_dz AS A404,
A405_basismengeneinheit AS A405,
CASE
WHEN t1.art_id IS NULL THEN NULL
ELSE A406_letzte_listungsanderung_sst_ksst END AS A406,
A407_verhandler AS A407,
A408_display_Komponente_kz AS A408,
A409_kl_art_id_display AS A409,
A416_artikelrolle_id AS A416,
A339_umsatzsteuer AS A339,
A393_vegan AS A393,
A394_gluten AS A394,
A395_bio AS A395,
CASE
WHEN t1.art_id IS NOT NULL THEN A396_eigenmarke
ELSE CASE
WHEN t1.eigenmarke_fg_nielsen = 1 THEN 'anonymized'
ELSE 'Brand_1' END END AS A396,
A397_tierwohl AS A397,
A398_posten_food AS A398,
A399_posten_nonfood AS A399,
A400_lcf AS A400,
CAST (t10.A415_kannibalisierungsfaktor AS DEC (18,1)) AS A415,
t1.art_id,
nielsen_gtin,
t1.nielsen_art_bez,
t4.cherrypicker_quote AS A356,
t4.kolliabverkaufsquote AS A368,
t4.restbon AS A364
,CAST(t4.index_af_id AS VARCHAR(40)) AS A340
,CAST(t4.index_sa_id AS VARCHAR(40)) AS A344																			 
,CAST ((A27_totalabschriften_wert_netto_absolut / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END) / CASE
WHEN (totalabschriften_wert_netto_absolut_wg / CASE
WHEN kassenumsatz_kl_absolut_netto_wg = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_wg END) = 0 THEN NULL
ELSE (totalabschriften_wert_netto_absolut_wg / CASE
WHEN kassenumsatz_kl_absolut_netto_wg = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_wg END) END AS DEC (18,2)) AS A321,
t5.h452_herstellerwissen,
t6.F49_produktwissen,
t7.C410_lieferantenwissen,
/*, CASE WHEN t8.spr_id =  22  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12*/
/*, CASE WHEN t8.spr_id =  22  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_de*/
/*, CASE WHEN t8.spr_id =  124 OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_cz*/
/*, CASE WHEN t8.spr_id =  108 OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_sk*/
/*, CASE WHEN t8.spr_id =  65  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_hr*/
/*, CASE WHEN t8.spr_id =  90  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_pl*/
/*, CASE WHEN t8.spr_id =  95  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_ro*/
/*, CASE WHEN t8.spr_id =  18  OR t1.art_id IS NULL THEN COALESCE(t8.tupel_bez, t1.nielsen_art_bez) END AS A12_bg*/
COALESCE(t8.tupel_bez, t1.nielsen_art_bez) AS A12,
COALESCE(t8.tupel_bez_de, t1.nielsen_art_bez) AS A12_de,
COALESCE(t8.tupel_bez_cz, t1.nielsen_art_bez) AS A12_cz,
COALESCE(t8.tupel_bez_sk, t1.nielsen_art_bez) AS A12_sk,
COALESCE(t8.tupel_bez_hr, t1.nielsen_art_bez) AS A12_hr,
COALESCE(t8.tupel_bez_pl, t1.nielsen_art_bez) AS A12_pl,
COALESCE(t8.tupel_bez_ro, t1.nielsen_art_bez) AS A12_ro,
COALESCE(t8.tupel_bez_bg, t1.nielsen_art_bez) AS A12_bg,
t9.tupel_tag
FROM dbp_msi_v_view.v_tupel_mat_1 t1_1
LEFT JOIN dbp_view.v_zek_1 t2
ON t1.mandant_id=t2.mandant_id
AND t1.a389_zek_id=t2.zek_id
LEFT JOIN dbp_view.v_fanquote_1 t3
ON t1.mandant_id=t3.mandant_id
AND t1.matching_id=t3.matching_id
AND t1.A500_kjwo_update=t3.kjwo_update
LEFT JOIN dbp_view.v_sortiment_leistung_1 t4
ON t1.mandant_id = t4.mandant_id
AND t1.A425_kjmo = t4.kjmo
AND t1.a500_kjwo_update = t4.kjwo_update
AND t1.matching_id = t4.matching_id
LEFT JOIN dbp_msi_v_view.v_herstellerwissen_1 t5
ON t1.mandant_id = t5.mandant_id
AND t1.A419_hersteller_id = TO_VARCHAR(t5.gp_id)
LEFT JOIN dbp_msi_v_view.v_produktwissen_1 t6
ON t1.mandant_id = t6.mandant_id
AND t1.matching_id = t6.matching_id
LEFT JOIN dbp_msi_v_view.v_lieferantenwissen_1 t7
ON t1.mandant_id=t2.mandant_id
AND COALESCE(t1.A16_akt_lieferant_id,t1.lieferant_nielsen) = t7.lieferant
LEFT JOIN (SELECT
mandant_id,
matching_id,
kjwo_update,
MAX(CASE
WHEN spr_id =  22 THEN tupel_bez END) AS tupel_bez,
MAX(CASE
WHEN spr_id =  22 THEN tupel_bez END) AS tupel_bez_de,
MAX(CASE
WHEN spr_id =  124 THEN tupel_bez END) AS tupel_bez_cz,
MAX(CASE
WHEN spr_id =  108 THEN tupel_bez END) AS tupel_bez_sk,
Max(CASE
WHEN spr_id =  65 THEN tupel_bez END) AS tupel_bez_hr,
MAX(CASE
WHEN spr_id =  90 THEN tupel_bez END) AS tupel_bez_pl,
MAX(CASE
WHEN spr_id =  95 THEN tupel_bez END) AS tupel_bez_ro,
MAX(CASE
WHEN spr_id =  18 THEN tupel_bez END) AS tupel_bez_bg
FROM dbp_view.v_tupel_spr_zu_1
GROUP BY 1,2,3
) t8 --DBP_VIEW.v_tupel_spr_zu_1 t8
ON t8.mandant_id = t1.mandant_id
AND t8.matching_id = t1.matching_id
AND t8.kjwo_update = t1.a500_kjwo_update
LEFT JOIN dbp_msi_v_view.v_tupel_tags_1 t9
ON t1.mandant_id = t9.mandant_id
AND t1.matching_id = t9.matching_id
LEFT JOIN 
(SELECT *
FROM DBP_MSI_DATA.TUPEL_MAT_FORECAST_1
QUALIFY ROW_NUMBER() OVER (PARTITION BY MANDANT_ID, A500_KJWO_UPDATE, MATCHING_ID ORDER BY EXECUTION_TIMESTAMP DESC) = 1) t10
ON t1.mandant_id = t10.mandant_id
AND t1.a500_kjwo_update = t10.a500_kjwo_update
AND t1.matching_id = t10.matching_id;