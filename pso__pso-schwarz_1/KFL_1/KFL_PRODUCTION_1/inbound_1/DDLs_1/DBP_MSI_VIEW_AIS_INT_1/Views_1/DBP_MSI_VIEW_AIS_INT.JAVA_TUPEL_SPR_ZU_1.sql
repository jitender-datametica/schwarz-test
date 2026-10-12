CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_SPR_ZU_1
(
MANDANT_ID,
A500,
MATCHING_ID,
A12,
SPR_ID
) 
AS
SELECT
mandant_id,
kjwo_update AS A500,
matching_id,
tupel_bez AS A12,
spr_id
FROM dbp_view.v_tupel_spr_zu_1;