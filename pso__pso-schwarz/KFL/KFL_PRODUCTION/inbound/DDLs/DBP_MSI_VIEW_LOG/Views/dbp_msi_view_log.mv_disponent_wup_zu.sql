CREATE OR REPLACE VIEW dbp_msi_view_log.mv_disponent_wup_zu -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,wup_id
,nb_id
,disponent_id
,disponent_name
)
AS
SELECT
mandant_id,
wup_id,
nb_id,
disponent_id,
disponent_name
FROM dbp_view.v_disponent_wup_zu;
