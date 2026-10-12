CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_verkaufsorganisation -- 13.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,verkaufsorganisation_id
)
AS
SELECT
v01.mandant_id,
v01.verkaufsorganisation_id
FROM dbp_view.v_l_verkaufsorganisation v01;
