CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_AUFTRAG_PPS_2 as
   SELECT
   v01.auftrag_id, v01.mandant_id, v01.dat_start, v01.auftrag_rm_id, v01.auftrag_rm_pos_id, v01.dat_planaufloesung
   FROM dbp_view.v_in_auftrag_pps_2 v01
;