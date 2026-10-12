CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_DISPONENT_WUP_ZU_1
(
mandant_id
,wup_id
,nb_id
,disponent_id
,disponent_name
)
AS
   SELECT
  mandant_id, wup_id, nb_id, disponent_id, disponent_name

   FROM dbp_view.v_disponent_wup_zu_1
   WHERE mandant_id = 1
   -- 20100330 Filterung der IWT Betriebe
   AND nb_id <> 99;