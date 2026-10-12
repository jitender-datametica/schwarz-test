CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_werbeware_1 

AS
--27.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage_1
--2023-05-23, AP0161535, dknop, removing mandant_id

SELECT
v01.werbeware_id
FROM dbp_view.v_l_werbeware_1 v01
GROUP BY v01.werbeware_id;
