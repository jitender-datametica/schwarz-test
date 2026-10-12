CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_LIEFERANT_SPR_ZU
(
MANDANT_ID,
A500,
A16,
SPR_ID,
A418
) 
AS
SELECT
mandant_id,
kjwo_update AS A500,
akt_lieferant_id AS A16,
spr_id,
akt_lieferant_bez AS A418
FROM dbp_view.v_sort_lieferant_spr_zu;