CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_GRUPPE as
   -- ZUORDNUNG Abschriftart - Abschriftgruppe
   -- 2011KW37: Initial mit Abschriftart

   SELECT
   v01.mandant_id, v01.abschriftart_id, v01.abschriftgruppe_id
   FROM dbp_view.v_abschriftart_abschriftgrp_zu  v01;