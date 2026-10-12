CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_SORT_MONAT_WOCHE_2
AS
SELECT
kjmo_sort,
kjwo_sort_von,
kjwo_sort_bis,
dat_sort_von,
dat_sort_bis,
sort_monate,
kjwo_sort_von_kpi,
kjwo_sort_bis_kpi,
dat_sort_von_kpi,
dat_sort_bis_kpi,
sort_monate_kpi
FROM dbp_msi_data.sort_monat_woche_2;



