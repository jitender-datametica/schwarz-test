CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WG_WUP_SM_ZU_PER_1
(
mandant_id
, wup_id
, wg_id
, nb_id
, dat_von
, arthiertyp_id
, dat_bis
, sm_id
)
AS
   SELECT
   mandant_id, wup_id, wg_id, nb_id, dat_von, arthiertyp_id, dat_bis, sm_id

   FROM dbp_view.v_sm_wup_wg_zu_per_1
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
   AND dat_bis = '9999-12-31'
   -- 20100330 Filterung der IWT Betriebe
   AND nb_id <> 99
;