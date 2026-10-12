CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_spr_zu_2 (zeit_id, tag_von, tag_bis, kjwo_von, kjwo_bis,
kjmo_von, kjmo_bis, gj_id, kj_id, kw_id, tag_id, mo_von, mo_bis, akt_tag_min, akt_wo_min, akt_mo_min, akt_gj_min,
wtag_min, zeit_tag_sort, zeit_bm_sort, zeit_db1_sort, zeit_db2_sort, zeit_typ, zeit_bez, zeit_bez_cz, zeit_bez_sk,
zeit_bez_hr, zeit_bez_pl, zeit_bez_ro, zeit_bez_bg, zeit_kbez, zeit_kbez_cz, zeit_kbez_sk, zeit_kbez_hr, zeit_kbez_pl,
zeit_kbez_ro, zeit_kbez_bg, zeit_tag_bez, zeit_tag_bez_cz, zeit_tag_bez_sk, zeit_tag_bez_hr, zeit_tag_bez_pl,
zeit_tag_bez_ro, zeit_tag_bez_bg, zeit_bm_bez, zeit_bm_bez_cz, zeit_bm_bez_sk, zeit_bm_bez_hr, zeit_bm_bez_pl,
zeit_bm_bez_ro, zeit_bm_bez_bg, mo_de, mo_cz, mo_sk, mo_hr, mo_pl, mo_ro, mo_bg, gj_de, gj_cz, gj_sk, gj_hr, gj_pl,
gj_ro, gj_bg, kw_de, kw_cz, kw_sk, kw_hr, kw_pl, kw_ro, kw_bg, aufg_de, aufg_cz, aufg_sk, aufg_hr, aufg_pl, aufg_ro,
aufg_bg) AS SELECT zeit_id,
 MIN(dat) AS tag_von,
 MAX(dat) AS tag_bis,
 MIN(kjwo) AS kjwo_von,
 MAX(kjwo) AS kjwo_bis,
 MIN(kjmo) AS kjmo_von,
 MAX(kjmo) AS kjmo_bis,
 MIN(gj) AS gj_id,
 MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS kj_id,
 CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00') AS kw_id,
 FORMAT_DATE('%d.%m.%y', MIN(dat)) AS tag_id,
 MIN(mo_kj) AS mo_von,
 MAX(mo_kj) AS mo_bis,
 MIN(akt_tag) AS akt_tag_min,
 MIN(akt_wo) AS akt_wo_min,
 MIN(akt_mo) AS akt_mo_min,
 MIN(akt_gj) AS akt_gj_min,
 MIN(wtag_id) AS wtag_min,
 CAST(CASE
   WHEN zeit_id = - 10000 OR zeit_id = - 1000
   THEN zeit_id
   WHEN zeit_id = 120
   THEN CAST(- 300 AS BIGNUMERIC)
   WHEN zeit_id = 110
   THEN CAST(- 200 AS BIGNUMERIC)
   WHEN zeit_id = - 100
   THEN 100
   WHEN zeit_id BETWEEN - 10 AND 10 AND MIN(akt_wo) = 0
   THEN 110 + zeit_id
   WHEN zeit_id = - 110
   THEN 200
   WHEN zeit_id BETWEEN - 20 AND 0 AND MIN(akt_wo) = - 1
   THEN 220 + zeit_id
   WHEN zeit_id = - 120
   THEN 300
   WHEN zeit_id = - 130
   THEN 400
   WHEN zeit_id = - 140
   THEN 500
   WHEN zeit_id = - 150
   THEN 600
   WHEN zeit_id = - 160
   THEN 700
   WHEN zeit_id = - 170
   THEN 800
   WHEN zeit_id = - 180
   THEN 900
   WHEN zeit_id = - 190
   THEN 1000
   WHEN zeit_id = - 200
   THEN 1100
   ELSE 9999
   END AS BIGNUMERIC) AS zeit_tag_sort,
 CAST(CASE
   WHEN zeit_id = 0
   THEN zeit_id
   WHEN zeit_id = - 1 OR zeit_id = - 2 OR zeit_id = - 100
   THEN zeit_id * - 1
   WHEN zeit_id = - 110
   THEN 200
   WHEN zeit_id = - 120
   THEN 300
   WHEN zeit_id = - 1000
   THEN zeit_id * - 1
   WHEN zeit_id = - 10000
   THEN 5000
   ELSE 9999
   END AS BIGNUMERIC) AS zeit_bm_sort,
 CAST(CASE
   WHEN zeit_id = - 10000
   THEN zeit_id
   WHEN zeit_id BETWEEN - 2100 AND (- 1100)
   THEN zeit_id - 4000
   WHEN zeit_id BETWEEN 1000 AND 2100
   THEN zeit_id - 6000
   WHEN zeit_id = - 1000
   THEN zeit_id
   WHEN zeit_id BETWEEN - 30 AND 30 AND MIN(akt_mo) = 0
   THEN - 900 + zeit_id
   ELSE 9999
   END AS BIGNUMERIC) AS zeit_db1_sort,
 CAST(CASE
   WHEN zeit_id = - 100
   THEN 100
   WHEN zeit_id BETWEEN - 10 AND 10 AND MIN(akt_wo) = 0
   THEN 110 + zeit_id
   WHEN zeit_id = - 110
   THEN 200
   WHEN zeit_id BETWEEN - 20 AND 0 AND MIN(akt_wo) = - 1
   THEN 220 + zeit_id
   WHEN zeit_id = - 120
   THEN 300
   WHEN zeit_id BETWEEN - 30 AND 0 AND MIN(akt_wo) = - 2
   THEN 330 + zeit_id
   WHEN zeit_id = - 130
   THEN 400
   WHEN zeit_id BETWEEN - 40 AND 0 AND MIN(akt_wo) = - 3
   THEN 440 + zeit_id
   ELSE 9999
   END AS BIGNUMERIC) AS zeit_db2_sort,
 CAST(CASE
   WHEN zeit_id IN (- 100, - 1000, - 10000)
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS zeit_typ,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'März'
      WHEN MIN(mo_kj) = 4
      THEN 'Apr'
      WHEN MIN(mo_kj) = 5
      THEN 'Mai'
      WHEN MIN(mo_kj) = 6
      THEN 'Juni'
      WHEN MIN(mo_kj) = 7
      THEN 'Juli'
      WHEN MIN(mo_kj) = 8
      THEN 'Aug'
      WHEN MIN(mo_kj) = 9
      THEN 'Sept'
      WHEN MIN(mo_kj) = 10
      THEN 'Okt'
      WHEN MIN(mo_kj) = 11
      THEN 'Nov'
      WHEN MIN(mo_kj) = 12
      THEN 'Dez'
      WHEN MIN(mo_kj) = 1
      THEN 'Jan'
      WHEN MIN(mo_kj) = 2
      THEN 'Feb'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KT' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Bre'
      WHEN MIN(mo_kj) = 4
      THEN 'Dub'
      WHEN MIN(mo_kj) = 5
      THEN 'Kve'
      WHEN MIN(mo_kj) = 6
      THEN 'Cer'
      WHEN MIN(mo_kj) = 7
      THEN 'Cvc'
      WHEN MIN(mo_kj) = 8
      THEN 'Srp'
      WHEN MIN(mo_kj) = 9
      THEN 'Zar'
      WHEN MIN(mo_kj) = 10
      THEN 'Rij'
      WHEN MIN(mo_kj) = 11
      THEN 'Lis'
      WHEN MIN(mo_kj) = 12
      THEN 'Pro'
      WHEN MIN(mo_kj) = 1
      THEN 'Led'
      WHEN MIN(mo_kj) = 2
      THEN 'Uno'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_cz,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Mar'
      WHEN MIN(mo_kj) = 4
      THEN 'Apr'
      WHEN MIN(mo_kj) = 5
      THEN 'Maj'
      WHEN MIN(mo_kj) = 6
      THEN 'Jun'
      WHEN MIN(mo_kj) = 7
      THEN 'Jul'
      WHEN MIN(mo_kj) = 8
      THEN 'Aug'
      WHEN MIN(mo_kj) = 9
      THEN 'Sep'
      WHEN MIN(mo_kj) = 10
      THEN 'Okt'
      WHEN MIN(mo_kj) = 11
      THEN 'Nov'
      WHEN MIN(mo_kj) = 12
      THEN 'Dec'
      WHEN MIN(mo_kj) = 1
      THEN 'Jan'
      WHEN MIN(mo_kj) = 2
      THEN 'Feb'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_sk,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'PG' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Ozu'
      WHEN MIN(mo_kj) = 4
      THEN 'Tra'
      WHEN MIN(mo_kj) = 5
      THEN 'Svi'
      WHEN MIN(mo_kj) = 6
      THEN 'Lip'
      WHEN MIN(mo_kj) = 7
      THEN 'Srp'
      WHEN MIN(mo_kj) = 8
      THEN 'Kol'
      WHEN MIN(mo_kj) = 9
      THEN 'Ruj'
      WHEN MIN(mo_kj) = 10
      THEN 'Lis'
      WHEN MIN(mo_kj) = 11
      THEN 'Stu'
      WHEN MIN(mo_kj) = 12
      THEN 'Pro'
      WHEN MIN(mo_kj) = 1
      THEN 'Sij'
      WHEN MIN(mo_kj) = 2
      THEN 'Vel'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_hr,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'RO' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Mar'
      WHEN MIN(mo_kj) = 4
      THEN 'Kwi'
      WHEN MIN(mo_kj) = 5
      THEN 'Maj'
      WHEN MIN(mo_kj) = 6
      THEN 'Cze'
      WHEN MIN(mo_kj) = 7
      THEN 'Lip'
      WHEN MIN(mo_kj) = 8
      THEN 'Sie'
      WHEN MIN(mo_kj) = 9
      THEN 'Wrz'
      WHEN MIN(mo_kj) = 10
      THEN 'Paź'
      WHEN MIN(mo_kj) = 11
      THEN 'Lis'
      WHEN MIN(mo_kj) = 12
      THEN 'Gru'
      WHEN MIN(mo_kj) = 1
      THEN 'Sty'
      WHEN MIN(mo_kj) = 2
      THEN 'Lut'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_pl,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'AF' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Mar'
      WHEN MIN(mo_kj) = 4
      THEN 'Apr'
      WHEN MIN(mo_kj) = 5
      THEN 'Mai'
      WHEN MIN(mo_kj) = 6
      THEN 'Iun'
      WHEN MIN(mo_kj) = 7
      THEN 'Iul'
      WHEN MIN(mo_kj) = 8
      THEN 'Aug'
      WHEN MIN(mo_kj) = 9
      THEN 'Sep'
      WHEN MIN(mo_kj) = 10
      THEN 'Oct'
      WHEN MIN(mo_kj) = 11
      THEN 'Noi'
      WHEN MIN(mo_kj) = 12
      THEN 'Dec'
      WHEN MIN(mo_kj) = 1
      THEN 'Ian'
      WHEN MIN(mo_kj) = 2
      THEN 'Feb'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_ro,
 CAST(CASE
   WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
   THEN 'ФГ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
   WHEN zeit_id BETWEEN - 99 AND 99
   THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
   WHEN zeit_id BETWEEN - 990 AND 990
   THEN 'КС' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
   WHEN zeit_id BETWEEN - 19900 AND 19900
   THEN CASE
      WHEN MIN(mo_kj) = 3
      THEN 'Март'
      WHEN MIN(mo_kj) = 4
      THEN 'Апр'
      WHEN MIN(mo_kj) = 5
      THEN 'Май'
      WHEN MIN(mo_kj) = 6
      THEN 'Юни'
      WHEN MIN(mo_kj) = 7
      THEN 'Юли'
      WHEN MIN(mo_kj) = 8
      THEN 'Авг'
      WHEN MIN(mo_kj) = 9
      THEN 'Септ'
      WHEN MIN(mo_kj) = 10
      THEN 'Окт'
      WHEN MIN(mo_kj) = 11
      THEN 'Ноем'
      WHEN MIN(mo_kj) = 12
      THEN 'Дек'
      WHEN MIN(mo_kj) = 1
      THEN 'Яну'
      WHEN MIN(mo_kj) = 2
      THEN 'Февр'
      ELSE ''
      END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
   ELSE '--'
   END AS STRING) AS zeit_bez_bg,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Heute'
   WHEN zeit_id = 0
   THEN 'Vortag'
   WHEN zeit_id = - 1
   THEN 'vor 2 Tagen'
   WHEN zeit_id = - 2
   THEN 'vor 3 Tagen'
   WHEN zeit_id = - 100
   THEN 'aktuelle Woche_2'
   WHEN zeit_id = - 110
   THEN 'Vorwoche'
   WHEN zeit_id = - 120
   THEN 'vor 2 Wochen'
   WHEN zeit_id = - 130
   THEN 'vor 3 Wochen'
   WHEN zeit_id = - 1000
   THEN 'aktueller Monat_2'
   WHEN zeit_id = - 1100
   THEN 'Vormonat'
   WHEN zeit_id = - 1200
   THEN 'vor 2 Monaten'
   WHEN zeit_id = - 1300
   THEN 'vor 3 Monaten'
   WHEN zeit_id = - 10000
   THEN 'aktuelles GJ'
   WHEN zeit_id = - 20000
   THEN 'vorheriges GJ'
   ELSE ''
   END AS STRING) AS zeit_kbez,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Dnes'
   WHEN zeit_id = 0
   THEN 'Předchozí den'
   WHEN zeit_id = - 1
   THEN 'Před 2 dny'
   WHEN zeit_id = - 2
   THEN 'Před 3 dny'
   WHEN zeit_id = - 100
   THEN 'Aktuální t\u00fdden'
   WHEN zeit_id = - 110
   THEN 'Předchozí týden'
   WHEN zeit_id = - 120
   THEN 'Před 2 týdny'
   WHEN zeit_id = - 130
   THEN 'Před 3 týdny'
   WHEN zeit_id = - 1000
   THEN 'Aktuální měsíc'
   WHEN zeit_id = - 1100
   THEN 'Předchozí měsíc'
   WHEN zeit_id = - 1200
   THEN 'Před 2 měsíci'
   WHEN zeit_id = - 1300
   THEN 'Před 3 měsíci'
   WHEN zeit_id = - 10000
   THEN 'Aktuální GJ'
   WHEN zeit_id = - 20000
   THEN 'Minul\u00fd GJ'
   ELSE ''
   END AS STRING) AS zeit_kbez_cz,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Dnes'
   WHEN zeit_id = 0
   THEN 'Včera'
   WHEN zeit_id = - 1
   THEN 'Pred 2 dňami'
   WHEN zeit_id = - 2
   THEN 'Pred 3 dňami'
   WHEN zeit_id = - 100
   THEN 'Aktuálny týždeň'
   WHEN zeit_id = - 110
   THEN 'Predchádzajúci týždeň'
   WHEN zeit_id = - 120
   THEN 'Pred 2 týždňami'
   WHEN zeit_id = - 130
   THEN 'Pred 3 týždňami'
   WHEN zeit_id = - 1000
   THEN 'Aktuálny mesiac'
   WHEN zeit_id = - 1100
   THEN 'Predchádzajúci mesiac'
   WHEN zeit_id = - 1200
   THEN 'Pred 2 mesiacmi'
   WHEN zeit_id = - 1300
   THEN 'Pred 3 mesiacmi'
   WHEN zeit_id = - 10000
   THEN 'Aktuálny GJ'
   WHEN zeit_id = - 20000
   THEN 'Minul\u00fd GJ'
   ELSE ''
   END AS STRING) AS zeit_kbez_sk,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Danas'
   WHEN zeit_id = 0
   THEN 'Prethodni dan'
   WHEN zeit_id = - 1
   THEN 'prije 2 dana'
   WHEN zeit_id = - 2
   THEN 'prije 3 dana'
   WHEN zeit_id = - 100
   THEN 'Aktualni tjedan'
   WHEN zeit_id = - 110
   THEN 'Prošli tjedan'
   WHEN zeit_id = - 120
   THEN 'prije 2 tjedna'
   WHEN zeit_id = - 130
   THEN 'prije 3 tjedna'
   WHEN zeit_id = - 1000
   THEN 'Aktualni mjesec'
   WHEN zeit_id = - 1100
   THEN 'Prošli mjesec'
   WHEN zeit_id = - 1200
   THEN 'prije 2 mjeseca'
   WHEN zeit_id = - 1300
   THEN 'prije 3 mjeseca'
   WHEN zeit_id = - 10000
   THEN 'Aktualna PG'
   WHEN zeit_id = - 20000
   THEN 'Prošla PG'
   ELSE ''
   END AS STRING) AS zeit_kbez_hr,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Dzisiaj'
   WHEN zeit_id = 0
   THEN 'Poprzedni dzień'
   WHEN zeit_id = - 1
   THEN '2 dni temu'
   WHEN zeit_id = - 2
   THEN '3 dni temu'
   WHEN zeit_id = - 100
   THEN 'Aktualny tydzień'
   WHEN zeit_id = - 110
   THEN 'Poprzedni tydzień'
   WHEN zeit_id = - 120
   THEN '2 tygodnie temu'
   WHEN zeit_id = - 130
   THEN '3 tygodnie temu'
   WHEN zeit_id = - 1000
   THEN 'Aktualny miesiąc'
   WHEN zeit_id = - 1100
   THEN 'Poprzedni miesiąc'
   WHEN zeit_id = - 1200
   THEN '2 miesiące temu'
   WHEN zeit_id = - 1300
   THEN '3 miesiące temu'
   WHEN zeit_id = - 10000
   THEN 'Aktualny RO'
   WHEN zeit_id = - 20000
   THEN 'Poprzedni RO'
   ELSE ''
   END AS STRING) AS zeit_kbez_pl,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Azi'
   WHEN zeit_id = 0
   THEN 'ziua anterioară'
   WHEN zeit_id = - 1
   THEN '2 zile în urmă'
   WHEN zeit_id = - 2
   THEN '3 zile în urmă'
   WHEN zeit_id = - 100
   THEN 'Săptămână actuală'
   WHEN zeit_id = - 110
   THEN 'Săptămâna trecută'
   WHEN zeit_id = - 120
   THEN 'Acum 2 Săptămâni'
   WHEN zeit_id = - 130
   THEN 'Acum 3 Săptămâni'
   WHEN zeit_id = - 1000
   THEN 'Luna actuală'
   WHEN zeit_id = - 1100
   THEN 'Luna trecută'
   WHEN zeit_id = - 1200
   THEN '2 luni în urmă'
   WHEN zeit_id = - 1300
   THEN '3 luni în urmă'
   WHEN zeit_id = - 10000
   THEN 'AF actual'
   WHEN zeit_id = - 20000
   THEN 'AF anterior'
   ELSE ''
   END AS STRING) AS zeit_kbez_ro,
 CAST(CASE
   WHEN zeit_id = 1
   THEN 'Днес'
   WHEN zeit_id = 0
   THEN 'Предишен ден'
   WHEN zeit_id = - 1
   THEN '2 дни назад'
   WHEN zeit_id = - 2
   THEN '3 дни назад'
   WHEN zeit_id = - 100
   THEN 'Текуща седмица'
   WHEN zeit_id = - 110
   THEN 'Предходна седмица'
   WHEN zeit_id = - 120
   THEN '2 седмици назад'
   WHEN zeit_id = - 130
   THEN '3 седмици назад'
   WHEN zeit_id = - 1000
   THEN 'Текущ месец'
   WHEN zeit_id = - 1100
   THEN 'Предходен месец'
   WHEN zeit_id = - 1200
   THEN '2 месеца назад '
   WHEN zeit_id = - 1300
   THEN '3 месеца назад'
   WHEN zeit_id = - 10000
   THEN 'Текуща ФГ'
   WHEN zeit_id = - 20000
   THEN 'Предходна ФГ'
   ELSE ''
   END AS STRING) AS zeit_kbez_bg,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'März'
         WHEN MIN(mo_kj) = 4
         THEN 'Apr'
         WHEN MIN(mo_kj) = 5
         THEN 'Mai'
         WHEN MIN(mo_kj) = 6
         THEN 'Juni'
         WHEN MIN(mo_kj) = 7
         THEN 'Juli'
         WHEN MIN(mo_kj) = 8
         THEN 'Aug'
         WHEN MIN(mo_kj) = 9
         THEN 'Sept'
         WHEN MIN(mo_kj) = 10
         THEN 'Okt'
         WHEN MIN(mo_kj) = 11
         THEN 'Nov'
         WHEN MIN(mo_kj) = 12
         THEN 'Dez'
         WHEN MIN(mo_kj) = 1
         THEN 'Jan'
         WHEN MIN(mo_kj) = 2
         THEN 'Feb'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'aufg'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'März'
       WHEN MIN(mo_kj) = 4
       THEN 'Apr'
       WHEN MIN(mo_kj) = 5
       THEN 'Mai'
       WHEN MIN(mo_kj) = 6
       THEN 'Juni'
       WHEN MIN(mo_kj) = 7
       THEN 'Juli'
       WHEN MIN(mo_kj) = 8
       THEN 'Aug'
       WHEN MIN(mo_kj) = 9
       THEN 'Sept'
       WHEN MIN(mo_kj) = 10
       THEN 'Okt'
       WHEN MIN(mo_kj) = 11
       THEN 'Nov'
       WHEN MIN(mo_kj) = 12
       THEN 'Dez'
       WHEN MIN(mo_kj) = 1
       THEN 'Jan'
       WHEN MIN(mo_kj) = 2
       THEN 'Feb'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KT' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Bre'
         WHEN MIN(mo_kj) = 4
         THEN 'Dub'
         WHEN MIN(mo_kj) = 5
         THEN 'Kve'
         WHEN MIN(mo_kj) = 6
         THEN 'Cer'
         WHEN MIN(mo_kj) = 7
         THEN 'Cvc'
         WHEN MIN(mo_kj) = 8
         THEN 'Srp'
         WHEN MIN(mo_kj) = 9
         THEN 'Zar'
         WHEN MIN(mo_kj) = 10
         THEN 'Rij'
         WHEN MIN(mo_kj) = 11
         THEN 'Lis'
         WHEN MIN(mo_kj) = 12
         THEN 'Pro'
         WHEN MIN(mo_kj) = 1
         THEN 'Led'
         WHEN MIN(mo_kj) = 2
         THEN 'Uno'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KT' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Bre'
       WHEN MIN(mo_kj) = 4
       THEN 'Dub'
       WHEN MIN(mo_kj) = 5
       THEN 'Kve'
       WHEN MIN(mo_kj) = 6
       THEN 'Cer'
       WHEN MIN(mo_kj) = 7
       THEN 'Cvc'
       WHEN MIN(mo_kj) = 8
       THEN 'Srp'
       WHEN MIN(mo_kj) = 9
       THEN 'Zar'
       WHEN MIN(mo_kj) = 10
       THEN 'Rij'
       WHEN MIN(mo_kj) = 11
       THEN 'Lis'
       WHEN MIN(mo_kj) = 12
       THEN 'Pro'
       WHEN MIN(mo_kj) = 1
       THEN 'Led'
       WHEN MIN(mo_kj) = 2
       THEN 'Uno'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_cz,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Mar'
         WHEN MIN(mo_kj) = 4
         THEN 'Apr'
         WHEN MIN(mo_kj) = 5
         THEN 'Maj'
         WHEN MIN(mo_kj) = 6
         THEN 'Jun'
         WHEN MIN(mo_kj) = 7
         THEN 'Jul'
         WHEN MIN(mo_kj) = 8
         THEN 'Aug'
         WHEN MIN(mo_kj) = 9
         THEN 'Sep'
         WHEN MIN(mo_kj) = 10
         THEN 'Okt'
         WHEN MIN(mo_kj) = 11
         THEN 'Nov'
         WHEN MIN(mo_kj) = 12
         THEN 'Dec'
         WHEN MIN(mo_kj) = 1
         THEN 'Jan'
         WHEN MIN(mo_kj) = 2
         THEN 'Feb'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'GJ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Mar'
       WHEN MIN(mo_kj) = 4
       THEN 'Apr'
       WHEN MIN(mo_kj) = 5
       THEN 'Maj'
       WHEN MIN(mo_kj) = 6
       THEN 'Jun'
       WHEN MIN(mo_kj) = 7
       THEN 'Jul'
       WHEN MIN(mo_kj) = 8
       THEN 'Aug'
       WHEN MIN(mo_kj) = 9
       THEN 'Sep'
       WHEN MIN(mo_kj) = 10
       THEN 'Okt'
       WHEN MIN(mo_kj) = 11
       THEN 'Nov'
       WHEN MIN(mo_kj) = 12
       THEN 'Dec'
       WHEN MIN(mo_kj) = 1
       THEN 'Jan'
       WHEN MIN(mo_kj) = 2
       THEN 'Feb'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_sk,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'PG' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Ozu'
         WHEN MIN(mo_kj) = 4
         THEN 'Tra'
         WHEN MIN(mo_kj) = 5
         THEN 'Svi'
         WHEN MIN(mo_kj) = 6
         THEN 'Lip'
         WHEN MIN(mo_kj) = 7
         THEN 'Srp'
         WHEN MIN(mo_kj) = 8
         THEN 'Kol'
         WHEN MIN(mo_kj) = 9
         THEN 'Ruj'
         WHEN MIN(mo_kj) = 10
         THEN 'Lis'
         WHEN MIN(mo_kj) = 11
         THEN 'Stu'
         WHEN MIN(mo_kj) = 12
         THEN 'Pro'
         WHEN MIN(mo_kj) = 1
         THEN 'Sij'
         WHEN MIN(mo_kj) = 2
         THEN 'Vel'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'PG' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Ozu'
       WHEN MIN(mo_kj) = 4
       THEN 'Tra'
       WHEN MIN(mo_kj) = 5
       THEN 'Svi'
       WHEN MIN(mo_kj) = 6
       THEN 'Lip'
       WHEN MIN(mo_kj) = 7
       THEN 'Srp'
       WHEN MIN(mo_kj) = 8
       THEN 'Kol'
       WHEN MIN(mo_kj) = 9
       THEN 'Ruj'
       WHEN MIN(mo_kj) = 10
       THEN 'Lis'
       WHEN MIN(mo_kj) = 11
       THEN 'Stu'
       WHEN MIN(mo_kj) = 12
       THEN 'Pro'
       WHEN MIN(mo_kj) = 1
       THEN 'Sij'
       WHEN MIN(mo_kj) = 2
       THEN 'Vel'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_hr,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'RO' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Mar'
         WHEN MIN(mo_kj) = 4
         THEN 'Kwi'
         WHEN MIN(mo_kj) = 5
         THEN 'Maj'
         WHEN MIN(mo_kj) = 6
         THEN 'Cze'
         WHEN MIN(mo_kj) = 7
         THEN 'Lip'
         WHEN MIN(mo_kj) = 8
         THEN 'Sie'
         WHEN MIN(mo_kj) = 9
         THEN 'Wrz'
         WHEN MIN(mo_kj) = 10
         THEN 'Paź'
         WHEN MIN(mo_kj) = 11
         THEN 'Lis'
         WHEN MIN(mo_kj) = 12
         THEN 'Gru'
         WHEN MIN(mo_kj) = 1
         THEN 'Sty'
         WHEN MIN(mo_kj) = 2
         THEN 'Lut'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'skum'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'RO' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Mar'
       WHEN MIN(mo_kj) = 4
       THEN 'Kwi'
       WHEN MIN(mo_kj) = 5
       THEN 'Maj'
       WHEN MIN(mo_kj) = 6
       THEN 'Cze'
       WHEN MIN(mo_kj) = 7
       THEN 'Lip'
       WHEN MIN(mo_kj) = 8
       THEN 'Sie'
       WHEN MIN(mo_kj) = 9
       THEN 'Wrz'
       WHEN MIN(mo_kj) = 10
       THEN 'Paź'
       WHEN MIN(mo_kj) = 11
       THEN 'Lis'
       WHEN MIN(mo_kj) = 12
       THEN 'Gru'
       WHEN MIN(mo_kj) = 1
       THEN 'Sty'
       WHEN MIN(mo_kj) = 2
       THEN 'Lut'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_pl,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'AF' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Mar'
         WHEN MIN(mo_kj) = 4
         THEN 'Apr'
         WHEN MIN(mo_kj) = 5
         THEN 'Mai'
         WHEN MIN(mo_kj) = 6
         THEN 'Iun'
         WHEN MIN(mo_kj) = 7
         THEN 'Iul'
         WHEN MIN(mo_kj) = 8
         THEN 'Aug'
         WHEN MIN(mo_kj) = 9
         THEN 'Sep'
         WHEN MIN(mo_kj) = 10
         THEN 'Oct'
         WHEN MIN(mo_kj) = 11
         THEN 'Noi'
         WHEN MIN(mo_kj) = 12
         THEN 'Dec'
         WHEN MIN(mo_kj) = 1
         THEN 'Ian'
         WHEN MIN(mo_kj) = 2
         THEN 'Feb'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'cum'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'AF' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'KW' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Mar'
       WHEN MIN(mo_kj) = 4
       THEN 'Apr'
       WHEN MIN(mo_kj) = 5
       THEN 'Mai'
       WHEN MIN(mo_kj) = 6
       THEN 'Iun'
       WHEN MIN(mo_kj) = 7
       THEN 'Iul'
       WHEN MIN(mo_kj) = 8
       THEN 'Aug'
       WHEN MIN(mo_kj) = 9
       THEN 'Sep'
       WHEN MIN(mo_kj) = 10
       THEN 'Oct'
       WHEN MIN(mo_kj) = 11
       THEN 'Noi'
       WHEN MIN(mo_kj) = 12
       THEN 'Dec'
       WHEN MIN(mo_kj) = 1
       THEN 'Ian'
       WHEN MIN(mo_kj) = 2
       THEN 'Feb'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_ro,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
      THEN 'ФГ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
      WHEN zeit_id BETWEEN - 99 AND 99
      THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
      WHEN zeit_id BETWEEN - 990 AND 990
      THEN 'КС' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
      WHEN zeit_id BETWEEN - 19900 AND 19900
      THEN CASE
         WHEN MIN(mo_kj) = 3
         THEN 'Март'
         WHEN MIN(mo_kj) = 4
         THEN 'Апр'
         WHEN MIN(mo_kj) = 5
         THEN 'Май'
         WHEN MIN(mo_kj) = 6
         THEN 'Юни'
         WHEN MIN(mo_kj) = 7
         THEN 'Юли'
         WHEN MIN(mo_kj) = 8
         THEN 'Авг'
         WHEN MIN(mo_kj) = 9
         THEN 'Септ'
         WHEN MIN(mo_kj) = 10
         THEN 'Окт'
         WHEN MIN(mo_kj) = 11
         THEN 'Ноем'
         WHEN MIN(mo_kj) = 12
         THEN 'Дек'
         WHEN MIN(mo_kj) = 1
         THEN 'Яну'
         WHEN MIN(mo_kj) = 2
         THEN 'Февр'
         ELSE ''
         END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
      ELSE '--'
      END AS STRING) || ' ' || 'кум'
  ELSE CAST(CASE
    WHEN zeit_id IN (- 20000, - 10000, 10000, 20000)
    THEN 'ФГ' || ' ' || TRIM(SUBSTR(CAST(MIN(gj) AS STRING), 1, 39))
    WHEN zeit_id BETWEEN - 99 AND 99
    THEN TRIM(FORMAT_DATE('%d.%m.%y', MIN(dat)))
    WHEN zeit_id BETWEEN - 990 AND 990
    THEN 'КС' || ' ' || TRIM(CAST(MOD(CAST(MIN(kjwo) AS BIGNUMERIC), 100) AS STRING FORMAT '00'))
    WHEN zeit_id BETWEEN - 19900 AND 19900
    THEN CASE
       WHEN MIN(mo_kj) = 3
       THEN 'Март'
       WHEN MIN(mo_kj) = 4
       THEN 'Апр'
       WHEN MIN(mo_kj) = 5
       THEN 'Май'
       WHEN MIN(mo_kj) = 6
       THEN 'Юни'
       WHEN MIN(mo_kj) = 7
       THEN 'Юли'
       WHEN MIN(mo_kj) = 8
       THEN 'Авг'
       WHEN MIN(mo_kj) = 9
       THEN 'Септ'
       WHEN MIN(mo_kj) = 10
       THEN 'Окт'
       WHEN MIN(mo_kj) = 11
       THEN 'Ноем'
       WHEN MIN(mo_kj) = 12
       THEN 'Дек'
       WHEN MIN(mo_kj) = 1
       THEN 'Яну'
       WHEN MIN(mo_kj) = 2
       THEN 'Февр'
       ELSE ''
       END || ' ' || TRIM(SUBSTR(CAST(MIN(MOD(CAST(kj AS BIGNUMERIC), 100)) AS STRING), 1, 10))
    ELSE '--'
    END AS STRING)
  END AS zeit_tag_bez_bg,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Heute'
      WHEN zeit_id = 0
      THEN 'Vortag'
      WHEN zeit_id = - 1
      THEN 'vor 2 Tagen'
      WHEN zeit_id = - 2
      THEN 'vor 3 Tagen'
      WHEN zeit_id = - 100
      THEN 'aktuelle Woche_2'
      WHEN zeit_id = - 110
      THEN 'Vorwoche'
      WHEN zeit_id = - 120
      THEN 'vor 2 Wochen'
      WHEN zeit_id = - 130
      THEN 'vor 3 Wochen'
      WHEN zeit_id = - 1000
      THEN 'aktueller Monat_2'
      WHEN zeit_id = - 1100
      THEN 'Vormonat'
      WHEN zeit_id = - 1200
      THEN 'vor 2 Monaten'
      WHEN zeit_id = - 1300
      THEN 'vor 3 Monaten'
      WHEN zeit_id = - 10000
      THEN 'aktuelles GJ'
      WHEN zeit_id = - 20000
      THEN 'vorheriges GJ'
      ELSE ''
      END AS STRING) || ' ' || 'aufg'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Heute'
    WHEN zeit_id = 0
    THEN 'Vortag'
    WHEN zeit_id = - 1
    THEN 'vor 2 Tagen'
    WHEN zeit_id = - 2
    THEN 'vor 3 Tagen'
    WHEN zeit_id = - 100
    THEN 'aktuelle Woche_2'
    WHEN zeit_id = - 110
    THEN 'Vorwoche'
    WHEN zeit_id = - 120
    THEN 'vor 2 Wochen'
    WHEN zeit_id = - 130
    THEN 'vor 3 Wochen'
    WHEN zeit_id = - 1000
    THEN 'aktueller Monat_2'
    WHEN zeit_id = - 1100
    THEN 'Vormonat'
    WHEN zeit_id = - 1200
    THEN 'vor 2 Monaten'
    WHEN zeit_id = - 1300
    THEN 'vor 3 Monaten'
    WHEN zeit_id = - 10000
    THEN 'aktuelles GJ'
    WHEN zeit_id = - 20000
    THEN 'vorheriges GJ'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Dnes'
      WHEN zeit_id = 0
      THEN 'Předchozí den'
      WHEN zeit_id = - 1
      THEN 'Před 2 dny'
      WHEN zeit_id = - 2
      THEN 'Před 3 dny'
      WHEN zeit_id = - 100
      THEN 'Aktuální t\u00fdden'
      WHEN zeit_id = - 110
      THEN 'Předchozí týden'
      WHEN zeit_id = - 120
      THEN 'Před 2 týdny'
      WHEN zeit_id = - 130
      THEN 'Před 3 týdny'
      WHEN zeit_id = - 1000
      THEN 'Aktuální měsíc'
      WHEN zeit_id = - 1100
      THEN 'Předchozí měsíc'
      WHEN zeit_id = - 1200
      THEN 'Před 2 měsíci'
      WHEN zeit_id = - 1300
      THEN 'Před 3 měsíci'
      WHEN zeit_id = - 10000
      THEN 'Aktuální GJ'
      WHEN zeit_id = - 20000
      THEN 'Minul\u00fd GJ'
      ELSE ''
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Dnes'
    WHEN zeit_id = 0
    THEN 'Předchozí den'
    WHEN zeit_id = - 1
    THEN 'Před 2 dny'
    WHEN zeit_id = - 2
    THEN 'Před 3 dny'
    WHEN zeit_id = - 100
    THEN 'Aktuální t\u00fdden'
    WHEN zeit_id = - 110
    THEN 'Předchozí týden'
    WHEN zeit_id = - 120
    THEN 'Před 2 týdny'
    WHEN zeit_id = - 130
    THEN 'Před 3 týdny'
    WHEN zeit_id = - 1000
    THEN 'Aktuální měsíc'
    WHEN zeit_id = - 1100
    THEN 'Předchozí měsíc'
    WHEN zeit_id = - 1200
    THEN 'Před 2 měsíci'
    WHEN zeit_id = - 1300
    THEN 'Před 3 měsíci'
    WHEN zeit_id = - 10000
    THEN 'Aktuální GJ'
    WHEN zeit_id = - 20000
    THEN 'Minul\u00fd GJ'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_cz,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Dnes'
      WHEN zeit_id = 0
      THEN 'Včera'
      WHEN zeit_id = - 1
      THEN 'Pred 2 dňami'
      WHEN zeit_id = - 2
      THEN 'Pred 3 dňami'
      WHEN zeit_id = - 100
      THEN 'Aktuálny týždeň'
      WHEN zeit_id = - 110
      THEN 'Predchádzajúci týždeň'
      WHEN zeit_id = - 120
      THEN 'Pred 2 týždňami'
      WHEN zeit_id = - 130
      THEN 'Pred 3 týždňami'
      WHEN zeit_id = - 1000
      THEN 'Aktuálny mesiac'
      WHEN zeit_id = - 1100
      THEN 'Predchádzajúci mesiac'
      WHEN zeit_id = - 1200
      THEN 'Pred 2 mesiacmi'
      WHEN zeit_id = - 1300
      THEN 'Pred 3 mesiacmi'
      WHEN zeit_id = - 10000
      THEN 'Aktuálny GJ'
      WHEN zeit_id = - 20000
      THEN 'Minul\u00fd GJ'
      ELSE ''
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Dnes'
    WHEN zeit_id = 0
    THEN 'Včera'
    WHEN zeit_id = - 1
    THEN 'Pred 2 dňami'
    WHEN zeit_id = - 2
    THEN 'Pred 3 dňami'
    WHEN zeit_id = - 100
    THEN 'Aktuálny týždeň'
    WHEN zeit_id = - 110
    THEN 'Predchádzajúci týždeň'
    WHEN zeit_id = - 120
    THEN 'Pred 2 týždňami'
    WHEN zeit_id = - 130
    THEN 'Pred 3 týždňami'
    WHEN zeit_id = - 1000
    THEN 'Aktuálny mesiac'
    WHEN zeit_id = - 1100
    THEN 'Predchádzajúci mesiac'
    WHEN zeit_id = - 1200
    THEN 'Pred 2 mesiacmi'
    WHEN zeit_id = - 1300
    THEN 'Pred 3 mesiacmi'
    WHEN zeit_id = - 10000
    THEN 'Aktuálny GJ'
    WHEN zeit_id = - 20000
    THEN 'Minul\u00fd GJ'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_sk,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Danas'
      WHEN zeit_id = 0
      THEN 'Prethodni dan'
      WHEN zeit_id = - 1
      THEN 'prije 2 dana'
      WHEN zeit_id = - 2
      THEN 'prije 3 dana'
      WHEN zeit_id = - 100
      THEN 'Aktualni tjedan'
      WHEN zeit_id = - 110
      THEN 'Prošli tjedan'
      WHEN zeit_id = - 120
      THEN 'prije 2 tjedna'
      WHEN zeit_id = - 130
      THEN 'prije 3 tjedna'
      WHEN zeit_id = - 1000
      THEN 'Aktualni mjesec'
      WHEN zeit_id = - 1100
      THEN 'Prošli mjesec'
      WHEN zeit_id = - 1200
      THEN 'prije 2 mjeseca'
      WHEN zeit_id = - 1300
      THEN 'prije 3 mjeseca'
      WHEN zeit_id = - 10000
      THEN 'Aktualna PG'
      WHEN zeit_id = - 20000
      THEN 'Prošla PG'
      ELSE ''
      END AS STRING) || ' ' || 'kum'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Danas'
    WHEN zeit_id = 0
    THEN 'Prethodni dan'
    WHEN zeit_id = - 1
    THEN 'prije 2 dana'
    WHEN zeit_id = - 2
    THEN 'prije 3 dana'
    WHEN zeit_id = - 100
    THEN 'Aktualni tjedan'
    WHEN zeit_id = - 110
    THEN 'Prošli tjedan'
    WHEN zeit_id = - 120
    THEN 'prije 2 tjedna'
    WHEN zeit_id = - 130
    THEN 'prije 3 tjedna'
    WHEN zeit_id = - 1000
    THEN 'Aktualni mjesec'
    WHEN zeit_id = - 1100
    THEN 'Prošli mjesec'
    WHEN zeit_id = - 1200
    THEN 'prije 2 mjeseca'
    WHEN zeit_id = - 1300
    THEN 'prije 3 mjeseca'
    WHEN zeit_id = - 10000
    THEN 'Aktualna PG'
    WHEN zeit_id = - 20000
    THEN 'Prošla PG'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_hr,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Dzisiaj'
      WHEN zeit_id = 0
      THEN 'Poprzedni dzień'
      WHEN zeit_id = - 1
      THEN '2 dni temu'
      WHEN zeit_id = - 2
      THEN '3 dni temu'
      WHEN zeit_id = - 100
      THEN 'Aktualny tydzień'
      WHEN zeit_id = - 110
      THEN 'Poprzedni tydzień'
      WHEN zeit_id = - 120
      THEN '2 tygodnie temu'
      WHEN zeit_id = - 130
      THEN '3 tygodnie temu'
      WHEN zeit_id = - 1000
      THEN 'Aktualny miesiąc'
      WHEN zeit_id = - 1100
      THEN 'Poprzedni miesiąc'
      WHEN zeit_id = - 1200
      THEN '2 miesiące temu'
      WHEN zeit_id = - 1300
      THEN '3 miesiące temu'
      WHEN zeit_id = - 10000
      THEN 'Aktualny RO'
      WHEN zeit_id = - 20000
      THEN 'Poprzedni RO'
      ELSE ''
      END AS STRING) || ' ' || 'skum'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Dzisiaj'
    WHEN zeit_id = 0
    THEN 'Poprzedni dzień'
    WHEN zeit_id = - 1
    THEN '2 dni temu'
    WHEN zeit_id = - 2
    THEN '3 dni temu'
    WHEN zeit_id = - 100
    THEN 'Aktualny tydzień'
    WHEN zeit_id = - 110
    THEN 'Poprzedni tydzień'
    WHEN zeit_id = - 120
    THEN '2 tygodnie temu'
    WHEN zeit_id = - 130
    THEN '3 tygodnie temu'
    WHEN zeit_id = - 1000
    THEN 'Aktualny miesiąc'
    WHEN zeit_id = - 1100
    THEN 'Poprzedni miesiąc'
    WHEN zeit_id = - 1200
    THEN '2 miesiące temu'
    WHEN zeit_id = - 1300
    THEN '3 miesiące temu'
    WHEN zeit_id = - 10000
    THEN 'Aktualny RO'
    WHEN zeit_id = - 20000
    THEN 'Poprzedni RO'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_pl,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Azi'
      WHEN zeit_id = 0
      THEN 'ziua anterioară'
      WHEN zeit_id = - 1
      THEN '2 zile în urmă'
      WHEN zeit_id = - 2
      THEN '3 zile în urmă'
      WHEN zeit_id = - 100
      THEN 'Săptămână actuală'
      WHEN zeit_id = - 110
      THEN 'Săptămâna trecută'
      WHEN zeit_id = - 120
      THEN 'Acum 2 Săptămâni'
      WHEN zeit_id = - 130
      THEN 'Acum 3 Săptămâni'
      WHEN zeit_id = - 1000
      THEN 'Luna actuală'
      WHEN zeit_id = - 1100
      THEN 'Luna trecută'
      WHEN zeit_id = - 1200
      THEN '2 luni în urmă'
      WHEN zeit_id = - 1300
      THEN '3 luni în urmă'
      WHEN zeit_id = - 10000
      THEN 'AF actual'
      WHEN zeit_id = - 20000
      THEN 'AF anterior'
      ELSE ''
      END AS STRING) || ' ' || 'cum'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Azi'
    WHEN zeit_id = 0
    THEN 'ziua anterioară'
    WHEN zeit_id = - 1
    THEN '2 zile în urmă'
    WHEN zeit_id = - 2
    THEN '3 zile în urmă'
    WHEN zeit_id = - 100
    THEN 'Săptămână actuală'
    WHEN zeit_id = - 110
    THEN 'Săptămâna trecută'
    WHEN zeit_id = - 120
    THEN 'Acum 2 Săptămâni'
    WHEN zeit_id = - 130
    THEN 'Acum 3 Săptămâni'
    WHEN zeit_id = - 1000
    THEN 'Luna actuală'
    WHEN zeit_id = - 1100
    THEN 'Luna trecută'
    WHEN zeit_id = - 1200
    THEN '2 luni în urmă'
    WHEN zeit_id = - 1300
    THEN '3 luni în urmă'
    WHEN zeit_id = - 10000
    THEN 'AF actual'
    WHEN zeit_id = - 20000
    THEN 'AF anterior'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_ro,
  CASE
  WHEN CAST(CASE
     WHEN zeit_id IN (- 100, - 1000, - 10000)
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) = 1
  THEN CAST(CASE
      WHEN zeit_id = 1
      THEN 'Днес'
      WHEN zeit_id = 0
      THEN 'Предишен ден'
      WHEN zeit_id = - 1
      THEN '2 дни назад'
      WHEN zeit_id = - 2
      THEN '3 дни назад'
      WHEN zeit_id = - 100
      THEN 'Текуща седмица'
      WHEN zeit_id = - 110
      THEN 'Предходна седмица'
      WHEN zeit_id = - 120
      THEN '2 седмици назад'
      WHEN zeit_id = - 130
      THEN '3 седмици назад'
      WHEN zeit_id = - 1000
      THEN 'Текущ месец'
      WHEN zeit_id = - 1100
      THEN 'Предходен месец'
      WHEN zeit_id = - 1200
      THEN '2 месеца назад '
      WHEN zeit_id = - 1300
      THEN '3 месеца назад'
      WHEN zeit_id = - 10000
      THEN 'Текуща ФГ'
      WHEN zeit_id = - 20000
      THEN 'Предходна ФГ'
      ELSE ''
      END AS STRING) || ' ' || 'кум'
  ELSE CAST(CASE
    WHEN zeit_id = 1
    THEN 'Днес'
    WHEN zeit_id = 0
    THEN 'Предишен ден'
    WHEN zeit_id = - 1
    THEN '2 дни назад'
    WHEN zeit_id = - 2
    THEN '3 дни назад'
    WHEN zeit_id = - 100
    THEN 'Текуща седмица'
    WHEN zeit_id = - 110
    THEN 'Предходна седмица'
    WHEN zeit_id = - 120
    THEN '2 седмици назад'
    WHEN zeit_id = - 130
    THEN '3 седмици назад'
    WHEN zeit_id = - 1000
    THEN 'Текущ месец'
    WHEN zeit_id = - 1100
    THEN 'Предходен месец'
    WHEN zeit_id = - 1200
    THEN '2 месеца назад '
    WHEN zeit_id = - 1300
    THEN '3 месеца назад'
    WHEN zeit_id = - 10000
    THEN 'Текуща ФГ'
    WHEN zeit_id = - 20000
    THEN 'Предходна ФГ'
    ELSE ''
    END AS STRING)
  END AS zeit_bm_bez_bg,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'März'
  WHEN MIN(mo_kj) = 4
  THEN 'Apr'
  WHEN MIN(mo_kj) = 5
  THEN 'Mai'
  WHEN MIN(mo_kj) = 6
  THEN 'Juni'
  WHEN MIN(mo_kj) = 7
  THEN 'Juli'
  WHEN MIN(mo_kj) = 8
  THEN 'Aug'
  WHEN MIN(mo_kj) = 9
  THEN 'Sept'
  WHEN MIN(mo_kj) = 10
  THEN 'Okt'
  WHEN MIN(mo_kj) = 11
  THEN 'Nov'
  WHEN MIN(mo_kj) = 12
  THEN 'Dez'
  WHEN MIN(mo_kj) = 1
  THEN 'Jan'
  WHEN MIN(mo_kj) = 2
  THEN 'Feb'
  ELSE ''
  END AS mo_de,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Bre'
  WHEN MIN(mo_kj) = 4
  THEN 'Dub'
  WHEN MIN(mo_kj) = 5
  THEN 'Kve'
  WHEN MIN(mo_kj) = 6
  THEN 'Cer'
  WHEN MIN(mo_kj) = 7
  THEN 'Cvc'
  WHEN MIN(mo_kj) = 8
  THEN 'Srp'
  WHEN MIN(mo_kj) = 9
  THEN 'Zar'
  WHEN MIN(mo_kj) = 10
  THEN 'Rij'
  WHEN MIN(mo_kj) = 11
  THEN 'Lis'
  WHEN MIN(mo_kj) = 12
  THEN 'Pro'
  WHEN MIN(mo_kj) = 1
  THEN 'Led'
  WHEN MIN(mo_kj) = 2
  THEN 'Uno'
  ELSE ''
  END AS mo_cz,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Mar'
  WHEN MIN(mo_kj) = 4
  THEN 'Apr'
  WHEN MIN(mo_kj) = 5
  THEN 'Maj'
  WHEN MIN(mo_kj) = 6
  THEN 'Jun'
  WHEN MIN(mo_kj) = 7
  THEN 'Jul'
  WHEN MIN(mo_kj) = 8
  THEN 'Aug'
  WHEN MIN(mo_kj) = 9
  THEN 'Sep'
  WHEN MIN(mo_kj) = 10
  THEN 'Okt'
  WHEN MIN(mo_kj) = 11
  THEN 'Nov'
  WHEN MIN(mo_kj) = 12
  THEN 'Dec'
  WHEN MIN(mo_kj) = 1
  THEN 'Jan'
  WHEN MIN(mo_kj) = 2
  THEN 'Feb'
  ELSE ''
  END AS mo_sk,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Ozu'
  WHEN MIN(mo_kj) = 4
  THEN 'Tra'
  WHEN MIN(mo_kj) = 5
  THEN 'Svi'
  WHEN MIN(mo_kj) = 6
  THEN 'Lip'
  WHEN MIN(mo_kj) = 7
  THEN 'Srp'
  WHEN MIN(mo_kj) = 8
  THEN 'Kol'
  WHEN MIN(mo_kj) = 9
  THEN 'Ruj'
  WHEN MIN(mo_kj) = 10
  THEN 'Lis'
  WHEN MIN(mo_kj) = 11
  THEN 'Stu'
  WHEN MIN(mo_kj) = 12
  THEN 'Pro'
  WHEN MIN(mo_kj) = 1
  THEN 'Sij'
  WHEN MIN(mo_kj) = 2
  THEN 'Vel'
  ELSE ''
  END AS mo_hr,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Mar'
  WHEN MIN(mo_kj) = 4
  THEN 'Kwi'
  WHEN MIN(mo_kj) = 5
  THEN 'Maj'
  WHEN MIN(mo_kj) = 6
  THEN 'Cze'
  WHEN MIN(mo_kj) = 7
  THEN 'Lip'
  WHEN MIN(mo_kj) = 8
  THEN 'Sie'
  WHEN MIN(mo_kj) = 9
  THEN 'Wrz'
  WHEN MIN(mo_kj) = 10
  THEN 'Paź'
  WHEN MIN(mo_kj) = 11
  THEN 'Lis'
  WHEN MIN(mo_kj) = 12
  THEN 'Gru'
  WHEN MIN(mo_kj) = 1
  THEN 'Sty'
  WHEN MIN(mo_kj) = 2
  THEN 'Lut'
  ELSE ''
  END AS mo_pl,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Mar'
  WHEN MIN(mo_kj) = 4
  THEN 'Apr'
  WHEN MIN(mo_kj) = 5
  THEN 'Mai'
  WHEN MIN(mo_kj) = 6
  THEN 'Iun'
  WHEN MIN(mo_kj) = 7
  THEN 'Iul'
  WHEN MIN(mo_kj) = 8
  THEN 'Aug'
  WHEN MIN(mo_kj) = 9
  THEN 'Sep'
  WHEN MIN(mo_kj) = 10
  THEN 'Oct'
  WHEN MIN(mo_kj) = 11
  THEN 'Noi'
  WHEN MIN(mo_kj) = 12
  THEN 'Dec'
  WHEN MIN(mo_kj) = 1
  THEN 'Ian'
  WHEN MIN(mo_kj) = 2
  THEN 'Feb'
  ELSE ''
  END AS mo_ro,
  CASE
  WHEN MIN(mo_kj) = 3
  THEN 'Март'
  WHEN MIN(mo_kj) = 4
  THEN 'Апр'
  WHEN MIN(mo_kj) = 5
  THEN 'Май'
  WHEN MIN(mo_kj) = 6
  THEN 'Юни'
  WHEN MIN(mo_kj) = 7
  THEN 'Юли'
  WHEN MIN(mo_kj) = 8
  THEN 'Авг'
  WHEN MIN(mo_kj) = 9
  THEN 'Септ'
  WHEN MIN(mo_kj) = 10
  THEN 'Окт'
  WHEN MIN(mo_kj) = 11
  THEN 'Ноем'
  WHEN MIN(mo_kj) = 12
  THEN 'Дек'
  WHEN MIN(mo_kj) = 1
  THEN 'Яну'
  WHEN MIN(mo_kj) = 2
  THEN 'Февр'
  ELSE ''
  END AS mo_bg,
 'GJ' AS gj_de,
 'GJ' AS gj_cz,
 'GJ' AS gj_sk,
 'PG' AS gj_hr,
 'RO' AS gj_pl,
 'AF' AS gj_ro,
 'ФГ' AS gj_bg,
 'KW' AS kw_de,
 'KT' AS kw_cz,
 'KW' AS kw_sk,
 'KW' AS kw_hr,
 'KW' AS kw_pl,
 'KW' AS kw_ro,
 'КС' AS kw_bg,
 'aufg' AS aufg_de,
 'kum' AS aufg_cz,
 'kum' AS aufg_sk,
 'kum' AS aufg_hr,
 'skum' AS aufg_pl,
 'cum' AS aufg_ro,
 'кум' AS aufg_bg
FROM kfl_production_dbp_msi_view_vis.mv_zeit_tag_zu_2
GROUP BY zeit_id;