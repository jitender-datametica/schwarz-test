CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TP_L_OBJEKT as
   SELECT
   v01.mandant_id, v01.tp_objekt_id
   FROM dbp_view.v_tp_l_objekt v01
;