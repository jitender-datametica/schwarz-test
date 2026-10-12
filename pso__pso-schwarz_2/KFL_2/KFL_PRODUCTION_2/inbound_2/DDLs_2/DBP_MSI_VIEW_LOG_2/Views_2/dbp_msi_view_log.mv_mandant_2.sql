CREATE OR REPLACE VIEW dbp_msi_view_log.mv_mandant_2
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,mandant_bez
,mandant_kbez
,mandant_sap_id
,default_wrg
,mandant_sort_id
,spaet_lief_tage
)
AS
SELECT
mandant_id,
mandant_bez,
mandant_kbez,
mandant_sap_id,
default_wrg,
mandant_sort_id,
spaet_lief_tage
FROM dbp_view.v_mandant_2;