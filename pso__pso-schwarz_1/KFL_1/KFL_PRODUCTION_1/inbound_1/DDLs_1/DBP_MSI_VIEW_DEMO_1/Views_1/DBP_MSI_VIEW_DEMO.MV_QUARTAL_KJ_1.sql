CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_QUARTAL_KJ_1
AS
SELECT
kjqu,
akt_kjqu,
akt_kjqu_komplett,
kj,
akt_kj,
akt_kj_komplett
FROM dbp_view.v_quartal_kj_1
WHERE kjqu>200304;


