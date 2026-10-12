CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ABSCHRIFTART as
   -- LOOKUP Abschriftart (National)
   -- 2011KW37: Initial Abschriftart
   -- 2017.0221 Update (Abschriftart Int)

   SELECT
   v01.mandant_id, v01.abschriftart_id
   FROM dbp_view.v_l_abschriftart  v01
;