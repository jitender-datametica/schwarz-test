CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_mat_kjwo_update_1
(
MANDANT_ID,
KJMO,
KJWO_UPDATE
) 
AS
SELECT
mandant_id,
kjmo,
kjwo_update
FROM dbp_view.v_l_kjmo_sort_1
WHERE (mandant_id,kjwo_update) IN (
SELECT
mandant_id,
a500_kjwo_update AS kjwo_update
FROM dbp_msi_data.tupel_mat_1
GROUP BY
mandant_id,
kjwo_update)
AND ((kjwo_update > 202046 AND mandant_id = 1)
OR (kjwo_update >= 202205 AND mandant_id <> 1)
AND NOT (kjwo_update IN (202217, 202218) AND mandant_id = 2));