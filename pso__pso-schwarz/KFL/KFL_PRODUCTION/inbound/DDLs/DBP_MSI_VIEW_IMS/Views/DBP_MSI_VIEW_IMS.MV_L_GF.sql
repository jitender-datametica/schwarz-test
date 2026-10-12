CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GF AS
-- 14.06.2013 twie: Erstellung Lookup für GF

   SELECT

   gf_id,
   mandant_id,
   CASE WHEN gf_id IN (0,-1) THEN ''
   ELSE gf_name
   END AS gf_name

   FROM dbp_view.v_gf

   WHERE ek_fg = 0;