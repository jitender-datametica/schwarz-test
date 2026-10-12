CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ABSCHRIFT_GRUPPE as
   -- LOOKUP/ZUORDNUNG Abschrift-Gruppe / Hierachie
   -- 2011KW37: Initial

   SELECT
   v01.mandant_id, v01.abschriftgruppe_id, v01.abschriftgrp_hierarchie
   FROM dbp_view.v_l_abschrift_gruppe  v01
;