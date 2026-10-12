CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_disponent_2 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,disponent_id
)
AS
SELECT
mandant_id,
disponent_id
FROM dbp_view.v_l_disponent_2;
