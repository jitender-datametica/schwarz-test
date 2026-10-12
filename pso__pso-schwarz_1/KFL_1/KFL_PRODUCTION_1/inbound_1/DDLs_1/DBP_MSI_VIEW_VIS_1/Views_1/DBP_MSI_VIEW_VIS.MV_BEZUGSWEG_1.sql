CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BEZUGSWEG_1 as
   -- LOOKUP Bezugsweg
   -- 2011KW46: Initial
   -- 2012KW42PU Neue Lookup-Tabelle

   SELECT
   v01.mandant_id, v01.bezugsweg_id

   FROM dbp_view.v_l_bezugsweg_1 v01;