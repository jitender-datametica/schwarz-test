CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_MAT
(
	MANDANT_ID,
	A425,
	A500,
	A424,
	A5,
	A7,
	A9,
	WUG_ID,
	MATCHING_ID,
	TUPEL_TYP,
	A1,
	A58,
	A2,
	A59,
	A11,
	A450,
	A12,
	A14,
	A15,
	A3,
	A16,
	LIEFERANT_LIEFERANTENWISSEN,
	A419,
	A421,
	A446,
	A447,
	A448,
	A60,
	A61,
	A510,
	A511,
	A512,
	A513,
	A389,
	A390,
	A391,
	A392,
	A281,
	A285,
	A19,
	A265,
	A17,
	A76,
	A78,
	A80,
	A82,
	A84,
	A86,
	A88,
	A62,
	A64,
	A66,
	A68,
	A70,
	A72,
	A74,
	A90,
	A92,
	A94,
	A96,
	A98,
	A100,
	A77,
	A79,
	A81,
	A83,
	A85,
	A87,
	A89,
	A63,
	A65,
	A67,
	A69,
	A71,
	A73,
	A75,
	A91,
	A93,
	A95,
	A97,
	A99,
	A101,
	A360,
	A31,
	A333,
	A54,
	A334,
	A432,
	A433,
	A434,
	A435,
	A436,
	A437,
	A30,
	A335,
	A438,
	A336,
	A337,
	A439,
	A440,
	A441,
	A338,
	A442,
	A443,
	A23,
	A29,
	A51,
	A52,
	A426,
	A427,
	A428,
	A429,
	A430,
	A431,
	A50,
	A411,
	A412,
	A413,
	A414,
	A36,
	A32,
	A33,
	A34,
	A35,
	A378,
	A379,
	A376,
	A380,
	A377,
	A383,
	A384,
	A385,
	A386,
	A387,
	A388,
	A381,
	A39,
	A38,
	A40,
	A41,
	A42,
	A43,
	A44,
	A45,
	A37,
	A56,
	A449,
	A46,
	A47,
	A53,
	A57,
	A444,
	A55,
	A48,
	A261,
	A269,
	A20,
	A348,
	A352,
	A24,
	A293,
	A297,
	A301,
	A305,
	A372,
	A25,
	A26,
	A309,
	A18,
	A21,
	A277,
	A289,
	A22,
	A273,
	A27,
	A313,
	A317,
	A28,
	A325,
	A329,
	D423,
	A509,
	A402,
	A401,
	A403,
	A404,
	A405,
	A406,
	A407,
	A408,
	A409,
	A416,
	A339,
	A393,
	A394,
	A395,
	A396,
	A397,
	A398,
	A399,
	A400,
	A415,
	ART_ID,
	NIELSEN_GTIN,
	NIELSEN_ART_BEZ,
	A356,
	A368,
	A364,
	A340,
	A344,
	A321,
	A445,
	A514,
	A519,
	A520,
	A471,
	A515,
	A516,
	A517,
	A518,
	A521,
	A382,
	SUBSTITUTE_COUNT
) 
AS
SELECT
t1.mandant_id
,A425_kjmo AS A425
,t1.A500_kjwo_update AS A500
,t1.wrg_id AS A424
,A5_owg_id AS A5
,A7_wg_id AS A7
,CASE
WHEN a7_wg_id < 10 THEN '00' || CAST(a7_wg_id AS VARCHAR(3))
WHEN a7_wg_id < 100 THEN '0' || CAST(a7_wg_id AS VARCHAR(3))
ELSE CAST(a7_wg_id AS VARCHAR(3)) END || CASE
WHEN t1.wug_id < 10 THEN '00' || CAST(t1.wug_id AS VARCHAR(3))
WHEN t1.wug_id < 100 THEN '0' || CAST(t1.wug_id AS VARCHAR(3))
ELSE CAST(t1.wug_id AS VARCHAR(3)) END  A9
,t1.wug_id AS wug_id
,t1.matching_id
,t1.tupel_typ
,t1.tupel_typ AS A1
,A58_rang_umsatz_owg AS A58
,A2_rang_umsatz_wg AS A2
,A59_rang_absatz_wg AS A59
,CASE
WHEN t1.art_id IS NULL THEN nielsen_gtin
ELSE t1.kl_art_id END AS A11
,A450_art_nielsen_nr AS A450
,CASE
WHEN t1.nielsen_art_bez IS NULL THEN ''
ELSE t1.nielsen_art_bez END AS A12
,CASE
WHEN t1.art_id IS NULL THEN t1.nielsen_art_bez
ELSE art_bez_deutsch END AS A14


,CASE
WHEN TRIM(a14_art_status_de) IN ('R','L') THEN TRIM(a14_art_status_de)
ELSE '' END AS A15
,CASE
WHEN t6.A50_listungsaktion IS NULL OR TRIM(t6.A50_listungsaktion) = '' THEN 0
ELSE 1 END AS A3 

,A16_akt_lieferant_id AS A16
,COALESCE(A16_akt_lieferant_id,lieferant_nielsen) AS lieferant_lieferantenwissen
,A419_hersteller_id AS A419
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

,CASE
WHEN A447_hersteller_bez_latein IS NULL THEN ''
ELSE A447_hersteller_bez_latein END AS A447

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
 END AS A448 
,CASE                
WHEN A60_muki_vk_kz IS NULL THEN ''
ELSE A60_muki_vk_kz END AS A60
,CASE
WHEN A61_muki_vk_kl_art_id_verkettung IS NULL THEN ''
ELSE A61_muki_vk_kl_art_id_verkettung END AS A61
,CASE WHEN A510_MUKI_EK_KZ IS NULL THEN '' ELSE A510_MUKI_EK_KZ END AS A510
,CASE WHEN A511_MUKI_EK_KL_ART_ID_VERKETTUNG IS NULL THEN '' ELSE A511_MUKI_EK_KL_ART_ID_VERKETTUNG END AS A511
,CASE WHEN A512_MUKI_WB_KZ IS NULL THEN '' ELSE A512_MUKI_WB_KZ END AS A512
,CASE WHEN A513_MUKI_WB_KL_ART_ID_VERKETTUNG IS NULL THEN '' ELSE A513_MUKI_WB_KL_ART_ID_VERKETTUNG END AS A513
,A389_zek_id AS A389
,t2.zek_name AS A390
,CASE
WHEN A391_disc_pe = 0 OR A391_disc_pe IS NULL THEN NULL


ELSE TRIM (A391_disc_pe) END AS A391
,CASE
WHEN A392_disc_ohne_etikett = 0 OR A392_disc_ohne_etikett IS NULL THEN NULL


ELSE TRIM (A392_disc_ohne_etikett) END AS A392
,CAST(CASE
WHEN kassenumsatz_af_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,1)) AS A281
,CAST(((kassenumsatz_af_kl_absolut_netto / CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) AS A285
,CAST (CASE
WHEN absatz_af_kl = 0 THEN NULL
ELSE absatz_af_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,1)) AS A19
,CAST (((CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) AS A265
,CAST (A17_absatz_kl AS DEC (18,0)) AS A17
,CAST (A76_absatz_sst1 AS DEC (18,0)) AS A76
,CAST (A78_absatz_sst2 AS DEC (18,0)) AS A78
,CAST (A80_absatz_sst3 AS DEC (18,0)) AS A80
,CAST (A82_absatz_sst4 AS DEC (18,0)) AS A82
,CAST (A84_absatz_sst5 AS DEC (18,0)) AS A84
,CAST (A86_absatz_sst6 AS DEC (18,0)) AS A86
,CAST (A88_absatz_sst7 AS DEC (18,0)) AS A88
,CAST (A62_absatz_ksst1 AS DEC (18,0)) AS A62
,CAST (A64_absatz_ksst2 AS DEC (18,0)) AS A64
,CAST (A66_absatz_ksst3 AS DEC (18,0)) AS A66
,CAST (A68_absatz_ksst4 AS DEC (18,0)) AS A68
,CAST (A70_absatz_ksst5 AS DEC (18,0)) AS A70
,CAST (A72_absatz_ksst6 AS DEC (18,0)) AS A72
,CAST (A74_absatz_ksst7 AS DEC (18,0)) AS A74
,CAST (A90_absatz_ost_basis AS DEC (18,0)) AS A90
,CAST (A92_absatz_ost_gross AS DEC (18,0)) AS A92
,CAST (A94_absatz_sued_ost AS DEC (18,0)) AS A94
,CAST (A96_absatz_sued_west AS DEC (18,0)) AS A96
,CAST (A98_absatz_west AS DEC (18,0)) AS A98
,CAST (A100_absatz_nord AS DEC (18,0)) AS A100
,CAST (CASE
WHEN A76_absatz_sst1 = 0 THEN NULL
ELSE A76_absatz_sst1 END / CASE
WHEN markt_wochen_sst1 = 0 THEN NULL
ELSE markt_wochen_sst1 END AS DEC (18,1)) AS A77
,CAST (CASE
WHEN A78_absatz_sst2 = 0 THEN NULL
ELSE A78_absatz_sst2 END / CASE
WHEN markt_wochen_sst2 = 0 THEN NULL
ELSE markt_wochen_sst2 END AS DEC (18,1)) AS A79
,CAST (CASE
WHEN A80_absatz_sst3 = 0 THEN NULL
ELSE A80_absatz_sst3 END / CASE
WHEN markt_wochen_sst3 = 0 THEN NULL
ELSE markt_wochen_sst3 END AS DEC (18,1)) AS A81
,CAST (CASE
WHEN A82_absatz_sst4 = 0 THEN NULL
ELSE A82_absatz_sst4 END / CASE
WHEN markt_wochen_sst4 = 0 THEN NULL
ELSE markt_wochen_sst4 END AS DEC (18,1)) AS A83
,CAST (CASE
WHEN A84_absatz_sst5 = 0 THEN NULL
ELSE A84_absatz_sst5 END / CASE
WHEN markt_wochen_sst5 = 0 THEN NULL
ELSE markt_wochen_sst5 END AS DEC (18,1)) AS A85
,CAST (CASE
WHEN A86_absatz_sst6 = 0 THEN NULL
ELSE A86_absatz_sst6 END / CASE
WHEN markt_wochen_sst6 = 0 THEN NULL
ELSE markt_wochen_sst6 END AS DEC (18,1)) AS A87
,CAST (CASE
WHEN A88_absatz_sst7 = 0 THEN NULL
ELSE A88_absatz_sst7 END / CASE
WHEN markt_wochen_sst7 = 0 THEN NULL
ELSE markt_wochen_sst7 END AS DEC (18,1)) AS A89
,CAST (CASE
WHEN A62_absatz_ksst1 = 0 THEN NULL
ELSE A62_absatz_ksst1 END / CASE
WHEN markt_wochen_ksst1 = 0 THEN NULL
ELSE markt_wochen_ksst1 END AS DEC (18,1)) AS A63
,CAST (CASE
WHEN A64_absatz_ksst2 = 0 THEN NULL
ELSE A64_absatz_ksst2 END / CASE
WHEN markt_wochen_ksst2 = 0 THEN NULL
ELSE markt_wochen_ksst2 END AS DEC (18,1)) AS A65
,CAST (CASE
WHEN A66_absatz_ksst3 = 0 THEN NULL
ELSE A66_absatz_ksst3 END / CASE
WHEN markt_wochen_ksst3 = 0 THEN NULL
ELSE markt_wochen_ksst3 END AS DEC (18,1)) AS A67
,CAST (CASE
WHEN A68_absatz_ksst4 = 0 THEN NULL
ELSE A68_absatz_ksst4 END / CASE
WHEN markt_wochen_ksst4 = 0 THEN NULL
ELSE markt_wochen_ksst4 END AS DEC (18,1)) AS A69
,CAST (CASE
WHEN A70_absatz_ksst5 = 0 THEN NULL
ELSE A70_absatz_ksst5 END / CASE
WHEN markt_wochen_ksst5 = 0 THEN NULL
ELSE markt_wochen_ksst5 END AS DEC (18,1)) AS A71
,CAST (CASE
WHEN A72_absatz_ksst6 = 0 THEN NULL
ELSE A72_absatz_ksst6 END / CASE
WHEN markt_wochen_ksst6 = 0 THEN NULL
ELSE markt_wochen_ksst6 END AS DEC (18,1)) AS A73
,CAST (CASE
WHEN A74_absatz_ksst7 = 0 THEN NULL
ELSE A74_absatz_ksst7 END / CASE
WHEN markt_wochen_ksst7 = 0 THEN NULL
ELSE markt_wochen_ksst7 END AS DEC (18,1)) AS A75
,CAST (CASE
WHEN A90_absatz_ost_basis = 0 THEN NULL
ELSE A90_absatz_ost_basis END / CASE
WHEN markt_wochen_ost_basis = 0 THEN NULL
ELSE markt_wochen_ost_basis END AS DEC (18,1)) AS A91
,CAST (CASE
WHEN A92_absatz_ost_gross = 0 THEN NULL
ELSE A92_absatz_ost_gross END / CASE
WHEN markt_wochen_ost_gross = 0 THEN NULL
ELSE markt_wochen_ost_gross END AS DEC (18,1)) AS A93
,CAST (CASE
WHEN A94_absatz_sued_ost = 0 THEN NULL
ELSE A94_absatz_sued_ost END / CASE
WHEN markt_wochen_sued_ost = 0 THEN NULL
ELSE markt_wochen_sued_ost END AS DEC (18,1)) AS A95
,CAST (CASE
WHEN A96_absatz_sued_west = 0 THEN NULL
ELSE A96_absatz_sued_west END / CASE
WHEN markt_wochen_sued_west = 0 THEN NULL
ELSE markt_wochen_sued_west END AS DEC (18,1)) AS A97
,CAST (CASE
WHEN A98_absatz_west = 0 THEN NULL
ELSE A98_absatz_west END / CASE
WHEN markt_wochen_west = 0 THEN NULL
ELSE markt_wochen_west END AS DEC (18,1)) AS A99
,CAST (CASE
WHEN A100_absatz_nord = 0 THEN NULL
ELSE A100_absatz_nord END / CASE
WHEN markt_wochen_nord = 0 THEN NULL
ELSE markt_wochen_nord END AS DEC (18,1)) AS A101
,CAST (CAST(anzahl_markt_wochen_kombis_abverkauf_mit_listung AS DEC (18,4)) / CASE
WHEN anzahl_markt_wochen_kombis_listung = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_listung END *100 AS DEC (18,1)) AS A360
,CAST (A31_vk_brutto_kl_pk_1 AS DEC (18,2)) AS A31
,CAST (A333_vk_brutto_kl_pk_2 AS DEC (18,2)) AS A333
,CAST (A54_vk_brutto_kl_pk_3 AS DEC (18,2)) AS A54
,CAST (A334_vk_brutto_kl_pk_4 AS DEC (18,2)) AS A334
,CAST (A432_vk_brutto_kl_pk_5 AS DEC (18,2)) AS A432
,CAST (A433_vk_brutto_kl_pk_6 AS DEC (18,2)) AS A433
,CAST (A434_vk_brutto_kl_pk_7 AS DEC (18,2)) AS A434
,CAST (A435_vk_brutto_kl_pk_8 AS DEC (18,2)) AS A435
,CAST (A436_vk_brutto_kl_pk_9 AS DEC (18,2)) AS A436
,CAST (A437_vk_brutto_kl_pk_10 AS DEC (18,2)) AS A437
,CAST (A30_KB_oLK_EK4ndz_Stamm AS DEC (18,2)) AS A30
,CAST(CASE
WHEN (A31_vk_brutto_kl_pk_1 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A31_vk_brutto_kl_pk_1 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A31_vk_brutto_kl_pk_1 = 0 THEN NULL
ELSE A31_vk_brutto_kl_pk_1 END * 100 AS DEC (18,2)) AS A335
,CAST(CASE
WHEN (A333_vk_brutto_kl_pk_2 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A333_vk_brutto_kl_pk_2 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A333_vk_brutto_kl_pk_2 = 0 THEN NULL
ELSE A333_vk_brutto_kl_pk_2 END * 100 AS DEC (18,2)) AS A438
,CAST(CASE
WHEN (A54_vk_brutto_kl_pk_3 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A54_vk_brutto_kl_pk_3 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A54_vk_brutto_kl_pk_3 = 0 THEN NULL
ELSE A54_vk_brutto_kl_pk_3 END * 100 AS DEC (18,2)) AS A336
,CAST(CASE
WHEN (A334_vk_brutto_kl_pk_4 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A334_vk_brutto_kl_pk_4 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A334_vk_brutto_kl_pk_4 = 0 THEN NULL
ELSE A334_vk_brutto_kl_pk_4 END * 100 AS DEC (18,2)) AS A337
,CAST(CASE
WHEN (A432_vk_brutto_kl_pk_5 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A432_vk_brutto_kl_pk_5 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A432_vk_brutto_kl_pk_5 = 0 THEN NULL
ELSE A432_vk_brutto_kl_pk_5 END * 100 AS DEC (18,2)) AS A439
,CAST(CASE
WHEN (A433_vk_brutto_kl_pk_6 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A433_vk_brutto_kl_pk_6 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A433_vk_brutto_kl_pk_6 = 0 THEN NULL
ELSE A433_vk_brutto_kl_pk_6 END * 100 AS DEC (18,2)) AS A440
,CAST(CASE
WHEN (A434_vk_brutto_kl_pk_7 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A434_vk_brutto_kl_pk_7 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A434_vk_brutto_kl_pk_7 = 0 THEN NULL
ELSE A434_vk_brutto_kl_pk_7 END * 100 AS DEC (18,2)) AS A441
,CAST(CASE
WHEN (A435_vk_brutto_kl_pk_8 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A435_vk_brutto_kl_pk_8 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A435_vk_brutto_kl_pk_8 = 0 THEN NULL
ELSE A435_vk_brutto_kl_pk_8 END * 100 AS DEC (18,2)) AS A338
,CAST(CASE
WHEN (A436_vk_brutto_kl_pk_9 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A436_vk_brutto_kl_pk_9 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A436_vk_brutto_kl_pk_9 = 0 THEN NULL
ELSE A436_vk_brutto_kl_pk_9 END * 100 AS DEC (18,2)) AS A442
,CAST(CASE
WHEN (A437_vk_brutto_kl_pk_10 - A30_KB_oLK_EK4ndz_Stamm) = 0 THEN NULL
ELSE (A437_vk_brutto_kl_pk_10 - A30_KB_oLK_EK4ndz_Stamm) END / CASE
WHEN A437_vk_brutto_kl_pk_10 = 0 THEN NULL
ELSE A437_vk_brutto_kl_pk_10 END * 100 AS DEC (18,2)) AS A443
,CAST (A23_rohertrag_ekmep_olk_4n AS DEC (18,0)) AS A23
,CAST ((A21_kassenumsatz_kl_absolut_netto - A23_rohertrag_ekmep_olk_4n)  / CASE
WHEN A17_absatz_kl = 0 THEN NULL
ELSE A17_absatz_kl END AS DEC (18,2)) AS A29
,t6.A51_listung_sst_pflege AS A51
,t6.A52_listung_k_sst_pflege AS A52
,CASE
WHEN t6.A426_ost_basis_pflege = 'X' THEN t6.A426_ost_basis_pflege
ELSE NULL END AS A426
,CASE
WHEN t6.A427_ost_gross_pflege = 'X' THEN t6.A427_ost_gross_pflege
ELSE NULL END AS A427
,CASE
WHEN t6.A428_sued_ost_pflege = 'X' THEN  t6.A428_sued_ost_pflege
ELSE NULL END AS A428
,CASE
WHEN t6.A429_sued_west_pflege = 'X' THEN t6.A429_sued_west_pflege
ELSE NULL END  AS A429
,CASE
WHEN t6.A430_west_pflege = 'X' THEN t6.A430_west_pflege
ELSE NULL END AS A430
,CASE
WHEN t6.A431_nord_pflege = 'X' THEN t6.A431_nord_pflege
ELSE NULL END AS A431
,t6.A50_listungsaktion AS A50

,t6.A411_stk_rohertrag_pflege AS A411
,CASE
WHEN t6.A415_kannibalisierungsfaktor>0 THEN CAST (t6.A412_umsatz_brutto_hochrechnung*t6.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t6.A412_umsatz_brutto_hochrechnung*1 AS DEC (18,0)) END AS A412
,CASE
WHEN t6.A415_kannibalisierungsfaktor>0 THEN CAST (t6.A413_absatz_hochrechnung*t6.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t6.A413_absatz_hochrechnung*1 AS DEC (18,0)) END AS A413
,CASE
WHEN t6.A415_kannibalisierungsfaktor>0 THEN CAST (t6.A414_rohertrag_hochrechnung*t6.A415_kannibalisierungsfaktor AS DEC (18,0))
ELSE CAST (t6.A414_rohertrag_hochrechnung*1 AS DEC (18,0)) END AS A414
,CAST (A36_gewichtete_distribution_nielsen AS DEC (18,1)) AS A36
,CAST (A32_umsatz_anteil_wgi_nielsen AS DEC (18,1)) AS A32
,CAST (A33_umsatz_anteil_wgi_kumuliert_nielsen AS DEC (18,1)) AS A33
,CAST (A34_vk_brutto_durchschnitt_nielsen AS DEC (18,2)) AS A34
,CAST (A35_umsatz_nielsen AS DEC (18,0)) AS A35
,CASE
WHEN t1.mandant_id = 1 THEN anz_wochen_de_anz_monate_kmo_nielsen
ELSE NULL END AS A378
,CASE
WHEN t1.mandant_id > 1 THEN anz_wochen_de_anz_monate_kmo_nielsen
ELSE NULL END AS A379
,CASE
WHEN CAST (A376_kl_marktanteil_wg_nielsen AS DEC (18,1)) >0 THEN A376_kl_marktanteil_wg_nielsen
ELSE NULL END AS A376
,CASE
WHEN A380_marktanteilbewertung_nielsen > 0 THEN A380_marktanteilbewertung_nielsen
ELSE NULL END AS A380
,CAST (A377_durchschnitt_anz_maerkte_nielsen AS DEC (18,1)) AS A377
,CAST (A383_sales_units_verkaufseinheiten_Gl_in_1000_normiert_nielsen AS DEC (18,0)) AS A383
,CAST (A384_durchschn_preis_einheit_gl_normiert_nielsen AS DEC (18,2)) AS A384
,CAST (A385_numerische_distribution_nielsen AS DEC (18,1)) AS A385
,A386_inhaltsmengen_nielsen AS A386
,CASE
WHEN A387_duft_geschmack_nielsen IS NULL THEN ''
ELSE A387_duft_geschmack_nielsen END AS A387
,CASE
WHEN A388_einheit_nielsen IS NULL THEN ''
ELSE A388_einheit_nielsen END AS A388
,A381_preislagenverteilung AS A381
,CASE  WHEN t1.mandant_id > 1 
	   THEN NVL(t1.A39_listung_sst_mvke,'')
	   ELSE NVL2(NULLIF(NULLIF(t1.A39_listung_sst_mvke,'R'),'N/A'),'K' || t1.A39_listung_sst_mvke,'')
 END AS A39
,CASE
WHEN A38_listung_k_sst_mvke IS NULL THEN ''
ELSE A38_listung_k_sst_mvke END AS A38
,CASE
WHEN A40_ost_basis IS NULL THEN ''
ELSE A40_ost_basis END AS A40
,CASE
WHEN A41_ost_gross IS NULL THEN ''
ELSE A41_ost_gross END AS A41
,CASE
WHEN A42_sued_ost IS NULL THEN ''
ELSE A42_sued_ost END AS A42
,CASE
WHEN A43_sued_west IS NULL THEN ''
ELSE A43_sued_west END AS A43
,CASE
WHEN A44_west IS NULL THEN ''
ELSE A44_west END AS A44
,CASE
WHEN A45_nord IS NULL THEN ''
ELSE A45_nord END AS A45
,CASE
WHEN t1.art_id IS NULL THEN NULL
ELSE A37_listung_erster_markt END AS A37
,CASE
WHEN A59_anz_maerkte_sst = 0 THEN NULL
ELSE A59_anz_maerkte_sst END AS A56
,CASE
WHEN A449_anz_maerkte_k_sst = 0 THEN NULL
ELSE A449_anz_maerkte_k_sst END AS A449
,CASE
WHEN A46_max_anz_maerkte_sst = 0 THEN NULL
ELSE A46_max_anz_maerkte_sst END AS A46
,CASE
WHEN A47_max_anz_maerkte_k_sst = 0 THEN NULL
ELSE A47_max_anz_maerkte_k_sst END AS A47
,CASE
WHEN A53_anz_maerkte_listung_gesamt = 0 THEN NULL
ELSE A53_anz_maerkte_listung_gesamt END AS A53
,CASE
WHEN A57_anz_maerkte_listung_einzel = 0 THEN NULL
ELSE A57_anz_maerkte_listung_einzel END AS A57
,CASE
WHEN t1.mandant_id = 1 AND t1.anz_maerkte_baustein_sonstige >0 THEN t1.anz_maerkte_baustein_sonstige
ELSE NULL END AS A444
,CASE
WHEN t1.mandant_id > 1 AND t1.anz_maerkte_baustein_sonstige >0 THEN t1.anz_maerkte_baustein_sonstige
ELSE NULL END AS A55
,CAST (A53_anz_maerkte_listung_gesamt - CASE
WHEN A46_max_anz_maerkte_sst IS NULL THEN '0'
ELSE A46_max_anz_maerkte_sst END - CASE
WHEN A47_max_anz_maerkte_k_sst IS NULL THEN '0'
ELSE A47_max_anz_maerkte_k_sst END AS DEC (18,0)) AS A48
,CAST (CASE
WHEN absatz_sa_kl = 0 THEN NULL
ELSE absatz_sa_kl END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,1)) AS A261
,CAST (((CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,1)) AS A269
,CAST (CASE
WHEN absatz_sa_kl = 0 THEN NULL
ELSE absatz_sa_kl END / CASE
WHEN A17_absatz_kl = 0 THEN NULL
ELSE A17_absatz_kl END * 100 AS DEC (18,1)) AS A20
,CAST((CASE
WHEN CAST(anz_bons_af AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_af AS DECIMAL(18,4)) END / CASE
WHEN CAST(ANZ_BONS_AF_MARKT_TAG AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(ANZ_BONS_AF_MARKT_TAG AS DECIMAL(18,4)) END) * 100 AS DEC (18,4))  AS A348
,CAST((CASE
WHEN CAST(anz_bons_sa AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(anz_bons_sa AS DECIMAL(18,4)) END / CASE
WHEN CAST(ANZ_BONS_SA_MARKT_TAG AS DECIMAL(18,4)) = 0 THEN NULL
ELSE CAST(ANZ_BONS_SA_MARKT_TAG AS DECIMAL(18,4)) END) * 100 AS DEC (18,4)) AS A352
,CAST ((A23_rohertrag_ekmep_olk_4n - rohertrag_ekmep_olk_4n_vj) / CASE
WHEN rohertrag_ekmep_olk_4n_vj = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_vj END *100 AS DEC (18,1)) AS A24
,CASE
WHEN A21_kassenumsatz_kl_absolut_netto=0 THEN 0
ELSE CAST (CASE
WHEN rohertrag_ekmep_olk_4n_af = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_af = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_af END AS DEC (18,2)) END AS A293
,CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa=0 THEN 0
ELSE CAST (CASE
WHEN rohertrag_ekmep_olk_4n_sa = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,2)) END AS A297
,CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_af_vj END) END*100 AS DEC (18,1)) END AS A301
,CAST (((CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,1)) AS A305
,CAST (CASE
WHEN kassenumsatz_af_kl_absolut_brutto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_brutto END / CASE
WHEN absatz_af_kl = 0 THEN NULL
ELSE absatz_af_kl END AS DEC (18,2)) AS A372
,CAST ((CASE
WHEN A23_rohertrag_ekmep_olk_4n = 0 THEN NULL
ELSE A23_rohertrag_ekmep_olk_4n END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END)*100 AS DEC (18,2)) AS A25
,CAST ((CASE
WHEN rohertrag_ekmep_olk_4n_af = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_af END / CASE
WHEN kassenumsatz_af_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_af_kl_absolut_netto END)*100 AS DEC (18,2)) AS A26
,CAST ((CASE
WHEN rohertrag_ekmep_olk_4n_sa = 0 THEN NULL
ELSE rohertrag_ekmep_olk_4n_sa END / CASE
WHEN kassenumsatz_sa_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto END)*100 AS DEC (18,2)) AS A309
,CAST (CASE
WHEN (A17_absatz_kl - absatz_kl_vj) = 0 THEN NULL
ELSE (A17_absatz_kl - absatz_kl_vj) END / CASE
WHEN absatz_kl_vj = 0 THEN NULL
ELSE absatz_kl_vj END * 100 AS DEC (18,1)) AS A18,
CAST (A21_kassenumsatz_kl_absolut_netto AS DEC (18,0)) AS A21
,CAST (CASE
WHEN kassenumsatz_sa_kl_absolut_netto = 0 THEN NULL
ELSE kassenumsatz_sa_kl_absolut_netto END / CASE
WHEN anzahl_markt_wochen_kombis_abverkauf_sa = 0 THEN NULL
ELSE anzahl_markt_wochen_kombis_abverkauf_sa END AS DEC (18,2)) AS A277
,CAST (((CASE
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
ELSE anzahl_markt_wochen_kombis_abverkauf_sa_vj END) END*100 AS DEC (18,2)) AS A289
,CAST (CASE
WHEN (A21_kassenumsatz_kl_absolut_netto - kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE (A21_kassenumsatz_kl_absolut_netto - kassenumsatz_kl_absolut_netto_vj) END / CASE
WHEN kassenumsatz_kl_absolut_netto_vj = 0 THEN NULL
ELSE kassenumsatz_kl_absolut_netto_vj END * 100 AS DEC (18,1)) AS A22
,CAST (A273_kassenumsatz_kl_absolut_brutto AS DEC (18,0)) AS A273
,CAST (A27_totalabschriften_wert_netto_absolut AS DEC (18,0)) AS A27
,CAST (A313_preisabschriften_preisanderungen_wert_netto_absolut AS DEC (18,0)) AS A313
,CAST (CASE
WHEN A313_preisabschriften_preisanderungen_wert_netto_absolut = 0 THEN NULL
ELSE A313_preisabschriften_preisanderungen_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END * 100 AS DEC (18,1)) AS A317
,CAST (CASE
WHEN A27_totalabschriften_wert_netto_absolut = 0 THEN NULL
ELSE A27_totalabschriften_wert_netto_absolut END / CASE
WHEN A21_kassenumsatz_kl_absolut_netto = 0 THEN NULL
ELSE A21_kassenumsatz_kl_absolut_netto END * 100 AS DEC (18,1)) AS A28
,CAST (((CASE
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
ELSE kassenumsatz_kl_absolut_netto_vj END) END * 100 AS DEC (18,1)) AS A325
,CAST ((((CASE
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
ELSE kassenumsatz_kl_absolut_netto_vj END) END) * 100 AS DEC (18,1)) AS A329
,CAST (D423_fanquote*100 AS DEC (18,1)) AS D423
,t3.A509_anz_kaeufer AS A509
,CASE WHEN t1.mandant_id > 1 
      THEN t1.A402_kolli_la  
      ELSE CAST (ROUND((1 / CASE WHEN REPLACE(A402_kolli_la,' ','') = 0 
      THEN NULL 
      ELSE REPLACE(A402_kolli_la,' ','') END)) AS DEC(18,0)) END AS A402
,CASE WHEN t1.mandant_id > 1 
      THEN t1.A401_kolli_bst 
      ELSE CAST (ROUND((1 / CASE WHEN REPLACE(A401_kolli_bst,' ','') = 0 
      THEN NULL 
      ELSE REPLACE(A401_kolli_bst,' ','') END)) AS DEC (18,0)) END AS A401
,A403_restlaufzeit_zl AS A403
,A404_restlaufzeit_dz AS A404
,CASE
WHEN A405_basismengeneinheit IS NULL THEN ''
ELSE A405_basismengeneinheit END AS A405
,CASE
WHEN t1.art_id IS NULL THEN NULL
ELSE A406_letzte_listungsanderung_sst_ksst END AS A406
,CASE
WHEN A407_verhandler IS NULL THEN ''
ELSE A407_verhandler END AS A407
,CASE
WHEN A408_display_Komponente_kz IS NULL THEN ''
ELSE A408_display_Komponente_kz END AS A408
,CASE
WHEN A409_kl_art_id_display IS NULL THEN ''
ELSE A409_kl_art_id_display END AS A409
,CASE
WHEN A416_artikelrolle_id IS NULL THEN ''
ELSE A416_artikelrolle_id END AS A416
,A339_umsatzsteuer AS A339
,CASE
WHEN A393_vegan IN ('1','X') THEN 'X'
ELSE '' END AS A393
,CASE
WHEN A394_gluten IN ('1','X') THEN 'X'
ELSE '' END AS A394
,CASE
WHEN A395_bio IN ('1','X') THEN 'X'
ELSE '' END AS A395
,CASE
WHEN t1.art_id IS NOT NULL THEN CASE
WHEN A396_eigenmarke IS NULL THEN ''
ELSE A396_eigenmarke END
ELSE CASE
WHEN t1.eigenmarke_fg_nielsen = 1 THEN 'anonymized'
ELSE 'Brand' END END AS A396
,CASE
WHEN A397_tierwohl IS NULL THEN ''
ELSE A397_tierwohl END AS A397
,CASE
WHEN A398_posten_food IS NULL THEN ''
ELSE A398_posten_food END AS A398
,CASE
WHEN A399_posten_nonfood IS NULL THEN ''
ELSE A399_posten_nonfood END AS A399
,CASE
WHEN A400_lcf IN ('1','X') THEN 'X'
ELSE '' END AS A400
,CAST (t6.A415_kannibalisierungsfaktor AS DEC (18,1)) AS A415
,t1.art_id
,nielsen_gtin
,t1.nielsen_art_bez

,CAST(t1.cp_bons_sa / NULLIFZERO(t1.anz_bons_sa) * 100 AS DEC(18,2)) AS A356
,t4.kolliabverkaufsquote AS A368
,CAST(t1.restbon_summe / NULLIFZERO(t1.anz_bons_gesamt) AS DEC(18,2)) AS A364
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
ELSE kassenumsatz_kl_absolut_netto_wg END) END AS DEC (18,2)) AS A321
,a445_anz_tupel_listung_wgi AS A445
,sustain_concat AS A514
,a519_umsatz_anteil_wg_nielsen AS A519
,a520_umsatz_anteil_wg_kumuliert_nielsen AS A520
,a471_marke_nielsen_bez AS A471
,a515_bio_organic_nielsen_kz AS A515
,a516_veggy_split_nielsen_kz AS A516
,a517_laktosefrei_nielsen_kz AS A517
,a518_glutenfrei_nielsen_kz AS A518
,a521_inhalt_menge AS A521
,t1.absatz_nielsen AS A382
,t5.substitute_count AS SUBSTITUTE_COUNT
FROM dbp_msi_v_view.v_tupel_mat t1
LEFT JOIN dbp_view.v_zek t2
ON t1.mandant_id=t2.mandant_id
AND t1.a389_zek_id=t2.zek_id
LEFT JOIN dbp_view.v_fanquote t3
ON t1.mandant_id=t3.mandant_id
AND t1.matching_id=t3.matching_id
AND t1.A500_kjwo_update=t3.kjwo_update
LEFT JOIN dbp_view.v_sortiment_leistung t4
ON t1.mandant_id = t4.mandant_id
AND t1.A425_kjmo = t4.kjmo
AND t1.a500_kjwo_update = t4.kjwo_update
AND t1.matching_id = t4.matching_id
LEFT JOIN (
SELECT
mandant_id AS mandant_id
,kjwo_update AS kjwo_update
,matching_id_parent AS matching_id_parent
,COUNT(*) AS substitute_count
FROM dbp_view.v_tupel_mat_substitute
WHERE rank_substitute BETWEEN 1 AND 20
GROUP BY 1,2,3) t5
ON t1.mandant_id = t5.mandant_id
AND t1.matching_id = t5.matching_id_parent
AND t1.a500_kjwo_update = t5.kjwo_update
LEFT JOIN 
(SELECT *
FROM DBP_MSI_DATA.TUPEL_MAT_FORECAST
QUALIFY ROW_NUMBER() OVER (PARTITION BY MANDANT_ID, A500_KJWO_UPDATE, MATCHING_ID ORDER BY EXECUTION_TIMESTAMP DESC) = 1) t6
ON t1.mandant_id = t6.mandant_id
AND t1.a500_kjwo_update = t6.a500_kjwo_update
AND t1.matching_id = t6.matching_id;