CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_TECHN_PLATZ_SPR_ZU AS
-- 13.06.2013 AL Init

   SELECT v01.techn_platz_id,
   COALESCE(tech_platz_bez, '') AS techn_platz_bez
   FROM dbp_view.v_techn_platz_per v01
   LEFT JOIN dbp_view.v_techn_platz_spr_zu_per v02
   ON v01.techn_platz_id = v02.techn_platz_id AND
   v02.dat_bis= '9999-12-31' AND
   v02.spr_id=22
   WHERE v01.dat_bis= '9999-12-31';