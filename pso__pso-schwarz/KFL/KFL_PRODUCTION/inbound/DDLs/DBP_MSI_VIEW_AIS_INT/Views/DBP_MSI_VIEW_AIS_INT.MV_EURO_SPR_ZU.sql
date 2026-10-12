CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_EURO_SPR_ZU
(
mandant_id
,spr_id
,euro_bez
)
AS
   SELECT
   v03.mandant_id, v01.spr_id, euro_bez
   FROM
   (
   SELECT
   mandant_id, spr_id,
   CASE WHEN mandant_id = 1 THEN 'Bewertete Kennzahlen werden ab sofort in EURO angezeigt.'
   WHEN mandant_id =2 THEN 'Hodnoty ukazatelu se zacnou zobrazovat v mene EUR.'
   WHEN mandant_id = 3 THEN 'Wszystkie wskazniki beda od teraz wyceniane w EURO.'
   WHEN mandant_id = 4 THEN 'De acum Ã®nainte valorile indicatorilor vor fi afisate Ã®n Euro.'
   WHEN mandant_id = 5 THEN 'Hodnoty v reportoch budÃº od teraz zobrazenÃ© v mene EUR.'
   WHEN mandant_id = 6 THEN 'Vrijednosti  ce se od sada prikazivati  u valuti EURO.'
   WHEN mandant_id = 7 THEN 'De acum Ã®nainte valorile indicatorilor vor fi afisate Ã®n Euro.'
   WHEN mandant_id = 8 THEN '\u0421\u0442\u043E\u0439\u043D\u043E\u0441\u0442\u0438\u0442\u0435\u0020\u043D\u0430\u0020\u043F\u043E\u043A\u0430\u0437\u0430\u0442\u0435\u043B\u0438\u0442\u0435\u0020\u0449\u0435\u0020\u0441\u0435\u0020\u043F\u043E\u043A\u0430\u0437\u0432\u0430\u0442\u0020\u0432\u0020\u0415\u0412\u0420\u041E\u002E'
   END euro_bez

   FROM dbp_view.v_mandant_spr_zu
   ) v01
   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   CROSS JOIN dbp_view.v_mandant v03;