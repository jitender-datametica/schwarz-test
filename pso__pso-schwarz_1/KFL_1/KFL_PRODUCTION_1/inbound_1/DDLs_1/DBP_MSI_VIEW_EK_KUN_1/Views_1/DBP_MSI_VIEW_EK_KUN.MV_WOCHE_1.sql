CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_WOCHE_1
-- 190503 nfis: Initialanlage
AS
SELECT
gjwo
,gjwo_vj
,kjwo
,kjwo_vj
,wo_dat_von
,wo_dat_bis
,akt_wo
,akt_wo_komplett
,akt_wo_kalendarisch
FROM dbp_view.v_woche_1
;