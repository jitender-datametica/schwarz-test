CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_TAG AS
-- 04.04.2013 AL initial
-- 20.06.2013 AL Anzahl Spalten auf notwendige reduziert & UNION Für DUMMY aufgenommen
-- 20.08.2013 dat_bez von Text auf Datum umgestellt, Dummy bekommt NULL statt blank
-- 20.08.2013/Gia

   SELECT
  dat,
   gjmo,
   gj,
   akt_gj,
   mo_gj,
   dat AS dat_bez
   FROM dbp_view.v_tag

   UNION

   SELECT
   '2010' dat,
   190001,
   1900,
   -9999,
   1,
   NULL AS dat_bez
  FROM dbp_view.v_tag
  WHERE dat=CURRENT_DATE
;