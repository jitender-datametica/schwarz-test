CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_MANDANT
--15.01.2020 twie: SPECxxx Mandant - 1 hinzu für Appdashboard

AS 
SELECT 
  v01.mandant_sort_id
, v01.mandant_id
, v01.mandant_bez
, v01.mandant_kbez
, v01.default_wrg
, v01.mandant_sap_id
, v01.spaet_lief_tage

FROM dbp_view.v_mandant v01

UNION ALL

SELECT
 99 AS mandant_sort_id
, -1 AS mandant_id
, 'unknown' AS mandant_bez
, '-' AS mandant_kbez
, '' AS default_wrg
, -1 AS mandant_sap_id
, -1 AS spaet_lief_tage

FROM dbp_view.v_mandant v02
WHERE mandant_id = 1
;