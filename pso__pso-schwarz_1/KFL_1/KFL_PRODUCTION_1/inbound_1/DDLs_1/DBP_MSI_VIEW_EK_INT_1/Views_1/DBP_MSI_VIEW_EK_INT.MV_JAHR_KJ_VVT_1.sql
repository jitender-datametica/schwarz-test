CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_JAHR_KJ_VVT_1 as
   SELECT
     CAST('  ' || kj AS CHAR(6)) as kj
     , akt_kj
     , akt_kj_komplett
   FROM dbp_msi_view_ek_int.mv_tag_1
   GROUP BY 1,2,3;