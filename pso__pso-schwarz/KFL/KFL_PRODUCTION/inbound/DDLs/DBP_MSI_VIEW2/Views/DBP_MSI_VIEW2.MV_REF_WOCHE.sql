CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REF_WOCHE (
 kjwo
,kjwo_ref
,abstand
)
AS
   SELECT
    w1.kjwo, w2.kjwo, w1.akt_wo_kalendarisch - w2.akt_wo_kalendarisch
   FROM dbp_msi_view2.mv_woche w1, dbp_msi_view2.mv_woche w2;