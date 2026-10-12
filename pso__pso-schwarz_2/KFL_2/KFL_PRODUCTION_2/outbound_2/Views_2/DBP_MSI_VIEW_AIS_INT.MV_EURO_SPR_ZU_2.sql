CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_euro_spr_zu_2 (mandant_id, spr_id, euro_bez) AS SELECT V03.mandant_id
 ,
 v01.spr_id,
 v01.euro_bez
FROM (SELECT mandant_id,
   spr_id,
    CASE
    WHEN mandant_id = 1
    THEN 'Bewertete Kennzahlen werden ab sofort in EURO angezeigt.'
    WHEN mandant_id = 2
    THEN 'Hodnoty ukazatelu se zacnou zobrazovat v mene EUR.'
    WHEN mandant_id = 3
    THEN 'Wszystkie wskazniki beda od teraz wyceniane w EURO.'
    WHEN mandant_id = 4
    THEN 'De acum \u00c3\u00aenainte valorile indicatorilor vor fi afisate \u00c3\u00aen Euro.'
    WHEN mandant_id = 5
    THEN 'Hodnoty v reportoch bud\u00c3º od teraz zobrazen\u00c3\u00a9 v mene EUR.'
    WHEN mandant_id = 6
    THEN 'Vrijednosti  ce se od sada prikazivati  u valuti EURO.'
    WHEN mandant_id = 7
    THEN 'De acum \u00c3\u00aenainte valorile indicatorilor vor fi afisate \u00c3\u00aen Euro.'
    WHEN mandant_id = 8
    THEN
    '\\u0421\\u0442\\u043E\\u0439\\u043D\\u043E\\u0441\\u0442\\u0438\\u0442\\u0435\\u0020\\u043D\\u0430\\u0020\\u043F\\u043E\\u043A\\u0430\\u0437\\u0430\\u0442\\u0435\\u043B\\u0438\\u0442\\u0435\\u0020\\u0449\\u0435\\u0020\\u0441\\u0435\\u0020\\u043F\\u043E\\u043A\\u0430\\u0437\\u0432\\u0430\\u0442\\u0020\\u0432\\u0020\\u0415\\u0412\\u0420\\u041E\\u002E'
    ELSE NULL
    END AS euro_bez
  FROM kfl_production_dbp_view.v_mandant_spr_zu_2) AS v01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON v01.spr_id = V02.spr_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V03 ON TRUE;