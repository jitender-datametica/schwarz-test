CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LGORT_SPR_ZU_1
(
lagerort_bez
,lagerort_id
,mandant_id
,nb_id
,spr_id
)
AS
   SELECT
  lagerort_bez, lagerort_id, mandant_id, nb_id, spr_id
   FROM dbp_view.v_lagerort_spr_zu_1
   WHERE wup_id IN (6902,6903,6905,6906,6907,6908) AND nb_id=-111 AND spr_id=22
   AND lagerort_id NOT IN ('-1', '-2', '-3')
   GROUP BY 1,2,3,4,5;