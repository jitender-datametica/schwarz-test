CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_SCM_ART_CLUSTER_ZU_1
    (MANDANT_ID,
    ART_ID,
    ART_CLUSTER_ID,
    ART_CLUSTER_ZU_FG)
AS
-- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion
-- 25.06.2021, nwag2310, AP0084960, SPEC0104182 - Only non-deleted Clusters
-- Der komplette Artikelstamm wird den Clustern zugeordnet
-- Als Default -99, wenn keine manuelle Zuordnung erfolgt
-- 15.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
-- 19.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
-- 25.02.2025, nwag2310, switch to dyn. table
SELECT
    MANDANT_ID,
    ART_ID,
    ART_CLUSTER_ID,
    ART_CLUSTER_ZU_FG
FROM DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_ART_CLUSTER_ZU_1;