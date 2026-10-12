CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTGRP_HIERACHIE_1 as
   -- LOOKUP/SPRACHE Abschrift / Hierachie
   -- momentan nur auf deutsch (22)
   -- 2010KW28 INITIAL
   -- 20110211 Filter: abschriftgrp_hierarchie = 'hier02'

   SELECT
   v01.mandant_id, v01.abschriftgrp_hierarchie, v01.abschriftgrp_hierarchie::VARCHAR(40)  AS abschriftgrp_hier_bez, 22::SMALLINT  AS spr_id

   FROM dbp_view.v_l_abschrift_gruppe_1  v01

   WHERE v01.abschriftgrp_hierarchie = 'hier02'

   GROUP BY
   v01.mandant_id
   , v01.abschriftgrp_hierarchie;