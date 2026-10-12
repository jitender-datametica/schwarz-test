CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_JAHR_KJ
AS
SELECT
kj,
akt_kj,
akt_kj_komplett
FROM dbp_view.v_jahr_kj
WHERE kj>2003;


