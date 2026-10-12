create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ZEIT_SPR_ZU_1(
	ZEIT_ID,
	TAG_VON,
	TAG_BIS,
	KJWO_VON,
	KJWO_BIS,
	KJMO_VON,
	KJMO_BIS,
	GJ_ID,
	KJ_ID,
	KW_ID,
	TAG_ID,
	MO_VON,
	MO_BIS,
	AKT_TAG_MIN,
	AKT_WO_MIN,
	AKT_MO_MIN,
	AKT_GJ_MIN,
	WTAG_MIN,
	ZEIT_TAG_SORT,
	ZEIT_BM_SORT,
	ZEIT_DB1_SORT,
	ZEIT_DB2_SORT,
	ZEIT_TYP,
	ZEIT_BEZ,
	ZEIT_BEZ_CZ,
	ZEIT_BEZ_SK,
	ZEIT_BEZ_HR,
	ZEIT_BEZ_PL,
	ZEIT_BEZ_RO,
	ZEIT_BEZ_BG,
	ZEIT_KBEZ,
	ZEIT_KBEZ_CZ,
	ZEIT_KBEZ_SK,
	ZEIT_KBEZ_HR,
	ZEIT_KBEZ_PL,
	ZEIT_KBEZ_RO,
	ZEIT_KBEZ_BG,
	ZEIT_TAG_BEZ,
	ZEIT_TAG_BEZ_CZ,
	ZEIT_TAG_BEZ_SK,
	ZEIT_TAG_BEZ_HR,
	ZEIT_TAG_BEZ_PL,
	ZEIT_TAG_BEZ_RO,
	ZEIT_TAG_BEZ_BG,
	ZEIT_BM_BEZ,
	ZEIT_BM_BEZ_CZ,
	ZEIT_BM_BEZ_SK,
	ZEIT_BM_BEZ_HR,
	ZEIT_BM_BEZ_PL,
	ZEIT_BM_BEZ_RO,
	ZEIT_BM_BEZ_BG,
	MO_DE,
	MO_CZ,
	MO_SK,
	MO_HR,
	MO_PL,
	MO_RO,
	MO_BG,
	GJ_DE,
	GJ_CZ,
	GJ_SK,
	GJ_HR,
	GJ_PL,
	GJ_RO,
	GJ_BG,
	KW_DE,
	KW_CZ,
	KW_SK,
	KW_HR,
	KW_PL,
	KW_RO,
	KW_BG,
	AUFG_DE,
	AUFG_CZ,
	AUFG_SK,
	AUFG_HR,
	AUFG_PL,
	AUFG_RO,
	AUFG_BG
) as
/* ZEIT_1/HIERARCHIE : flexible/kombinierte Zeitstruktur
   2020.0121 ssch0611 : Initial
   2020.0210 ssch0611 : Review/Finetuning
   2020.0720 ssch0611 : Multi-Language
   2020.0807 ssch0611 : Updated Sorting Tag_1
   2020.0818 ssch0611 : Extended weeks (history) + update sort_tag
   2020-09-16 ssch0611 : changed column size (varchar30) 
   2022-01-25 ssch0611 : changed translation PL (INC) 
   2023-02-09 ssch0611 : updated translation PL - INC6050754
*/
SELECT DISTINCT
  zeit_id
, MIN(dat)     AS tag_von
, MAX(dat)     AS tag_bis
, MIN(kjwo)    AS kjwo_von
, MAX(kjwo)    AS kjwo_bis
, MIN(kjmo)    AS kjmo_von
, MAX(kjmo)    AS kjmo_bis
, MIN(gj)      AS GJ_ID
, MIN(MOD(kj, 100))                       AS KJ_ID
, TO_VARCHAR(MOD(kjwo_von, 100),'00') AS KW_ID
, TO_VARCHAR(tag_von, 'DD.MM.YY') AS TAG_ID
, MIN(mo_kj)   AS mo_von
, MAX(mo_kj)   AS mo_bis
, MIN(akt_tag) AS akt_tag_min
, MIN(akt_wo)  AS akt_wo_min
, MIN(akt_mo)  AS akt_mo_min
, MIN(akt_gj)  AS akt_gj_min
, MIN(wtag_id) AS wtag_min
/* Sorting Zeitreihe Tag_1 */
, CASE
     WHEN zeit_id = -10000                                THEN zeit_id 
     WHEN zeit_id =  -1000                                THEN zeit_id 
     WHEN zeit_id =    120                                THEN -300 
     WHEN zeit_id =    110                                THEN -200 
     WHEN zeit_id =   -100                                THEN  100  
     WHEN zeit_id BETWEEN -10 AND 10 AND akt_wo_min =   0 THEN  110 + zeit_id 
     WHEN zeit_id =   -110                                THEN  200 
     WHEN zeit_id BETWEEN -20 AND  0 AND akt_wo_min =  -1 THEN  220 + zeit_id 
     WHEN zeit_id =   -120                                THEN  300 
     WHEN zeit_id =   -130                                THEN  400 
     WHEN zeit_id =   -140                                THEN  500 
     WHEN zeit_id =   -150                                THEN  600 
     WHEN zeit_id =   -160                                THEN  700 
     WHEN zeit_id =   -170                                THEN  800 
     WHEN zeit_id =   -180                                THEN  900 
     WHEN zeit_id =   -190                                THEN 1000 
     WHEN zeit_id =   -200                                THEN 1100 
     ELSE 9999
    END::SMALLINT AS zeit_tag_sort 
/* Sorting Benchmark Tag_1 */
, CASE
     WHEN zeit_id =      0 THEN zeit_id 
     WHEN zeit_id =     -1 THEN zeit_id * -1 
     WHEN zeit_id =     -2 THEN zeit_id * -1 
     WHEN zeit_id =   -100 THEN zeit_id * -1 
     WHEN zeit_id =   -110 THEN 200 
     WHEN zeit_id =   -120 THEN 300 
     WHEN zeit_id =  -1000 THEN zeit_id * -1 
     WHEN zeit_id = -10000 THEN 5000 
     ELSE 9999
    END::SMALLINT AS zeit_bm_sort 
/* Sorting Dashboard GJ/MO */
, CASE
     WHEN zeit_id = -10000                               THEN zeit_id 
     WHEN zeit_id BETWEEN -2100 AND -1100                THEN zeit_id - 4000 
     WHEN zeit_id BETWEEN  1000 AND  2100                THEN zeit_id - 6000 
     WHEN zeit_id =  -1000                               THEN zeit_id 
     WHEN zeit_id BETWEEN -30 AND 30 AND akt_mo_min =  0 THEN -900 + zeit_id
     ELSE 9999
    END::SMALLINT AS zeit_db1_sort 
/* Sorting Dashboard WO/Tag_1 */ 
, CASE
      WHEN zeit_id =   -100                              THEN 100 
      WHEN zeit_id BETWEEN -10 AND 10 AND akt_wo_min = 0 THEN 110 + zeit_id 
      WHEN zeit_id =   -110                              THEN 200 
      WHEN zeit_id BETWEEN -20 AND 0 AND akt_wo_min = -1 THEN 220 + zeit_id 
      WHEN zeit_id =   -120                              THEN 300 
      WHEN zeit_id BETWEEN -30 AND 0 AND akt_wo_min = -2 THEN 330 + zeit_id 
      WHEN zeit_id =   -130                              THEN 400 
      WHEN zeit_id BETWEEN -40 AND 0 AND akt_wo_min = -3 THEN 440 + zeit_id 
      ELSE 9999
    END::SMALLINT AS zeit_db2_sort 
/* Labels and Translations */
, CASE
      WHEN zeit_id IN (-100, -1000, -10000) THEN 1
      ELSE 0
    END::BYTEINT  AS zeit_typ
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'GJ'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KW'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'März' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Mai' WHEN  6 THEN 'Juni' WHEN  7 THEN 'Juli' WHEN  8 THEN 'Aug' 
        WHEN  9 THEN 'Sept' WHEN 10 THEN 'Okt' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dez' WHEN  1 THEN 'Jan' WHEN  2 THEN 'Feb' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
    ELSE '--'
  END::VARCHAR(30)  AS zeit_bez
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'GJ'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KT'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Bre' WHEN  4 THEN 'Dub' WHEN  5 THEN 'Kve' WHEN  6 THEN 'Cer' WHEN  7 THEN 'Cvc' WHEN  8 THEN 'Srp'
        WHEN  9 THEN 'Zar' WHEN 10 THEN 'Rij' WHEN 11 THEN 'Lis' WHEN 12 THEN 'Pro' WHEN  1 THEN 'Led' WHEN  2 THEN 'Uno' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
    ELSE '--'
  END::VARCHAR(30)  AS zeit_bez_cz
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'GJ'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KW'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Mar' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Maj' WHEN  6 THEN 'Jun' WHEN  7 THEN 'Jul' WHEN  8 THEN 'Aug' 
        WHEN  9 THEN 'Sep' WHEN 10 THEN 'Okt' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dec' WHEN  1 THEN 'Jan' WHEN  2 THEN 'Feb' 
      ELSE '' END || ' ' || TRIM(KJ_ID)
    ELSE '--'
  END::VARCHAR(30)  AS zeit_bez_sk
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'PG'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KW'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Ozu' WHEN  4 THEN 'Tra' WHEN  5 THEN 'Svi' WHEN  6 THEN 'Lip' WHEN  7 THEN 'Srp' WHEN  8 THEN 'Kol'
        WHEN  9 THEN 'Ruj' WHEN 10 THEN 'Lis' WHEN 11 THEN 'Stu' WHEN 12 THEN 'Pro' WHEN  1 THEN 'Sij' WHEN  2 THEN 'Vel' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
    ELSE '--'
  END::VARCHAR(30)  AS zeit_bez_hr
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'RO'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KW'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Mar' WHEN  4 THEN 'Kwi' WHEN  5 THEN 'Maj' WHEN  6 THEN 'Cze' WHEN  7 THEN 'Lip' WHEN  8 THEN 'Sie'
        WHEN  9 THEN 'Wrz' WHEN 10 THEN 'Paź' WHEN 11 THEN 'Lis' WHEN 12 THEN 'Gru' WHEN  1 THEN 'Sty' WHEN  2 THEN 'Lut' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
    ELSE '--'
  END::VARCHAR(30)  AS zeit_bez_pl
, CASE
    WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'AF'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
    WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
    WHEN zeit_id BETWEEN   -990 AND   990          THEN 'KW'::VARCHAR(2) || ' ' || TRIM(KW_ID)
    WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Mar' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Mai' WHEN  6 THEN 'Iun' WHEN  7 THEN 'Iul' WHEN  8 THEN 'Aug' 
        WHEN  9 THEN 'Sep' WHEN 10 THEN 'Oct' WHEN 11 THEN 'Noi' WHEN 12 THEN 'Dec' WHEN  1 THEN 'Ian' WHEN  2 THEN 'Feb' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
   ELSE '--'
  END::VARCHAR(30)  AS zeit_bez_ro
, CASE
   WHEN zeit_id IN (-20000, -10000, 10000, 20000) THEN 'ФГ'::VARCHAR(2) || ' ' || TRIM(GJ_ID)
   WHEN zeit_id BETWEEN    -99 AND    99          THEN TRIM(TAG_ID)
   WHEN zeit_id BETWEEN   -990 AND   990          THEN 'КС'::VARCHAR(2) || ' ' || TRIM(KW_ID)
   WHEN zeit_id BETWEEN -19900 AND 19900          THEN CASE mo_von 
        WHEN  3 THEN 'Март' WHEN  4 THEN 'Апр' WHEN  5 THEN 'Май' WHEN  6 THEN 'Юни' WHEN  7 THEN 'Юли' WHEN  8 THEN 'Авг' 
        WHEN  9 THEN 'Септ' WHEN 10 THEN 'Окт' WHEN 11 THEN 'Ноем' WHEN 12 THEN 'Дек' WHEN  1 THEN 'Яну' WHEN  2 THEN 'Февр' 
        ELSE '' END || ' ' || TRIM(KJ_ID)
   ELSE '--'
 END::VARCHAR(30)  AS zeit_bez_bg
, CASE
     WHEN zeit_id =      1 THEN 'Heute'
     WHEN zeit_id =      0 THEN 'Vortag'
     WHEN zeit_id =     -1 THEN 'vor 2 Tagen'
     WHEN zeit_id =     -2 THEN 'vor 3 Tagen'
     WHEN zeit_id =   -100 THEN 'aktuelle Woche_1'
     WHEN zeit_id =   -110 THEN 'Vorwoche'
     WHEN zeit_id =   -120 THEN 'vor 2 Wochen'
     WHEN zeit_id =   -130 THEN 'vor 3 Wochen'
     WHEN zeit_id =  -1000 THEN 'aktueller Monat_1'
     WHEN zeit_id =  -1100 THEN 'Vormonat'
     WHEN zeit_id =  -1200 THEN 'vor 2 Monaten'
     WHEN zeit_id =  -1300 THEN 'vor 3 Monaten'
     WHEN zeit_id = -10000 THEN 'aktuelles GJ'
     WHEN zeit_id = -20000 THEN 'vorheriges GJ'
     ELSE ''
  END::VARCHAR(30)  AS zeit_kbez
, CASE
     WHEN zeit_id =      1 THEN 'Dnes'
     WHEN zeit_id =      0 THEN 'Předchozí den'
     WHEN zeit_id =     -1 THEN 'Před 2 dny'
     WHEN zeit_id =     -2 THEN 'Před 3 dny'
     WHEN zeit_id =   -100 THEN 'Aktuální týden'
     WHEN zeit_id =   -110 THEN 'Předchozí týden'
     WHEN zeit_id =   -120 THEN 'Před 2 týdny'
     WHEN zeit_id =   -130 THEN 'Před 3 týdny'
     WHEN zeit_id =  -1000 THEN 'Aktuální měsíc'
     WHEN zeit_id =  -1100 THEN 'Předchozí měsíc'
     WHEN zeit_id =  -1200 THEN 'Před 2 měsíci'
     WHEN zeit_id =  -1300 THEN 'Před 3 měsíci'
     WHEN zeit_id = -10000 THEN 'Aktuální GJ'
     WHEN zeit_id = -20000 THEN 'Minulý GJ'
     ELSE ''
  END::VARCHAR(30)  AS zeit_kbez_cz
, CASE
     WHEN zeit_id =      1 THEN 'Dnes'
     WHEN zeit_id =      0 THEN 'Včera'
     WHEN zeit_id =     -1 THEN 'Pred 2 dňami'
     WHEN zeit_id =     -2 THEN 'Pred 3 dňami'
     WHEN zeit_id =   -100 THEN 'Aktuálny týždeň'
     WHEN zeit_id =   -110 THEN 'Predchádzajúci týždeň'
     WHEN zeit_id =   -120 THEN 'Pred 2 týždňami'
     WHEN zeit_id =   -130 THEN 'Pred 3 týždňami'
     WHEN zeit_id =  -1000 THEN 'Aktuálny mesiac'
     WHEN zeit_id =  -1100 THEN 'Predchádzajúci mesiac'
     WHEN zeit_id =  -1200 THEN 'Pred 2 mesiacmi'
     WHEN zeit_id =  -1300 THEN 'Pred 3 mesiacmi'
     WHEN zeit_id = -10000 THEN 'Aktuálny GJ'
     WHEN zeit_id = -20000 THEN 'Minulý GJ'
     ELSE ''
  END::VARCHAR(30)  AS zeit_kbez_sk
, CASE
     WHEN zeit_id =      1 THEN 'Danas'
     WHEN zeit_id =      0 THEN 'Prethodni dan'
     WHEN zeit_id =     -1 THEN 'prije 2 dana'
     WHEN zeit_id =     -2 THEN 'prije 3 dana'
     WHEN zeit_id =   -100 THEN 'Aktualni tjedan'
     WHEN zeit_id =   -110 THEN 'Prošli tjedan'
     WHEN zeit_id =   -120 THEN 'prije 2 tjedna'
     WHEN zeit_id =   -130 THEN 'prije 3 tjedna'
     WHEN zeit_id =  -1000 THEN 'Aktualni mjesec'
     WHEN zeit_id =  -1100 THEN 'Prošli mjesec'
     WHEN zeit_id =  -1200 THEN 'prije 2 mjeseca'
     WHEN zeit_id =  -1300 THEN 'prije 3 mjeseca'
     WHEN zeit_id = -10000 THEN 'Aktualna PG'
     WHEN zeit_id = -20000 THEN 'Prošla PG'
     ELSE ''
  END::VARCHAR(30)  AS zeit_kbez_hr
, CASE
     WHEN zeit_id =      1 THEN 'Dzisiaj'
     WHEN zeit_id =      0 THEN 'Poprzedni dzień'
     WHEN zeit_id =     -1 THEN '2 dni temu'
     WHEN zeit_id =     -2 THEN '3 dni temu'
     WHEN zeit_id =   -100 THEN 'Aktualny tydzień'
     WHEN zeit_id =   -110 THEN 'Poprzedni tydzień'
     WHEN zeit_id =   -120 THEN '2 tygodnie temu'
     WHEN zeit_id =   -130 THEN '3 tygodnie temu'
     WHEN zeit_id =  -1000 THEN 'Aktualny miesiąc'
     WHEN zeit_id =  -1100 THEN 'Poprzedni miesiąc'
     WHEN zeit_id =  -1200 THEN '2 miesiące temu'
     WHEN zeit_id =  -1300 THEN '3 miesiące temu'
     WHEN zeit_id = -10000 THEN 'Aktualny RO'
     WHEN zeit_id = -20000 THEN 'Poprzedni RO'
     ELSE ''
    END::VARCHAR(30)  AS zeit_kbez_pl
, CASE
     WHEN zeit_id =      1 THEN 'Azi'
     WHEN zeit_id =      0 THEN 'ziua anterioară'
     WHEN zeit_id =     -1 THEN '2 zile în urmă'
     WHEN zeit_id =     -2 THEN '3 zile în urmă'
     WHEN zeit_id =   -100 THEN 'Săptămână actuală'
     WHEN zeit_id =   -110 THEN 'Săptămâna trecută'
     WHEN zeit_id =   -120 THEN 'Acum 2 Săptămâni'
     WHEN zeit_id =   -130 THEN 'Acum 3 Săptămâni'
     WHEN zeit_id =  -1000 THEN 'Luna actuală'
     WHEN zeit_id =  -1100 THEN 'Luna trecută'
     WHEN zeit_id =  -1200 THEN '2 luni în urmă'
     WHEN zeit_id =  -1300 THEN '3 luni în urmă'
     WHEN zeit_id = -10000 THEN 'AF actual'
     WHEN zeit_id = -20000 THEN 'AF anterior'
     ELSE ''
  END::VARCHAR(30)  AS zeit_kbez_ro
, CASE
    WHEN zeit_id =      1 THEN 'Днес'
    WHEN zeit_id =      0 THEN 'Предишен ден'
    WHEN zeit_id =     -1 THEN '2 дни назад'
    WHEN zeit_id =     -2 THEN '3 дни назад'
    WHEN zeit_id =   -100 THEN 'Текуща седмица'
    WHEN zeit_id =   -110 THEN 'Предходна седмица'
    WHEN zeit_id =   -120 THEN '2 седмици назад'
    WHEN zeit_id =   -130 THEN '3 седмици назад'
    WHEN zeit_id =  -1000 THEN 'Текущ месец'
    WHEN zeit_id =  -1100 THEN 'Предходен месец'
    WHEN zeit_id =  -1200 THEN '2 месеца назад '
    WHEN zeit_id =  -1300 THEN '3 месеца назад'
    WHEN zeit_id = -10000 THEN 'Текуща ФГ'
    WHEN zeit_id = -20000 THEN 'Предходна ФГ'
    ELSE ''
  END::VARCHAR(30)  AS zeit_kbez_bg
, CASE WHEN zeit_typ = 1 THEN zeit_bez    || ' ' || 'aufg'::VARCHAR(4) ELSE zeit_bez    END AS zeit_tag_bez
, CASE WHEN zeit_typ = 1 THEN zeit_bez_cz || ' ' || 'kum'::VARCHAR(4) ELSE zeit_bez_cz  END AS zeit_tag_bez_cz
, CASE WHEN zeit_typ = 1 THEN zeit_bez_sk || ' ' || 'kum'::VARCHAR(4) ELSE zeit_bez_sk  END AS zeit_tag_bez_sk
, CASE WHEN zeit_typ = 1 THEN zeit_bez_hr || ' ' || 'kum'::VARCHAR(4) ELSE zeit_bez_hr  END AS zeit_tag_bez_hr
, CASE WHEN zeit_typ = 1 THEN zeit_bez_pl || ' ' || 'skum'::VARCHAR(4) ELSE zeit_bez_pl END AS zeit_tag_bez_pl
, CASE WHEN zeit_typ = 1 THEN zeit_bez_ro || ' ' || 'cum'::VARCHAR(4) ELSE zeit_bez_ro  END AS zeit_tag_bez_ro
, CASE WHEN zeit_typ = 1 THEN zeit_bez_bg || ' ' || 'кум'::VARCHAR(4) ELSE zeit_bez_bg  END AS zeit_tag_bez_bg
, CASE WHEN zeit_typ = 1 THEN zeit_kbez    || ' ' || 'aufg'::VARCHAR(4) ELSE zeit_kbez    END AS zeit_bm_bez
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_cz || ' ' || 'kum'::VARCHAR(4) ELSE zeit_kbez_cz  END AS zeit_bm_bez_cz
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_sk || ' ' || 'kum'::VARCHAR(4) ELSE zeit_kbez_sk  END AS zeit_bm_bez_sk
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_hr || ' ' || 'kum'::VARCHAR(4) ELSE zeit_kbez_hr  END AS zeit_bm_bez_hr
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_pl || ' ' || 'skum'::VARCHAR(4) ELSE zeit_kbez_pl END AS zeit_bm_bez_pl
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_ro || ' ' || 'cum'::VARCHAR(4) ELSE zeit_kbez_ro  END AS zeit_bm_bez_ro
, CASE WHEN zeit_typ = 1 THEN zeit_kbez_bg || ' ' || 'кум'::VARCHAR(4) ELSE zeit_kbez_bg  END AS zeit_bm_bez_bg
, CASE mo_von 
    WHEN  3 THEN 'März' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Mai' WHEN  6 THEN 'Juni' WHEN  7 THEN 'Juli' WHEN  8 THEN 'Aug'  
    WHEN  9 THEN 'Sept' WHEN 10 THEN 'Okt' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dez' WHEN  1 THEN 'Jan' WHEN  2 THEN 'Feb' ELSE '' 
  END AS mo_de
, CASE mo_von 
    WHEN  3 THEN 'Bre' WHEN  4 THEN 'Dub' WHEN  5 THEN 'Kve' WHEN  6 THEN 'Cer' WHEN  7 THEN 'Cvc' WHEN  8 THEN 'Srp' 
    WHEN  9 THEN 'Zar' WHEN 10 THEN 'Rij' WHEN 11 THEN 'Lis' WHEN 12 THEN 'Pro' WHEN  1 THEN 'Led' WHEN  2 THEN 'Uno' ELSE '' 
  END AS mo_cz
, CASE mo_von 
    WHEN  3 THEN 'Mar' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Maj' WHEN  6 THEN 'Jun' WHEN  7 THEN 'Jul' WHEN  8 THEN 'Aug' 
    WHEN  9 THEN 'Sep' WHEN 10 THEN 'Okt' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dec' WHEN  1 THEN 'Jan' WHEN  2 THEN 'Feb' ELSE '' 
  END AS mo_sk
, CASE mo_von 
    WHEN  3 THEN 'Ozu' WHEN  4 THEN 'Tra' WHEN  5 THEN 'Svi' WHEN  6 THEN 'Lip' WHEN  7 THEN 'Srp' WHEN  8 THEN 'Kol' 
    WHEN  9 THEN 'Ruj' WHEN 10 THEN 'Lis' WHEN 11 THEN 'Stu' WHEN 12 THEN 'Pro' WHEN  1 THEN 'Sij' WHEN  2 THEN 'Vel' ELSE '' 
  END AS mo_hr
, CASE mo_von 
    WHEN  3 THEN 'Mar' WHEN  4 THEN 'Kwi' WHEN  5 THEN 'Maj' WHEN  6 THEN 'Cze' WHEN  7 THEN 'Lip' WHEN  8 THEN 'Sie' 
    WHEN  9 THEN 'Wrz' WHEN 10 THEN 'Paź' WHEN 11 THEN 'Lis' WHEN 12 THEN 'Gru' WHEN  1 THEN 'Sty' WHEN  2 THEN 'Lut' ELSE '' 
  END AS mo_pl
, CASE mo_von 
    WHEN  3 THEN 'Mar' WHEN  4 THEN 'Apr' WHEN  5 THEN 'Mai' WHEN  6 THEN 'Iun' WHEN  7 THEN 'Iul' WHEN  8 THEN 'Aug' 
    WHEN  9 THEN 'Sep' WHEN 10 THEN 'Oct' WHEN 11 THEN 'Noi' WHEN 12 THEN 'Dec' WHEN  1 THEN 'Ian' WHEN  2 THEN 'Feb' ELSE '' 
  END AS mo_ro
, CASE mo_von 
    WHEN  3 THEN 'Март' WHEN  4 THEN 'Апр' WHEN  5 THEN 'Май' WHEN  6 THEN 'Юни' WHEN  7 THEN 'Юли' WHEN  8 THEN 'Авг' 
    WHEN  9 THEN 'Септ' WHEN 10 THEN 'Окт' WHEN 11 THEN 'Ноем' WHEN 12 THEN 'Дек' WHEN  1 THEN 'Яну' WHEN  2 THEN 'Февр' ELSE '' 
  END AS mo_bg
, 'GJ'::VARCHAR(2)  AS GJ_DE 
, 'GJ'::VARCHAR(2)  AS gj_cz 
, 'GJ'::VARCHAR(2)  AS gj_sk 
, 'PG'::VARCHAR(2)  AS gj_hr 
, 'RO'::VARCHAR(2)  AS gj_pl 
, 'AF'::VARCHAR(2)  AS gj_ro 
, 'ФГ'::VARCHAR(2)  AS gj_bg 
, 'KW'::VARCHAR(2)  AS KW_DE 
, 'KT'::VARCHAR(2)  AS KW_cz 
, 'KW'::VARCHAR(2)  AS KW_sk 
, 'KW'::VARCHAR(2)  AS KW_hr 
, 'KW'::VARCHAR(2)  AS KW_pl 
, 'KW'::VARCHAR(2)  AS KW_ro 
, 'КС'::VARCHAR(2)  AS KW_bg 
, 'aufg'::VARCHAR(4) AS AUFG_DE 
, 'kum'::VARCHAR(4) AS aufg_cz 
, 'kum'::VARCHAR(4) AS aufg_sk 
, 'kum'::VARCHAR(4) AS aufg_hr 
, 'skum'::VARCHAR(4) AS aufg_pl 
, 'cum'::VARCHAR(4) AS aufg_ro 
, 'кум'::VARCHAR(4) AS aufg_bg 
FROM dbp_msi_view_vis.mv_zeit_tag_zu_1 
GROUP BY zeit_id;
