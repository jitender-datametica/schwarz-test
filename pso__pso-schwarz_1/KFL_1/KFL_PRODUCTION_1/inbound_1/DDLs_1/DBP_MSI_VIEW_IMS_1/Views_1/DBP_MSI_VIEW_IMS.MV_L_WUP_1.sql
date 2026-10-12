CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_WUP_1 AS
-- 11.04.2013 twie Erstellung Lookup Filiale
-- 03.06.2013 twie wup_name_v durch wup_standort als bez ersetzt
-- 14.06.2013 twie VKL_1 und VS_1 (=GL) hinzugefügt
-- 10.05.2017 twie SPEC0023705 Geoattribut

   SELECT
   wup_id,
   mandant_id,
   nb_id,
   CASE WHEN wup_id IN (0,-1) THEN ''
   ELSE wup_standort
   END AS wup_standort,
   COALESCE(vkl_id, -1) AS vkl_id,
   COALESCE(vs_id, 0) AS vs_id,
   laengengrad,
   breitengrad

   FROM dbp_view.v_wup_1;