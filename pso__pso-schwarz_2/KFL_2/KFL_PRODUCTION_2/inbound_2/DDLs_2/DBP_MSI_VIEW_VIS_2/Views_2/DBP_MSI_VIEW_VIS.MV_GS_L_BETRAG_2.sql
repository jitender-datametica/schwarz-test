CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_BETRAG_2 as
   SELECT
  v01.mandant_id, v01.ausgeber_typ_id  --> Bereich
   , v01.betrag_von  --> Betrag
   , v01.betrag_bis
   FROM dbp_view.v_l_gs_betrag_2  v01;