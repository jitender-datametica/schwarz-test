CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_dim_projekt_projektrolle_pivot_zu_1 (mandant_id, projekt_nr,
zkl_int_obpl, zkl_nat_realis, zkl_nat_entwi, zkl_nat_kalk, zkl_leitprojbe, zkl_nlleiter, zkl_nat_obpl, zkl_nat_source,
zkl_nat_vertrie, zkl_pleinr, zkl_int_sis, zkl_nat_fleisch, zkl_nat_control, zkl_nat_imooer, zkl_sonstiges,
zkl_projektadmi, zkl_nat_projma, zkl_nat_vermiet, zkl_ki_logistik, zkl_nat_logisti) AS SELECT mandant_id,
 projekt_nr,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_INT_OBPL'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_int_obpl,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_REALIS'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_realis,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_ENTWI'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_entwi,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_KALK'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_kalk,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_LEITPROJBE'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_leitprojbe,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NLLEITER'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nlleiter,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_OBPL'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_obpl,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_SOURCE'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_source,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_VERTRIE'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_vertrie,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_PLEINR'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_pleinr,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_INT_SIS'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_int_sis,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_FLEISCH'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_fleisch,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_CONTROL'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_control,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_IMOOER'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_imooer,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_SONSTIGES'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_sonstiges,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_PROJEKTADMI'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_projektadmi,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_PROJMA'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_projma,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_VERMIET'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_vermiet,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_KI_LOGISTIK'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_ki_logistik,
 MAX(CASE
   WHEN projektrolle_cd = 'ZKL_NAT_LOGISTI'
   THEN mitarbeiter_name
   ELSE NULL
   END) AS zkl_nat_logisti
FROM kfl_production_dbp_data.zb_projekt_projektrolle_zu_1
GROUP BY mandant_id,
 projekt_nr;