CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BAUSTEIN_PER_1
(
   baustein_id
,  mandant_id
,  spr_id
,  baustein_bez
,  dat_von
,  dat_bis
)
AS
   SELECT
     baustein_id,  mandant_id,  spr_id,  baustein_bez,  dat_von,  dat_bis
   FROM dbp_view.v_baustein_per_1
   WHERE mandant_id=1;