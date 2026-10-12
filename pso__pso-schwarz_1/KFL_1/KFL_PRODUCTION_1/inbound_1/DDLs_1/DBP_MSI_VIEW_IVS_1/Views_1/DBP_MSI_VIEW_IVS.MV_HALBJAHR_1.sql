CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_HALBJAHR_1 as
              SELECT
 DISTINCT CASE WHEN MOD( kjmo, 100) <= 6 THEN 1 ELSE 2 END AS hj,
              CASE WHEN MOD( kjmo, 100) <= 6 THEN '1. Halbjahr' ELSE '2. Halbjahr' END AS hj_bez

              FROM dbp_view.v_monat_1;