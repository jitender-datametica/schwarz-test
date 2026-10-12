CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HERSTELLER
 (
   herst_id
   ,herst_name
   ,mandant_id
   ,strasse
   ,plz
   ,ort
   ,land_id
   ,herst_fg
   ,ampel_flg
   ,system_id
 )
 AS
    SELECT
       g.gp_id,
    gp_name,
    mandant_id,
    gp_strasse,
    gp_plz,
    gp_ort,
    land_id,
    herst_fg,
    1 AS ampel_flg,
    7 AS system_id
    FROM dbp_view.v_gp g
    WHERE mandant_id = 1
      AND herst_fg = 1
 ;