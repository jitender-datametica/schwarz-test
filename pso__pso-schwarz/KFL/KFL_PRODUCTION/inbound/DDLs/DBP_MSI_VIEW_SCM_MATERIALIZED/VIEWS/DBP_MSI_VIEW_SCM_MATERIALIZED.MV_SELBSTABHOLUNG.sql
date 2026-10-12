create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_SELBSTABHOLUNG(
	SELBSTABHOLUNG_FG
) as 
SELECT 1 AS selbstabholung_fg
UNION 
SELECT 0 AS selbstabholung_fg;