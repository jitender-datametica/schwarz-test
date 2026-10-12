CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_REGIONAL_KZ_1 as
   SELECT CAST(1 AS BYTEINT)  AS mandant_id, CAST(0 AS BYTEINT) AS regional_kz, 'national' AS regional_bez
   FROM dbp_view.v_tag_1
   WHERE dat= CURRENT_DATE

   UNION

   SELECT 1, 1, 'regional'
   FROM dbp_view.v_tag_1
   WHERE dat= CURRENT_DATE;