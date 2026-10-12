CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_F_GUTSCHEIN_1 
AS
-- 11.02.2016 twie: Gutscheine vom Gutscheinserver

   SELECT

   v01.gutschein_id
   , v01.mandant_id
   , v01.ausgeber_id
   , v01.kostenstelle_id
   , v01.zeitstempel
   , CAST(v01.zeitstempel AS VARCHAR)   AS dat
   , CAST(v01.zeitstempel AS TIME(6))  AS uhrzeit
   , v01.betrag_gutschein
   , v01.wrg_id
   , v01.geku_ticket_id

   FROM dbp_view.v_gutschein_1 v01

   WHERE transaktion_id = 4 --aktivierte Gutscheine

   --nur GEKU Gutscheine
   AND ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005';