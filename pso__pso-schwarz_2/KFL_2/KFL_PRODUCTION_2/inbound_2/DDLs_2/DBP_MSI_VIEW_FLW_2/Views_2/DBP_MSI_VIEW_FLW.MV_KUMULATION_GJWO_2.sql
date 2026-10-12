CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KUMULATION_GJWO_2
AS

   SELECT  w1.gjwo AS gjwo_kum, w2.gjwo gjwo
   FROM dbp_view.v_woche_2 w1
   INNER    JOIN dbp_view.v_woche_2 w2
   ON TRUNC( w1.gjwo/100) = TRUNC( w2.gjwo/ 100)  AND
   w1.gjwo  <= w2.gjwo;