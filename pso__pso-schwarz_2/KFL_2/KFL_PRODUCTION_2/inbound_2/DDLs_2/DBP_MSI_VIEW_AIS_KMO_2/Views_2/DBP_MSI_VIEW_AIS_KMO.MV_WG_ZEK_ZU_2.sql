CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WG_ZEK_ZU_2
-- Filter auf mandant_id > 1 wegen Erweiterung Tabelle bzgl. Security AIS_INT / 08.02.2019 sschuecke
(
  arthiertyp_id
, mandant_id
, wg_id
, zek_id
)
AS
SELECT
arthiertyp_id,
mandant_id,
wg_id,
zek_id

FROM dbp_msi_v_view.v_wg_zek_zu_2
WHERE mandant_id > 1;