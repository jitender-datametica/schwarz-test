CREATE OR REPLACE VIEW dbp_msi_view3.mv_wup_entfernungsmatrix_1
AS
SELECT
WUP_ID_A
, WUP_ID_B
, NB_ID_A
, NB_ID_B
, MANDANT_ID_A
, MANDANT_ID_B
, DISTANZ_FAHRWEG_KM
FROM dbp_view.v_wup_entfernungsmatrix_1;
