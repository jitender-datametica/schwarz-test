CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_EIGENMARKE_2
 (
   eigenmarke_id
   ,eigenmarke_bez
   ,mandant_id
   ,spr_id
   ,system_id
 )
 AS
    SELECT
      eigenmarke_id,
    eigenmarke_bez,
    mandant_id,
    spr_id,
    7
    FROM dbp_view.v_artkz_eigenmarke_2
    WHERE mandant_id = 1
 ;