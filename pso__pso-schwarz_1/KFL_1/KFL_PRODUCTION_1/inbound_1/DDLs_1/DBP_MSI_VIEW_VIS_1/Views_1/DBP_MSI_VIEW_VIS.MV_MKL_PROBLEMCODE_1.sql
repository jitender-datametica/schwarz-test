CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MKL_PROBLEMCODE_1 as
   -- LOOKUP/Sprache Problemcode SRS fuer Mengenkorrekturliste
   -- Basis: SAP Retailstore nur DE (entspricht nicht problemcode)
   -- 20150814 Initial

   SELECT
   pc.mandant_id, pc.problemcode_id, pc.problemcode_bez, pc.kopf_fehler_fg, pc.pos_fehler_fg, pc.mkcheck, pc.faktor, pc.aus_problemcode_id, pc.active

   FROM dbp_view.v_vis_l_problemcode_1 pc
;