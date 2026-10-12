CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PRUEFGRUND_1 
-- EK-3088954 pruef_id 220 wurde entfernt 28.09.12/sschuecke --
-- EK-3243293 Anpassung pruef_ids 19.02.13/sschuecke --
-- Einschränkung auf spr_id = 22, da mittlerweile mehrsprachig    16.05.2018/sschuecke
-- SPEC0044639 Erweiterung pruef_id 700,001,005/lsvi0303
-- SPEC0044639 Erweiterung pruef_id 002/lsvi0303
-- SPEC0070820 Erweiterung pruef_id 253/nwag2310
-- INC4333473, dknop, adding z_arbeitsgebiet_id < 4
-- SPEC0147775 Erweiterung pruef_id 254/richternic
(
  pruef_id,
  mandant_id,
  spr_id,
  pruef_bez,
  z_arbeitsgebiet_id
) AS
SELECT
  pruef_id,
  mandant_id,
  spr_id,
  pruef_bez,
  CASE
    WHEN z_arbeitsgebiet_id = 0 THEN 'Z'
    WHEN z_arbeitsgebiet_id = 1 THEN 'S'
    ELSE ' '
  END AS z_arbeitsgebiet_id
FROM
  dbp_view.v_l_pruefgrund_1
WHERE
  pruef_id IN (126,203,204,205,206,207,208,209,210,214,216,218,221,223,225,231,700,001,005,002,253,254)
  AND mandant_id = 1
  AND spr_id = 22
  AND z_arbeitsgebiet_id < 4;