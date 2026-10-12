CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_VIS_ZU as
   -- MAPPING : Inventurart VIS (Reporting)
   -- Kombination aus inventurart_int_id + abt_id
   -- 2019.1118 ssch0611 : Initial (Inventuren pro Artikel)
   -- 2019.1218 ssch0611 : Finetuning

   SELECT  DISTINCT
   abt.abt_id, inv.inventurart_int_id, CASE
   WHEN inv.inventurart_int_id NOT IN (8)
   AND abt.abt_id = 5                          THEN 10 -- Ultra-Frische (alles)
   WHEN inv.inventurart_int_id IN (1)          THEN 11 -- Flop
   WHEN inv.inventurart_int_id IN (2)          THEN 12 -- Sonder
   WHEN inv.inventurart_int_id IN (3, 6, 7)    THEN 13 -- OWG (Umgemappt)
   WHEN inv.inventurart_int_id IN (4)          THEN 14 -- Zwischen
   WHEN inv.inventurart_int_id IN (5)          THEN 15 -- Jahres
   ELSE 99                                             -- default (8 Historie GJ)
   END::BYTEINT AS inventurart_vis_id
   FROM dbp_view.v_abt_per  abt
   CROSS JOIN dbp_view.v_l_inventurart_int  inv;