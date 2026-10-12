CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LIEFERANTEN_STAMMKONDITION
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

   FROM dbp_view.v_lieferanten_stammkondition
   WHERE mandant_id = 1;