CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LIEFERANTEN_STAMMKONDITION_1
(
gp_id
,kondgrp_id
,dat_von
,kond_art
,dat_bis
,Lief_Wert
,Lief_Proz
)
AS
   SELECT
  gp_id, kondgrp_id, dat_von, kond_art, dat_bis, wert, prozent

   FROM dbp_view.v_lieferanten_stammkondition_1
   WHERE mandant_id = 1;