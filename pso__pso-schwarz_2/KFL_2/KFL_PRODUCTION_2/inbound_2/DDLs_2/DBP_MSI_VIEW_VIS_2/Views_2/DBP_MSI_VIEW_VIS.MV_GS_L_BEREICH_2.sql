CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_BEREICH_2 as
   SELECT
  v01.mandant_id, v01.ausgeber_typ_id  --> Bereich
   FROM dbp_view.v_l_ausgeber_typ_2  v01;