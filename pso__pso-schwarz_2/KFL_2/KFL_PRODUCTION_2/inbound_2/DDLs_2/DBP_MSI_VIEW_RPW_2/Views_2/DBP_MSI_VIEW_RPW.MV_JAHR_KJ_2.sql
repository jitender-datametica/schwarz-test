CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_JAHR_KJ_2
       (
       kj
       ,akt_kj
       ,akt_kj_komplett
       ,system_id
       )
       AS
          SELECT
          kj,
          akt_kj,
          akt_kj_komplett,
          7 AS system_id
          FROM dbp_view.v_jahr_kj_2
          WHERE kj >= 2005
          AND kj <= EXTRACT (YEAR FROM CURRENT_DATE);