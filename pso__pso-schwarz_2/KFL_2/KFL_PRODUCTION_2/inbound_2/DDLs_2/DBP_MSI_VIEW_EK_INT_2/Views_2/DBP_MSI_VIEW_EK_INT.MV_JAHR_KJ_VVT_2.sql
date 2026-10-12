CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_JAHR_KJ_VVT_2 as
   SELECT
     CAST('  ' || kj AS CHAR(6)) as kj
     , akt_kj
     , akt_kj_komplett
   FROM dbp_msi_view_ek_int.mv_tag_2
   GROUP BY 1,2,3;