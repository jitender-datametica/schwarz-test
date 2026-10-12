CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_KOSTENART_2
-- 22.03.2013 twie: Lookup für Kostenarten, mandantenunabhängig
-- 20.08.2013 twie: mandant_id nicht mit ausgeben
-- 20.08.2013/Gia

AS
   SELECT LTRIM(COLLATE(kostenart_id,''),'0') AS kostenart_id,
          krk_id,
          kontenplan_id,
          kostenart_altnv_id,
          kostenart_grp_id
   FROM  dbp_view.v_kostenart_2
   WHERE mandant_id = 1
   AND  krk_id='XX01';