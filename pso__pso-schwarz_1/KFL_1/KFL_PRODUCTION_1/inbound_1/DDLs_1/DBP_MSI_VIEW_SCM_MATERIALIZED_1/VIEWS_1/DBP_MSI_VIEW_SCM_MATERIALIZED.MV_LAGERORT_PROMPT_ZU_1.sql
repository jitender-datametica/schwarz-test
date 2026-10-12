create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_LAGERORT_PROMPT_ZU_1(
	MANDANT_ID,
	LAGERORT_ID,
	LAGERORT_UID
) as
SELECT


mandant_id,
lagerort_id,
MAX( CASE
    WHEN (mandant_id = 1 AND lagerort_id IN ('3','34'))
     OR (mandant_id <> 1 AND lagerort_id = '0001')
    THEN 1
    WHEN (mandant_id = 1 AND lagerort_id IN ('0','1'))
     OR (mandant_id <> 1 AND lagerort_id = '0003')
    THEN 2

    WHEN (mandant_id = 1 AND lagerort_id = '4')
     OR (mandant_id = 6 AND lagerort_id = '0006')
     OR (mandant_id = 5 AND lagerort_id = '0044')
     OR (mandant_id = 3 AND lagerort_id = '1004')
     OR (mandant_id IN (2,3,4,7,8) AND lagerort_id = '0004')
    THEN 3

    WHEN (mandant_id = 1 AND lagerort_id = '2')
     OR (mandant_id <> 1 AND lagerort_id = '0005')
    THEN 4

    WHEN (mandant_id = 1 AND lagerort_id = '6')
     OR (mandant_id <> 1 AND lagerort_id = '0002')
    THEN 5

   WHEN (mandant_id = 1 AND lagerort_id = '7')
     OR (mandant_id <> 1 AND lagerort_id = '0007')
    THEN 6
ELSE NULL END) AS lagerort_uid

FROM dbp_view.v_l_lagerort_1 WHERE nb_id=-111
GROUP BY mandant_id, lagerort_id
HAVING lagerort_uid IS NOT NULL;