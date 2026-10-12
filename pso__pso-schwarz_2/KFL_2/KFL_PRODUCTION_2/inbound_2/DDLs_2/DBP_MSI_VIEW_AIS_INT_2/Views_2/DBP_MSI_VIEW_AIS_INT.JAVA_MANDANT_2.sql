CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_MANDANT_2
(
MANDANT_ID,
MANDANT_BEZ,
MANDANT_KBEZ,
DEFAULT_WRG
) 
AS
SELECT
mandant_id,
mandant_bez,
mandant_kbez,
default_wrg
FROM dbp_view.v_mandant_2
WHERE mandant_id NOT IN (4);