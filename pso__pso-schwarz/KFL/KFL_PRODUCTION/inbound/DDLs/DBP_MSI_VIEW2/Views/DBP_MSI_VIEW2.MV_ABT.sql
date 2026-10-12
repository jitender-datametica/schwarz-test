CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ABT as
   -- 20100908 : Filterung Abteilungen (abt_id)
   -- 20120925: abti_id Filterung von "bis 6" auf "bis 8" geändert
   SELECT
   v01.mandant_id, v01.abt_id, v01.arthiertyp_id

   FROM dbp_view.v_abt  v01

   WHERE v01.arthiertyp_id = 2
   AND v01.mandant_id = 1
   AND v01.abt_id BETWEEN -3 AND 8;