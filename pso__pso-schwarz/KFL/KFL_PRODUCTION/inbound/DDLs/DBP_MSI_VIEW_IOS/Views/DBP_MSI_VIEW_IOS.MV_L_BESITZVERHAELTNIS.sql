CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_BESITZVERHAELTNIS as
   -- Faktview : Besitzverhaeltnis gemäß: AP0004980
   -- 20161202 kkai0912 : initial
   --20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez


   SELECT
   v01.besitzverhaeltnis_id
   /*  , v02.besitzverhaeltnis_bez*/

   FROM
   dbp_view.v_l_besitzverhaeltnis v01
   /*  JOIN dbp_view.v_besitzverhaeltnis_spr_zu v02
   ON v01.besitzverhaeltnis_id = v02.besitzverhaeltnis_id
   AND v02.spr_id = 22*/
   WHERE v01.besitzverhaeltnis_id <> '  -' -- wird ausgeschlossen über where anstelle des auskommentierten joins

   UNION ALL

   SELECT

   ' -1' AS besitzverhaeltnis_id
   /*,' ' AS besitzverhaeltnis_bez*/
   FROM
   dbp_view.v_l_besitzverhaeltnis v01
   GROUP BY 1/*,2*/;