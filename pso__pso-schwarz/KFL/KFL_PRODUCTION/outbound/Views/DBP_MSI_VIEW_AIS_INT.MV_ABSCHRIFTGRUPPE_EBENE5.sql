CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene5 (abschriftgruppe_id_ebene5) AS
SELECT abschriftgruppe_id AS abschriftgruppe_id_ebene5
FROM kfl_production_dbp_view.v_abschriftgruppe AS V01
WHERE CAST(abschriftgruppe_ebene_kz AS FLOAT64) = 5;