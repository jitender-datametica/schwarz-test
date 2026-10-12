CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_TECHN_PLATZ AS
-- 13.06.2013 AL Init

   SELECT v01.techn_platz_id
   FROM dbp_view.v_techn_platz_per v01
   WHERE v01.dat_bis='9999-12-31';