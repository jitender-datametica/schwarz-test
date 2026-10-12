CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_KOSTENART_SPR_ZU_2
-- 22.03.2013 twie: Sprachzuordung für Kostenarten
-- 20.08.2013 twie: mandant_id nicht mit ausgeben

AS
   SELECT
   LTRIM(collate(kostenart_id,''),'0') AS kostenart_id,
   krk_id,
   kostenart_bez

   FROM  dbp_view.v_kostenart_spr_zu_2

   WHERE mandant_id = 1
   AND krk_id='XX01'
   AND spr_id=22
;