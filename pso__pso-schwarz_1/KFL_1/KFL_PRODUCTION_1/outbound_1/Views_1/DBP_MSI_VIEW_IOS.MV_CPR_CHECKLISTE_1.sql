CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_checkliste_1 AS SELECT CL.cpr_checkliste_id,
 CL.projekt_phase_id,
 CL.cpr_ext_id AS checkliste_nr,
 CL.checklistenart_id,
 CAST(NULL AS STRING) AS checkliste_gruppe_id,
 CL.sap_user,
 CL.nicht_relevant_fg,
 CL.dat_aufloesung,
 SU.cpr_suchfeld,
 CL.teil_massn_kz AS teil_massn_fg,
 CL.cpr_systemstatus1_id,
 CL.cpr_systemstatus2_id,
 CL.cpr_systemstatus3_id,
 PR.mandant_id
FROM kfl_production_dbp_view.v_cpr_checkliste_per_1 AS CL
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH ON CL.projekt_phase_id = PH.projekt_phase_id AND PH.dat_bis =
   DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON CL.cpr_suchfeld_id = SU.cpr_suchfeld_id
WHERE CL.dat_bis = DATE '9999-12-31';