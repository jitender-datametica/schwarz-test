CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_LEIST_2
(
leist_id
,leist_bez
,mandant_id
,spr_id
)
AS
   SELECT
   CASE WHEN leist_id='' THEN 'keine' ELSE leist_id END, leist_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_leist_2
   WHERE leist_id NOT IN ('N','N2','N3','O1','O2','O3','WA','WB','WC','WD')
   AND mandant_id = 1
   AND spr_id = 22;