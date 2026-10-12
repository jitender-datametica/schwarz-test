CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagerbereich_2 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 lagerbereich_id
,lagernummer_id
,lagertyp_id
,mandant_id
,nb_id
,wup_id
)
AS
SELECT
lagerbereich_id,
lagernummer_id,
lagertyp_id,
mandant_id,
nb_id,
wup_id
FROM dbp_view.v_l_lagerbereich_2;
