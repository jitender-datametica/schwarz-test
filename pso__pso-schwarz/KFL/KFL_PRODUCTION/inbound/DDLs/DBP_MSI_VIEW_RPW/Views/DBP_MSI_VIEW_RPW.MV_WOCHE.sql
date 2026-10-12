CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WOCHE
          (
          gjwo
          ,gjwo_vj
          ,kjwo
          ,kjwo_vj
          ,wo_dat_von
          ,wo_dat_bis
          ,akt_wo
          ,akt_wo_komplett
          ,system_id
          )
          AS
             SELECT
             gjwo,
             gjwo_vj,
             kjwo,
             kjwo_vj,
             wo_dat_von,
             wo_dat_bis,
             akt_wo,
             akt_wo_komplett,
             7 AS system_id
             FROM dbp_view.v_woche
             WHERE kjwo >= 200501
             AND extract(year from wo_dat_von) <= EXTRACT(YEAR FROM CURRENT_DATE);