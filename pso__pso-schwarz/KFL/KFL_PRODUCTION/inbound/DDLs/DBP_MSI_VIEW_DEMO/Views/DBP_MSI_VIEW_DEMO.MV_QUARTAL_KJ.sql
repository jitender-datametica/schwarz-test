CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_QUARTAL_KJ
AS
SELECT
kjqu,
akt_kjqu,
akt_kjqu_komplett,
kj,
akt_kj,
akt_kj_komplett
FROM dbp_view.v_quartal_kj
WHERE kjqu>200304;


