CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_RUNDLAUF_1
AS
   SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1) AS BYTEINT) AS  mandant_id, 10 AS rundlauf_transport_fg, 'Industrieabholung' AS  rundlauf_transport_bez
   FROM dbp_view.v_tag_1
   WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE

   UNION

   SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1) AS BYTEINT) AS mandant_id, 1 AS rundlauf_transport_fg, 'Rundlauf'  AS rundlauf_transport_bez
   FROM dbp_view.v_tag_1
   WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE

   UNION

   SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1) AS BYTEINT) AS  mandant_id, 0 AS rundlauf_transport_fg, 'OneWay' AS  rundlauf_transport_bez
   FROM dbp_view.v_tag_1
   WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE;