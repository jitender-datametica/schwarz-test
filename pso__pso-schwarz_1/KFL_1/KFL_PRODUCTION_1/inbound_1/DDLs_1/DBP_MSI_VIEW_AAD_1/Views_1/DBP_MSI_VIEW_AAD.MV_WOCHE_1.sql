CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_WOCHE_1 AS
--14.06.2023 twie: SPEC0200542 Lookup Woche_1
SELECT
   kjwo,
   gjwo,
   kjwo_vj,
   gjwo_vj,
   kjwo - 200 AS KJWO_VVJ,
   gjwo - 200 AS GJWO_VVJ,
   akt_wo_kalendarisch, 
   TRUNC(kjwo/100::SMALLINT) AS KJ,
   TRUNC(gjwo/100::SMALLINT) AS GJ,
   akt_wo,
   akt_wo_komplett,
   'WW' || CAST(kjwo AS VARCHAR(6)) AS ww_bez
FROM dbp_view.v_woche_1
WHERE kjwo >= 202301;