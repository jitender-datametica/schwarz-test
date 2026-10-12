CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_HWG_SPR_ZU -- 05.04.2018, AP0021792, srom: OWG Umstellung
  -- 03.02.2020,AP0048407,SPEC0069946,baranowska: hwg_id >= 0 
  (
    hwg_id,
    arthiertyp_id,
    mandant_id,
    spr_id,
    hwg_bez,
    hwg_id_bez
  ) AS
SELECT v01.hwg_id,
  v01.arthiertyp_id,
  v01.mandant_id,
  v01.spr_id,
  v01.hwg_bez,
  CASE
    WHEN v01.hwg_id < 0 THEN TO_VARCHAR(v01.hwg_id, 'FM000')
    ELSE TO_VARCHAR(v01.hwg_id, 'FM000')
  END || ' ' || v01.hwg_bez AS hwg_id_bez
FROM dbp_view.v_hwg_spr_zu v01
WHERE v01.spr_id = 22
  AND v01.arthiertyp_id = 2
  AND v01.hwg_id >= 0;