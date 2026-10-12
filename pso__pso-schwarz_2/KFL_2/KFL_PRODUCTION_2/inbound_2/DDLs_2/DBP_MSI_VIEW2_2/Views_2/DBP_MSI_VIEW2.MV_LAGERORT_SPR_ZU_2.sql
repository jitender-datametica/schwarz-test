CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAGERORT_SPR_ZU_2
(
lagerort_bez
, lagerort_id
, mandant_id
, nb_id
, spr_id
, wup_id
)
AS
   SELECT
   v01.wup_id||' '||v01.lagerort_bez AS lagerort_bez, v01.lagerort_id, v01.mandant_id, v01.nb_id, v01.spr_id, v01.wup_id
   FROM dbp_view.v_lagerort_spr_zu_2 v01
   WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3')
   AND mandant_id = 1;