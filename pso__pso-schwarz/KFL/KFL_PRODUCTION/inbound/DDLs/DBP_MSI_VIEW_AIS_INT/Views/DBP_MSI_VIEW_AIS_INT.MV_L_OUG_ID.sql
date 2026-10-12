CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_OUG_ID
AS
SELECT
mandant_id
,oug_id
FROM dbp_view.v_l_oug_id

UNION ALL

SELECT
mandant_id
,CAST(0 AS NUMBER(38,0)) AS oug_id
FROM dbp_view.v_mandant;