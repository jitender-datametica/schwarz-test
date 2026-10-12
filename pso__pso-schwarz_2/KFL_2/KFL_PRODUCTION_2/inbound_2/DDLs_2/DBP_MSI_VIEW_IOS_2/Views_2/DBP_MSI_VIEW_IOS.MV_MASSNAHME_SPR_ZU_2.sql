CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MASSNAHME_SPR_ZU_2 as
   -- Faktview : Massnahmengruppe gemäß: AP0005260
   -- 20161129 tuts1605 : initial
   --20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung
   -- 201211 cbru1709: Änderungen laut Vorgabe von msar2108 übernommen.
   SELECT
   v01.massnahme_id, v01.massnahmenart_id, MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END) AS massnahmenart_bez                               -- standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  24 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18 THEN v02.massnahmenart_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN v02.massnahmenart_bez ELSE NULL END)) AS massnahmenart_bez_bg    -- BG
   , CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 10
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 30
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 40
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 50
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 70
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 90
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 110
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 130
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 150
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 170
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 190
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 210
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 230
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 260
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 290
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 320
   WHEN v01.massnahmenart_id = 999 THEN 999
   END AS massnahmen_gruppe_id, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Expansion | Neubau'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Übernahme'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Filialmaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernisierung'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Standortoptimierungsauftrag'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Schließung'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Marktgestaltung | Rückfilialisierung'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Sonstige Maßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Konzessionärsmaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Gastromaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Instandsetzungen | Sanierungen'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Expansion | Neubau Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Standortoptimierungsauftrag Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Baumaßnahme Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'sonstige Maßnahme Sonderbauten'
   WHEN v01.massnahmenart_id = 999 THEN 'nicht zugeordnet'
   END AS massnahmen_gruppe, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Novostavba'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Prevzetí'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Opatrení filiálky'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'MaMo'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'SOA'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Uzavrení'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Úprava / Rueckfilialisierung'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Ostatní stavební opatrení'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Opatrení koncesionáre_2'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Opatrení Gastro'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Opravy / Sanace'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Novostavba zvlátní nemovitosti'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'SOA zvlátní nemovitosti'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Stavební opatrení zvlátní nemovitosti'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'Ostatní stavební opatrení zvlátní nemovitosti'
   WHEN v01.massnahmenart_id = 999 THEN 'neprirazeno'
   END AS massnahmen_gruppe_cz, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Ekspansja | Budowa'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Przejecie'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Dzialania modernizacyjne FiMa'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernizacja marketu'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Optymalizacja lokalizacji'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Zamkniecie'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Organizowanie marketu | Wsteczne standaryzowanie'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Pozostale inwestycje '
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Inwestycje u najemców'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Inwestycje Gastro'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Remonty | Renowacje'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Ekspansja | Budowa Budowle specjalne'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Standortoptimierungsauftrag Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Optymalizacja lokalizacji Budowle specjalne'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'Pozostale inwestycje Budowle specjalne'
   WHEN v01.massnahmenart_id = 999 THEN 'nieprzyporzadkowany'
   END AS massnahmen_gruppe_pl, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN '????????? I ???? ????????????'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN '???????????'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN '???????? ???????? (FiMa)'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN '????????????'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN '??????? ?? ???????????'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN '??????'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN '?????????'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN '?????????? ?? ????????? I ????????? ?? ??? ???????? '
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN '????? ????????'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN '????????????? ????????'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN '???????? ???????????'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN '?????? I ????????'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN '????????? I ???? ???????????? ????????? ????????? '
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN '??????????? ????????? ?????????'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN '?????????? ???????? ????????? ?????????'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN '????? ???????? ????????? ????????? '
   WHEN v01.massnahmenart_id = 999 THEN '?? ?????????????'
   END AS massnahmen_gruppe_bg, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Ekspanizija|Novogradnja'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Preuzimanje'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Zahvati na poslovnici'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernizacija objekta'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Nalog za opmizaciju lokacije'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Zatvaranje'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Uredenje objekta/preuredenje'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Ostali zahvati'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Koncesionarski zahvati'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Gastro zahvati'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Popravci | sanacija'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Ekspanzija | Novogradnja posebnih gradevina'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Nalog za optimizaciju lokacije posebna gradevina'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Gradevinski zahvat posebna gradevina'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'Ostali zahvat posebna gradevina'
   WHEN v01.massnahmenart_id = 999 THEN 'nije dodijeljen'
   END AS massnahmen_gruppe_hr, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Expansiune| Imobil nou'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Preluare'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Masuri magazin'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernizare'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Comanda optimizare locatie'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Inchidere'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Schema magazin| Refilializare'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Alte masuri'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Masuri chiriasi'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Masuri gastro'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Reparatii| renovari'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Expansiune | Imobil nou cladire speciala'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Comanda optimizare locatie cladire speciala'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Masura constructie cladire speciala'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'alte masuri cladiri speciale'
   WHEN v01.massnahmenart_id = 999 THEN 'nealocat'
   END AS massnahmen_gruppe_ro, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Expanzia | Novostavba'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Prebierka'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Opatrenie pre filiálku'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernizácia'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Objednávka optimalizácie lokality'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Zatvorenie'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Utváranie trhu | Spätná filializácia'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Iné opatrenia'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Koncesionárske opatrenia'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Gastroopatrenia'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Údrby | Sanácie'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Expansion | Neubau Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Objednávka optimalizácie lokality zvlátnej stavby'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Stavebné opatrenia zvlátnych stavieb'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'ostatné opatrenia zvlátnych stavieb'
   WHEN v01.massnahmenart_id = 999 THEN 'nepriradené'
   END AS massnahmen_gruppe_sk


   FROM dbp_view.v_l_massnahme_2 v01
   --LEFT
   JOIN
   dbp_view.v_massnahmenart_spr_zu_2 v02
   ON v01.massnahmenart_id = v02.massnahmenart_id
   --LEFT
   JOIN
   dbp_view.v_l_massnahmenart_2 v03
   ON v01.massnahmenart_id = v03.massnahmenart_id
   -- AND v02.spr_id = 22;

   GROUP BY
   v01.massnahme_id
   , v01.massnahmenart_id;