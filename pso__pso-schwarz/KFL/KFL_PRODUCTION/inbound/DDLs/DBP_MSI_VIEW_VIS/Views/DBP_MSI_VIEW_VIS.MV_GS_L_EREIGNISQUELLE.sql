CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_EREIGNISQUELLE as
   -- LOOKUP Geschenk-Karten Ereignisquelle
   -- 2011KW46 Initial

   SELECT
   v01.mandant_id, v01.ereignisquelle_id
   FROM dbp_view.v_l_ereignisquelle  v01;