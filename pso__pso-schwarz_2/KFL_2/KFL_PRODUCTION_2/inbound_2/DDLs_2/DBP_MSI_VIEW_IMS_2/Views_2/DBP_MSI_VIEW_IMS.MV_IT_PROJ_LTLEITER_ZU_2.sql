CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IT_PROJ_LTLEITER_ZU_2 AS
-- 09.04.2013 AL Init

   SELECT
   it_projekt_id,
   ma_id  AS it_lt_leiter_id
  FROM dbp_view.v_it_projekt_ma_zu_2 v01
   WHERE v01.mandant_id=1 AND     ma_funktion_id='CLLTKIS';