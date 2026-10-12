CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_massnahme_spr_zu_2 AS SELECT V01.massnahme_id,
 V01.massnahmenart_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.massnahmenart_bez
   ELSE NULL
   END) AS massnahmenart_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.massnahmenart_bez
    ELSE NULL
    END)) AS massnahmenart_bez_bg,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 10
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 30
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 40
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 50
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 70
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 90
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 110
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 130
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 150
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 170
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 190
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 210
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 230
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 260
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 290
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 320
  WHEN V01.massnahmenart_id = 999
  THEN 999
  ELSE NULL
  END AS massnahmen_gruppe_id,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Expansion | Neubau'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Übernahme'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Filialma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernisierung'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Standortoptimierungsauftrag'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Schlie\u00dfung'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Marktgestaltung | Rückfilialisierung'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Sonstige Ma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Konzessionärsma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Gastroma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Instandsetzungen | Sanierungen'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Expansion | Neubau Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Standortoptimierungsauftrag Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Bauma\u00dfnahme Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'sonstige Ma\u00dfnahme Sonderbauten'
  WHEN V01.massnahmenart_id = 999
  THEN 'nicht zugeordnet'
  ELSE NULL
  END AS massnahmen_gruppe,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Novostavba'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Prevzetí'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Opatrení filiálky'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'MaMo'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'SOA'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Uzavrení'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN '\u00daprava / Rueckfilialisierung'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Ostatní stavební opatrení'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Opatrení koncesionáre_2'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Opatrení Gastro'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Opravy / Sanace'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Novostavba zvlá\u009atní nemovitosti'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'SOA zvlá\u009atní nemovitosti'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Stavební opatrení zvlá\u009atní nemovitosti'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'Ostatní stavební opatrení zvlá\u009atní nemovitosti'
  WHEN V01.massnahmenart_id = 999
  THEN 'neprirazeno'
  ELSE NULL
  END AS massnahmen_gruppe_cz,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Ekspansja | Budowa'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Przejecie'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Dzialania modernizacyjne FiMa'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernizacja marketu'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Optymalizacja lokalizacji'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Zamkniecie'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Organizowanie marketu | Wsteczne standaryzowanie'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Pozostale inwestycje '
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Inwestycje u najemców'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Inwestycje Gastro'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Remonty | Renowacje'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Ekspansja | Budowa Budowle specjalne'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Standortoptimierungsauftrag Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Optymalizacja lokalizacji Budowle specjalne'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'Pozostale inwestycje Budowle specjalne'
  WHEN V01.massnahmenart_id = 999
  THEN 'nieprzyporzadkowany'
  ELSE NULL
  END AS massnahmen_gruppe_pl,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN '????????? I ???? ????????????'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN '???????????'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN '???????? ???????? (FiMa)'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN '????????????'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN '??????? ?? ???????????'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN '??????'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN '?????????'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN '?????????? ?? ????????? I ????????? ?? ??? ???????? '
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN '????? ????????'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN '????????????? ????????'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN '???????? ???????????'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN '?????? I ????????'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN '????????? I ???? ???????????? ????????? ????????? '
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN '??????????? ????????? ?????????'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN '?????????? ???????? ????????? ?????????'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN '????? ???????? ????????? ????????? '
  WHEN V01.massnahmenart_id = 999
  THEN '?? ?????????????'
  ELSE NULL
  END AS massnahmen_gruppe_bg,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Ekspanizija|Novogradnja'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Preuzimanje'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Zahvati na poslovnici'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernizacija objekta'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Nalog za opmizaciju lokacije'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Zatvaranje'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Uredenje objekta/preuredenje'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Ostali zahvati'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Koncesionarski zahvati'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Gastro zahvati'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Popravci | sanacija'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Ekspanzija | Novogradnja posebnih gradevina'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Nalog za optimizaciju lokacije posebna gradevina'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Gradevinski zahvat posebna gradevina'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'Ostali zahvat posebna gradevina'
  WHEN V01.massnahmenart_id = 999
  THEN 'nije dodijeljen'
  ELSE NULL
  END AS massnahmen_gruppe_hr,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Expansiune| Imobil nou'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Preluare'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Masuri magazin'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernizare'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Comanda optimizare locatie'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Inchidere'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Schema magazin| Refilializare'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Alte masuri'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Masuri chiriasi'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Masuri gastro'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Reparatii| renovari'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Expansiune | Imobil nou cladire speciala'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Comanda optimizare locatie cladire speciala'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Masura constructie cladire speciala'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'alte masuri cladiri speciale'
  WHEN V01.massnahmenart_id = 999
  THEN 'nealocat'
  ELSE NULL
  END AS massnahmen_gruppe_ro,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Expanzia | Novostavba'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Prebierka'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Opatrenie pre filiálku'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernizácia'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Objednávka optimalizácie lokality'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Zatvorenie'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Utváranie trhu | Spätná filializácia'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Iné opatrenia'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Koncesionárske opatrenia'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Gastroopatrenia'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN '\u00dadr\u009eby | Sanácie'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Expansion | Neubau Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Objednávka optimalizácie lokality zvlá\u009atnej stavby'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Stavebné opatrenia zvlá\u009atnych stavieb'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'ostatné opatrenia zvlá\u009atnych stavieb'
  WHEN V01.massnahmenart_id = 999
  THEN 'nepriradené'
  ELSE NULL
  END AS massnahmen_gruppe_sk
FROM kfl_production_dbp_view.v_l_massnahme_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu_2 AS V02 ON V01.massnahmenart_id = V02.massnahmenart_id
 INNER JOIN kfl_production_dbp_view.v_l_massnahmenart_2 AS V03 ON V01.massnahmenart_id = V03.massnahmenart_id
GROUP BY V01.massnahme_id,
 V01.massnahmenart_id;