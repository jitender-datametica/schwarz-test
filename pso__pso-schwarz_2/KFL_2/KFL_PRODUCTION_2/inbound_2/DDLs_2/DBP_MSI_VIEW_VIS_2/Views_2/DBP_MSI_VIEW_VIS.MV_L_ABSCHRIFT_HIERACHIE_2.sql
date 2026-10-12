CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ABSCHRIFT_HIERACHIE_2 as
   -- LOOKUP Abschrifthierachie
   -- 2011KW37 INITIAL / keine Internationalisierung

   SELECT
   v01.mandant_id, v01.abschriftgrp_hierarchie, v01.abschriftgrp_hierarchie::VARCHAR(40)  AS abschriftgrp_hier_bez, 22::SMALLINT  AS spr_id
   FROM dbp_view.v_l_abschrift_gruppe_2  v01

   GROUP BY
   v01.mandant_id
   , v01.abschriftgrp_hierarchie;