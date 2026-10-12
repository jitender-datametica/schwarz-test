CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BESITZSTATUS_SPR_ZU_CZ AS
-- 02.07.2013 twie: Erstellung Lookup Besitzstatus
-- 20.08.2013/Gia

   SELECT
   CASE WHEN dat = CURRENT_DATE -1 THEN 1
   WHEN dat = CURRENT_DATE -2 THEN 0
   ELSE -1 END AS eigentum_kz,
   CASE WHEN dat = CURRENT_DATE -1 THEN 'Eigentum'
   WHEN dat = CURRENT_DATE -2 THEN 'Miete'
   ELSE '' END AS eigentum_bez,
   CASE WHEN dat = CURRENT_DATE -1 THEN 'E'
   WHEN dat = CURRENT_DATE -2 THEN 'M'
   ELSE '' END AS eigentum_kbez

   FROM dbp_view.v_tag
   WHERE dat BETWEEN CURRENT_DATE -2 AND CURRENT_DATE
;