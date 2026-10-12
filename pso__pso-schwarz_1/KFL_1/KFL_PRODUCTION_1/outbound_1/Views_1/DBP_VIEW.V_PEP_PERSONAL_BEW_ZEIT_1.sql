CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_personal_bew_zeit_1 AS SELECT mandant_id,
 idcompany,
 idpersonal,
 dat,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_kom AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_kom,
 zeit_sekunden,
 zeit_kom_orig_fg,
 zeit_geh_orig_fg
FROM kfl_production_dbp_data.pep_personal_bew_zeit_1;