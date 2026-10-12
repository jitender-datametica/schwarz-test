create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_FRAGE_GRP_2(
	SORT_NR
) as
-- 20230831 twie: NSR3932851 neue audimex View für Frage gruppiert auf sort_nr. Dient als Elternattribut von KMR Frage

SELECT 

sort_nr

FROM dbp_view.V_KMR_FRAGE_2

GROUP BY sort_nr;